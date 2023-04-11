import React, {useState}  from "react";
import Dropzone from 'react-dropzone'
import { ReactComponent as DownloadLogo } from '../assets/download.svg';
import { ReactComponent as DocumentLogo } from '../assets/document.svg';

import './uploadForm.css';

function UploadForm ({user, fileList, setFileList}) {

    // State Variables that controlthe form
    const [file, setFile] = useState(null)
    const [name, setName] = useState("")
    const [isRjected, setIsRejected] = useState(false);
    const [fileAccepted, setfileAccepted] = useState(false);
    const [validName, setValidName] = useState(true);

    // Event Handler for when an invalid file is dropped
    const onReject = () => {
        setIsRejected(true)
        setfileAccepted(false)
        setFile(null)
        setName("")
        setValidName(true)
    }

    // Event Handler for when a valid file is dropped
    const onAccept = (acceptedFiles) => {
        setfileAccepted(true)
        setIsRejected(false)
        setFile(acceptedFiles[0]);
        setName(acceptedFiles[0].name.split('.').slice(0, -1).join('.'))
        setValidName(fileList.includes(acceptedFiles[0].name.split('.').slice(0, -1).join('.')) ? false : true)
    }

    // Event Handler for when the name of the file is changed
    const onChange = (event) => {
        setName(event.target.value)
        setValidName(fileList.includes(event.target.value) ? false : true)
    }

    // Event Handler for when the form is submitted
    const onSubmit = (event) => {
        // Prevents the page from reloading
        event.preventDefault()

        // Checks if the file is valid and the name is valid, then sends the file to the server
        if (fileAccepted && validName) {

            // Creates a form data object to send to the server
            const formData = new FormData();
            formData.append('username', user);
            formData.append('name', name);
            
            formData.append('file', file);

            // Fetch API calls the server and sends the file
            fetch("http://localhost:8000/upload_files", {
                method: 'POST',
                body: formData
            })
            .then(res => res.json()).then(data => {
                // Adds the file to the list of files
                setFileList(fileList => [...fileList, data.filename]);
            })
            .catch(err => console.log(err));

            // Resets the form
            setIsRejected(false)
            setfileAccepted(false)
            setFile(null)
            setName("")
            setValidName(true)
            
        }
    }

    return (
        <>
            {/* File Upload Drag and Drop Element */}
            <div className='row'>
                <Dropzone
                    accept={{ 'audio/mp3': [".mp3", ".wav"] }}
                    multiple={false}
                    onDropRejected={onReject}
                    onDropAccepted={onAccept}
                >
                    {({ getRootProps, getInputProps }) => (
                        <div {...getRootProps()} className="upload">
                            <input {...getInputProps()} />

                            {/* Image that displays */}
                            {fileAccepted ? <DocumentLogo style={{height: "100", width:"100", fill:'gray'}}/> : <DownloadLogo style={{height: "100", width:"100", fill:'gray'}} />}

                            {/* Drop message that only displays when files need to be dropped in */}
                            {fileAccepted ? null : <p>Drop the files here</p>}

                            {/* Error Message that displays when invalid file is dropped */}
                            { isRjected? <p className='wrongFileError'>Please only upload MP3 files</p> : null }
                        </div>
                    )}
                </Dropzone>
            </div>
            
            {/* Name Field and Button */}
            <form onSubmit={onSubmit}>
                    
                    {/* Name Input Text Box */}
                    <div className="row">
                        <input type="text" id="nameInput" placeholder="Enter File Name" disabled={!fileAccepted} value={name} onChange={onChange} /> 
                    </div>

                    {/* Error Message for Wrong Name */}
                    <div className="row">
                        {validName ? null : <p className='wrongNameError'>File Name Already Exists</p>}
                    </div>

                    {/* Submit Button to upload the file */}
                    <div className="row">
                        <input type="submit" id="submitButton" value="Upload" className={fileAccepted && validName ? "buttonActive" : "buttonInactive"} />  
                    </div>
    
                </form>

            
        </>


    )
}

export default UploadForm
