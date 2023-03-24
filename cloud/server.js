// Imported Libraries
const path = require('path');
const fs = require('fs');
const express = require('express');
const multer = require("multer");
const axios = require('axios');
const net = require('net');
const sound = require("sound-play");
const Database = require('./Database.js');
const ffmpegPath = require('@ffmpeg-installer/ffmpeg').path;
const ffmpeg = require('fluent-ffmpeg');
// const node-aplay = require('node-aplay');
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
			.then(response => {console.log(response.data); return response.data})
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
	
	// TO DO: PLAY SONG located on 'uploads/${req.query.name}.wav' on react app
	// sound.play("uploads/${req.query.name}.wav");
	// get a file from the uplaods folder
	var tempSong = req.query.name;
	sound.play(`uploads/${tempSong}.wav`).then((response) => console.log(tempSong));
		
	db.getSong("defaultUser", req.query.name).then((data) => {
		res.send(JSON.stringify(data));
		// sound.play("uploads/${req.query.name}.wav");
		// console.log("inside get song data");
		// var audio = new Audio('uploads/${req.query.name}.wav');
		// audio.play();
		// if(typeof Audio != "undefined") {
		// 	// Browser-only code
		// 	var audio = new Audio('uploads/${req.query.name}.wav');
		// 	audio.play();
		//   }

	})
});

// app.get("/get_song_audio", (req, res) => {
	
// 	// TO DO: PLAY SONG located on 'uploads/${req.query.name}.wav' on react app
// 	// sound.play("uploads/${req.query.name}.wav");
// 	// get a file from the uplaods folder
// 	var tempSong = req.query.name;
// 	sound.play(`uploads/${tempSong}.wav`).then((response) => console.log(tempSong));
		
// 	db.getSong("defaultUser", req.query.name).then((data) => {
// 		res.send(data);
// 	})
// });
// console.log(path.join(__dirname, "uploads"));

app.use("/get_audio_file", express.static(path.join(__dirname, "uploads")));


// Runs the server
app.listen(port, () => {
	console.log(`${new Date()}  App Started. Listening on ${host}:${port}`);
});