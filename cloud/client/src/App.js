import './App.css';
import UploadForm from './components/uploadForm';
import SongSelectForm from './components/songSelectForm';
import {useEffect, useState} from 'react';

function App() {

  // State Variable that holds the list of files
  const [fileList, setFileList] = useState([]);
 
  // Run Code Once when Web Page Launches
  useEffect(() => {
    // Fetch List of Files from Server
    fetch("http://localhost:8000/file_list")
    .then(res => res.json()).then(data => {
      setFileList(data);
    })
    .catch(err => console.log(err));
  },[])

  // The Main Front End App;
  return (
    <div className='App'>
      <h1 className="text-center">Drag and Drop Test</h1>
      <div className="App-content">
        <div className='container'>
          <div className='row'>
            <div className="col-md-10 songSelectForm">
              <SongSelectForm fileList={fileList}/>
            </div>
            <div className="col-md-2 uploadForm">
              <UploadForm fileList={fileList} setFileList={setFileList}/>
            </div>
          </div>
        </div>

      </div>
    </div>
    
  );
}

export default App;