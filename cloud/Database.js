const { MongoClient, ObjectId} = require('mongodb');	// require the mongodb driver

/**
 * Function Purpose: Creates a new Database object
 * Input: mongoUrl - the url of the mongo database
 * 	      dbName - the name of the database
 * Output: Database object
 * 
 * Utilizes code Provided code in CPEN 322 Assignment 4
 */
function Database(mongoUrl, dbName){
	if (!(this instanceof Database)) return new Database(mongoUrl, dbName);
	this.connected = new Promise((resolve, reject) => {
		MongoClient.connect(
			mongoUrl,
			{
				useNewUrlParser: true
			},
			(err, client) => {
				if (err) reject(err);
				else {
					console.log('[MongoClient] Connected to ' + mongoUrl + '/' + dbName);
					resolve(client.db(dbName));
				}
			}
		)
	});
	this.status = () => this.connected.then(
		db => ({ error: null, url: mongoUrl, db: dbName }),
		err => ({ error: err })
	);
}

/*
* Function Purpose: Adds the song data object and lyrics to the database 
* Input: filename - the name of the file
* 		 songData - the song data object
* 		 lyrics - the lyrics of the song
*/
Database.prototype.addSong = function(user, filename, songData, lyrics){
	return this.connected.then(db =>
		db.collection('songs').insertOne({
			user: user,
			filename: filename,
			songData: songData,
			lyrics: lyrics
		})
	);
}	 

/*Returns the songData object for the song with the given the user and filename*/
Database.prototype.getSong = function(user, filename){
	return this.connected.then(db =>
		new Promise((resolve, reject) => {
			db.collection('songs').findOne({
				user: user,
				filename: filename
			})
			.then(song => resolve({songData: song.songData, lyrics: song.lyrics}))
		})	
	);
}

//Return all the filenames under a user
Database.prototype.getSongList = function(user){
	return this.connected.then(db =>
		new Promise((resolve, reject) => {
			// Get all the entries with the given user
			//  return an array made up of the filename field

			db.collection('songs').find({ user: user }).toArray()
			.then(songs => {
				let arr = [];
				songs.forEach(element => {
					arr.push(element.filename);
				});

				resolve(arr);
			})
		})
	);
}
module.exports = Database;