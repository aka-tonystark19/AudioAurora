import React, {useState, useEffect}  from "react";
import Select from 'react-select';

import './songSelectForm.css';

function SongSelectForm ({user, fileList}) {

    const [songDetails, setsongDetails] = useState(null);
    const [song, setSong] = useState(null);

    const getSongData = () => {
        if (song != null){
            fetch(`http://localhost:8000/get_song_data?name=${song}&username=${user}`)
            .then(res => res.json()).then(data => {
                setsongDetails(data);
                var audio = new Audio(`http://localhost:8000/get_audio_file/${user}/${song}.mp3`);
                audio.play();
            })
            .catch(err => console.log(err));
        }
    }

    return (
        <>
            <div className="row selectSong">
                <div className="col-md-9">
                    {/* Dropdown Creation Based on https://www.npmjs.com/package/react-select
                      * CSS Targeting of dropdown based on: https://stackoverflow.com/questions/63212723/using-dark-mode-in-react-select
                     */}
                    <Select
                        className="DDContainer"
                        classNamePrefix="dropdown" 
                        options={ fileList.sort().map(file => { return {label: file, value: file} })}
                        onChange={e => setSong(e.value)}
                    />
                </div>
                <div className="col-md-3">
                    <a id="playButton" className={song != null ? "submitButtons buttonActive" : "submitButtons buttonInactive"} onClick={getSongData}>Get Song Data</a>
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
