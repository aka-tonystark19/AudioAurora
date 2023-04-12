import React from 'react';
import { useState } from 'react';
import { Navigate } from 'react-router-dom';

import './authentication.css'

export default function Register() {
  // create a username and password state variable
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [forward, setForward] = useState(false);

  async function registerAccount(credentials) {
    fetch('http://localhost:8000/registerRequest', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(credentials)
    })
      .then(res => res.json()).then(data => data)
      .catch(err => console.log(err));
  }

  const handleRegister = (event) => {
    event.preventDefault();
    registerAccount({ username, password })
      .then(data => setForward(true))
  }

  return (
    <div className="authentication-page">
      <h1>Register</h1>
      <form onSubmit={handleRegister}>
        <div className='formData'>
          <div className='inputContainer'>
            <label for="username"> Username:</label>
            <div className='inputBox'>
              <input type="text" placeholder="Username" value={username} onChange={event => setUsername(event.target.value)} />
            </div>
          </div>
          <div className='inputContainer'>
            <label for="password"> Password:</label>
            <div className='inputBox'>
              <input type="password" placeholder="Password" value={password} onChange={event => setPassword(event.target.value)} />
            </div>
          </div>
        </div>
        <div className='buttonContainer'>
            <button type="submit" className='authenticationButton'>Register</button>
        </div>
      </form>
      <p>Already Have An Account? <a href="/login">Log In</a></p>
      {forward ? <Navigate to="/login" /> : null}
    </div>
  )
}