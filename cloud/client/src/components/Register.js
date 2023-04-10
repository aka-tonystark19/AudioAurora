import React from 'react';
import { useState } from 'react';
import { Navigate  } from 'react-router-dom';

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
        registerAccount({username, password})
        .then(data => setForward(true))
    }

  return(
    <div className="register-page">
      <h1>Register</h1>
      <form onSubmit={handleRegister}>
        <label for="username"> Username:</label>
        <input type="text" value={username} onChange={event => setUsername(event.target.value)}/>
        <label for="password"> Password:</label>
        <input type="password" value={password} onChange={event => setPassword(event.target.value)}/>
        <button type="submit">Register!</button>
      </form>
      <a href="/login">Already Have An Account?</a>
      {forward ? <Navigate to="/login" /> : null}
    </div>
  )
}