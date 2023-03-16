import React, {useState, useEffect}  from "react";
import Select from 'react-select';

import './songSelectForm.css';

function SongSelectForm ({fileList}) {

    const [songDetails, setsongDetails] = useState(null);
    const [song, setSong] = useState(null);

    // Run Code Every Time fileList is Updated
    useEffect(() => {
      console.log(songDetails);
    },[songDetails])

    const getSongData = () => {
        if (song != null){
            fetch(`http://localhost:8000/get_song_data?name=${song}`)
            .then(res => res.json()).then(data => {
                setsongDetails(data);
            })
            .catch(err => console.log(err));
        }
    }

    return (
        <>
            <div className="row selectSong">
                <div className="col-md-9">
                    <Select
                        className="DDContainer"
                        classNamePrefix="dropdown" 
                        options={ fileList.sort().map(file => { return {label: file, value: file} })}
                        onChange={e => setSong(e.value)}
                    />
                </div>
                <div className="col-md-3">
                    <a id="playButton" className={song != null ? "playActive" : "playInactive"} onClick={getSongData}>Get Song Data</a>
                </div>
            </div>
            <div className="row songContent">
                {songDetails != null ? <h1>{songDetails.songData.title}</h1>: null}
                {songDetails != null ? <h2>{songDetails.songData.artist}</h2>: null}
                {songDetails != null ? <p>{songDetails.lyrics.lyrics_body}</p>: null}
            </div>
        </>


    )
}

export default SongSelectForm
