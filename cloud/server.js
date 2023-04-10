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

let AUDIO_API = '0bf1edd22b592bdc7cbbe9e37fa37c0e';
let MUSIC_API = '0d677468618ecf74a7748aa122362c5f';

// Purpose: Creates the path for the file upload if it does not exist
// Input: path to the file
// OUTPUT: path to the file
const createPath = (path) => {
	if (!fs.existsSync(path)) {
		fs.mkdirSync(path, { recursive: true });
	}
	return path;
}

// Purpose: Defines the multer specifications for the file upload. It specifies the destination and the name of the file
// Storage Setup based on the multer documentation (https://github.com/expressjs/multer#diskstorage)
const upload = multer({
	storage: multer.diskStorage({
		// TO DO: change adress to be user specific	
		destination: (req, file, cb) => { cb(null, createPath(`play/${req.body.username}`)) },
		filename: (req, file, cb) => { cb(null, `${req.body.name}.mp3`) }
	})
});

// Function Purpose: Converts the mp3 file to a wav file
// Input: name of the mp3 file
// OUTPUT: Resolves promise and tells the server to move on to the next step
const convertType = (folder,name) => {

	return new Promise((resolve, reject) => {
		ffmpeg(`play/${folder}/${name}.mp3`)
		.audioCodec('pcm_s16le')
		.audioFrequency(4000)
		.audioChannels(1)
		.audioBitrate('32k')
		.outputOptions('-compression_level 12')
		.toFormat('wav')
		.output(`${createPath(`uploads/${folder}`)}/${name}.wav`)
		.on('end', () => resolve())
		.run()
	})


}

// Function Purpose: Trims the song to the specified length and saves it to the tmp folder
// Input: name of the mp3 file, length of the song in seconds
// OUTPUT: Passes the location of the trimmed song in the resolve of the promise
const trimSong = async (folder, name, seconds) => {
	return new Promise((resolve, reject) => {
		ffmpeg(`uploads/${folder}/${name}`)
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
const identifySong = (folder, name) => {
	return new Promise((resolve, reject) => {
		// Calls the trimSong function to trim the song to 15 seconds, resolve the promise with the path of the trimmed song
		trimSong(folder, name, 15)
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

const parseFile = (path, size) => {
	
	return new Promise((resolve, reject) => {
		fs.readFile(path, (err, data) => {
			if (err) reject('Error reading file:', err);
		  
			// Converts the data to a hex string
			const hexString = data.toString('hex').toUpperCase();
	
			// Hex Parsing Based on https://stackoverflow.com/questions/6259515/how-can-i-split-a-string-into-segments-of-n-characters
			const hexArray = hexString.match(RegExp(`.{1,${size - 2}}`, 'g'))
	
			// Adds the start character '!' to each packet
			// Adds the end character '?' to each packet
			// Adds the end character '~' instead of '?' to the last packet
			const packetArray = hexArray.map((string, i) => (i == hexArray.length - 1) ? `!${string}~` : `!${string}?`);
			
			resolve(packetArray);
		})
	})
}

// Express app: sets up middleware for express
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Sets up access for html,css,app.js file for server to load the client
app.use('/', express.static('client/build'));
app.use('/login', express.static('client/build'));
app.use('/register', express.static('client/build'));

// 
app.post('/loginRequest', (req, res) => {
	// Check if login is valid
	db.checkUser(req.body.username, req.body.password).then((result) => {
		res.send({login: result});
	});
});

// setUp registeration post request
app.post('/registerRequest', (req, res) => {
	db.addUser(req.body.username, req.body.password);
	res.send({registration: true});
});

// Uploads the file to the server
app.post("/upload_files", upload.single("file"), (req, res) => {
	convertType(req.body.username,req.body.name).then(() => {
		identifySong(req.body.username, `${req.body.name}.wav`).then((songData) => {

			getLyrics(songData.result.title, songData.result.artist).then((lyrics) => {
				
				db.addSong(req.body.username, req.body.name, songData.result, lyrics);
				res.send(JSON.stringify({ filename: req.body.name }));

			})
		})

	});

});

// GET Request to get the list of files in the uploads folder
app.get("/file_list", (req, res) => {
	// make database quey to get fiellist
	db.getSongList(req.query.username).then((data) => {
		res.send(JSON.stringify(data));
	})
});

const sendFile = () => {
	parseFile(`uploads/alice.txt`,20)
	// parseFile(`uploads/${req.query.name}.wav`, 1024)
	.then( packetArr => {
		const ip = '192.168.137.78';
		const port = 80;
		let pakcetNum = 0;
		console.log(packetArr)

		// Make a TCP connection with ESP8266 and send the first packet
		const myConnect = net.createConnection({ host: ip, port: port }, () => {
			console.log(`Connected to ${ip}:${port}`);

			console.log(`Sending packet: ${pakcetNum + 1}/${packetArr.length}`);
			myConnect.write(packetArr[pakcetNum]);
		});

		// When the ESP8266 sends an acknowledgment, send the next packet
		// When the last packet is sent, close the connection
		myConnect.on('data', data => {
			console.log(`Acknowledgment received: ${pakcetNum + 1}`);
			console.log(data.toString());
			if (pakcetNum < packetArr.length - 1) {
				setTimeout(() => {
					pakcetNum++;
					console.log(`Sending packet: ${pakcetNum + 1}/${packetArr.length}`);
					myConnect.write(packetArr[pakcetNum]);
				}, 1000); 
			} else {
				console.log("Done")
				myConnect.end();
			}
		});

		// If there is an error, close the connection
		myConnect.on('error', (err) => {
			console.error(err);
			myConnect.end();
		});
		

	})
	.catch((message, err) => console.log(message, err));
}

const TCPConnection = (name) => {
	const ip = '192.168.137.78';
	const port = 80;

	// Connect to the server
	const myConnect = net.createConnection({ host: ip, port: port }, () => {
		console.log(`Connected to ${ip}:${port}`);
		myConnect.write(`!${name}?`);
		myConnect.end();
	});

	myConnect.on('error', (err) => {
		console.error(err);
	});

}

// GET Request to get the data for a specific song
app.get("/get_song_data", (req, res) => {	

	var songOne = "!1111111111~";
	var songTwo = "!2222222222~";
	var songThree = "!3333333333~";
	var songFour = "!4444444444~";
	var songFive= "!5555555555~";

	// TCPConnection("!5555541555554155555415555541555554155555415555541555554155555415555541555554155555415555541555554155555415555541~");
	// sendFile();
	// TCPConnection(`q`);
	db.getSong(req.query.username, req.query.name).then((data) => {

		// if(req.query.name === 'ThatWay'){
		// 		TCPConnection("!11111111~");
		// 		console.log("Sent song one.");
		// 	}
		// else if(req.query.name == 'Dont'){
		// 		TCPConnection(songTwo);
		// }
		// else if(req.query.name == 'bbt'){
		// 		TCPConnection(songThree);
		// }
		// else if(req.query.name == 'd'){
		// 		TCPConnection(songFour);
		// }
		// else if(req.query.name == 'e'){
		// 		TCPConnection(songFive);
		// }

		res.send(JSON.stringify(data));

	})
});

app.use("/get_audio_file", express.static(path.join(__dirname, "uploads")));


// Runs the server
app.listen(port, () => {
	console.log(`${new Date()}  App Started. Listening on ${host}:${port}`);
});