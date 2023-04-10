import './App.css';
import { BrowserRouter, Route, Routes, Navigate } from 'react-router-dom';
import Dashboard  from './components/Dashboard';
import LogIn from './components/Login';
import Register from './components/Register';
import { useState, useEffect } from 'react';

function App() {

  const [authorized, setAuthorized] = useState(false);
  const [username, setUsername] = useState("");

  // console log authorized every time it changes
  useEffect(() => {
    console.log(authorized);
  }, [authorized])

  // The Main Front End App;
  return (
    <div className='App'>
      <h1 className="text-center">Audio Aurorra</h1>
      <div className="App-content">
      <BrowserRouter>
        <Routes>
          {authorized ? (
            <>
              <Route path='/' element={<Dashboard user={username}/>} />
              <Route path="/login" element={<Navigate to="/"/>} />
              <Route path="/register" element={<Navigate to="/"/>} />
            </>
          ) : ( 
            <>
              <Route path='/' element={<Navigate to="/login"/>} />
              <Route path="/login" element={<LogIn username={username} setUsername={setUsername} setAuthorized={setAuthorized}/>} />
              <Route path="/register" element={<Register/>} />
            </>
          )}
          
          
        </Routes>
      </BrowserRouter>
      </div>
    </div>
    
  );
}

export default App;