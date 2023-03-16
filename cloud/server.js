// Imported Libraries
const path = require('path');
const fs = require('fs');
const express = require('express');
const multer = require("multer");
const axios = require('axios');
const net = require('net');
const Database = require('./Database.js');
const ffmpegPath = require('@ffmpeg-installer/ffmpeg').path;
const ffmpeg = require('fluent-ffmpeg');
ffmpeg.setFfmpegPath(ffmpegPath);

// Paths Used by the server
const host = 'localhost';
const port = 8000;
let db = new Database("mongodb://0.0.0.0:27017", "SongDB");

let AUDIO_API = '41693fd1726e50e10211848a6b4b46cf';
let MUSIC_API = '0d677468618ecf74a7748aa122362c5f';

// Purpose: Defines the multer specifications for the file upload. It specifies the destination and the name of the file
// Storage Setup based on the multer documentation (https://github.com/expressjs/multer#diskstorage)
const upload = multer({
	storage: multer.diskStorage({
		// TO DO: change adress to be user specific	
		destination: (req, file, cb) => { cb(null, 'tmp/') },
		filename: (req, file, cb) => { cb(null, `${req.body.name}.mp3`) }
	})
});

// Function Purpose: Converts the mp3 file to a wav file
// Input: name of the mp3 file
// OUTPUT: Resolves promise and tells the server to move on to the next step
const convertType = (name) => {

	return new Promise((resolve, reject) => {
		ffmpeg(`tmp/${name}.mp3`)
			.audioCodec('pcm_s16le')
			.audioFrequency(8000)
			.audioChannels(1)
			.audioBitrate('32k')
			.outputOptions('-compression_level 12')
			.toFormat('wav')
			.output(`uploads/${name}.wav`)
			.on('end', () => {
				fs.unlink(`tmp/${name}.mp3`, (err) => {
					if (err) console.log(err);
				});

				resolve();
			})
			.run()
	})


}

// Function Purpose: Trims the song to the specified length and saves it to the tmp folder
// Input: name of the mp3 file, length of the song in seconds
// OUTPUT: Passes the location of the trimmed song in the resolve of the promise
const trimSong = async (name, seconds) => {
	return new Promise((resolve, reject) => {
		ffmpeg(`uploads/${name}`)
		.inputOption(`-t ${seconds}`)
		.output(`tmp/${name}`)
		.on('end', () => {
			resolve(`tmp/${name}`)
		})
		.run();
	})
}

// Function Purpose: Gets the song data from the Audd.io API
// Input: name of the mp3 file
// OUTPUT: Passes the data from the API in the resolve of the promise
const identifySong = (name) => {
	return new Promise((resolve, reject) => {
		// Calls the trimSong function to trim the song to 15 seconds, resolve the promise with the path of the trimmed song
		trimSong(name, 15)
		.then(path => {
			// Sends the data to the API and returns the data
			// API call based on documentation (https://docs.audd.io/)
			let songData = axios({
				method: 'post',
				url: 'https://api.audd.io/',
				data: {
					'api_token': AUDIO_API,
					'file': fs.createReadStream(path),
				},
				headers: { 'Content-Type': 'multipart/form-data' },
			})
			.then(response => response.data)
			.catch(error => console.log(error));
			// Returns the path of the trimmed song and the data from the API to pass to the next promise
			return { path: path, songData: songData }
		})
		.then(result => {
			// delete a file from tmp folder (Came from: https://www.bezkoder.com/node-js-delete-file/) and return the data
			fs.unlink(result.path, (err) => {
				if (err) console.log(err);
			});
			// Returns the data from the API as a Promise.resolve()
			resolve(result.songData)
		})
	});

}

// Function Purpose: Gets the lyrics from the Musixmatch API
// Input: name of the song, name of the artist
// OUTPUT: Passes the lyrics from the API in the resolve of the promise
const getLyrics = (name, artist) => {
	return new Promise((resolve, reject) => {
		axios({
			method: 'get',
			url: 'https://api.musixmatch.com/ws/1.1/matcher.lyrics.get',
			params: {
				q_track: name,
				q_artist: artist,
				apikey: MUSIC_API
			}
		})
		.then(response => resolve(response.data.message.body.lyrics))
		.catch(error => console.log(error));
	})
}

const TCPConnection = (name) =>{
	const ip = '192.168.1.1';
	const port = 80;

	// Connect to the server
	const myConnect = net.createConnection({ host: ip, port: port }, () => {
		console.log(`Connected to ${ip}:${port}`);
		
		// myConnect.write(`Paragraph 1: The sun was setting over the horizon, painting the sky with a breathtaking array of oranges, pinks, and purples. The air was still and calm, and a gentle breeze rustled through the trees. The chirping of birds could be heard in the distance, and the sound of a distant stream added to the peaceful ambiance. As the darkness crept in, the stars began to twinkle in the sky, illuminating the world with a quiet beauty.\n\nParagraph 2: Sarah had always been fascinated by the ocean. She loved the way the waves crashed against the shore, the salty smell of the sea, and the feel of the sand between her toes. Whenever she had a chance, she would spend hours walking along the beach, collecting shells and watching the seabirds.`);
		// let arr = []
		// for (let i = 33; i <= 126; i++) {
		// 	arr.push(i);
		//   }	
		// console.log(arr.length)
		// let BetterArr = new Uint8Array(arr);
		// myConnect.write(BetterArr);


		myConnect.write(`uplods/${name}.wav`);


		myConnect.end();

		// File Stream connection
		// myConnect.pipe("H");
		// fileStream.on('end', () => {
		// 	console.log('File sent');
		// 	client.end();
		//   });
	});

	myConnect.on('error', (err) => {
		console.error(err);
	});

}
// Express app: sets up middleware for express
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Sets up access for html,css,app.js file for server to load the client
app.use('/', express.static('client/build'));

// Uploads the file to the server
app.post("/upload_files", upload.single("file"), (req, res) => {
	convertType(req.body.name).then(() => {

		identifySong(`${req.body.name}.wav`).then((songData) => {

			getLyrics(songData.result.title, songData.result.artist).then((lyrics) => {

				db.addSong("defaultUser", req.body.name, songData.result, lyrics);
				res.send(JSON.stringify({ filename: req.body.name }));

			})
		})

	});

});

// GET Request to get the list of files in the uploads folder
app.get("/file_list", (req, res) => {
	// make database quey to get fiellist
	db.getSongList("defaultUser").then((data) => {
		res.send(JSON.stringify(data));
	})
});

// GET Request to get the data for a specific song
app.get("/get_song_data", (req, res) => {
	// Make API request that sends HELLO to 10.43.73.30:80 using axios

	TCPConnection(req.query.name)
	// get a file from the uplaods folder
	db.getSong("defaultUser", req.query.name).then((data) => {
		res.send(JSON.stringify(data));
	})
});

// Runs the server
app.listen(port, () => {
	console.log(`${new Date()}  App Started. Listening on ${host}:${port}`);
});