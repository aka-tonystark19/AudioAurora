import UploadForm from './uploadForm';
import SongSelectForm from './songSelectForm';
import {useEffect, useState} from 'react';

export default function Dashboard({ user }) {

  // State Variable that holds the list of files
  const [fileList, setFileList] = useState([]);
 
  // Run Code Once when Web Page Launches
  useEffect(() => {
    // Fetch List of Files from Server
    fetch(`http://localhost:8000/file_list?username=${user}`)
    .then(res => res.json()).then(data => {
      setFileList(data);
    })
    .catch(err => console.log(err));
  },[])

  // The Main Front End App;
  return (
    <div className='container'>
          <div className='row'>
            <div className="col-md-10 songSelectForm">
              <SongSelectForm user={user} fileList={fileList}/>
            </div>
            <div className="col-md-2 uploadForm">
              <UploadForm user={user} fileList={fileList} setFileList={setFileList}/>
            </div>        
          </div>
    </div>
    
  );
}

