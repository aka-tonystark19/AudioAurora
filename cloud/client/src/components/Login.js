import React from 'react';
import { useState } from 'react';

import './authentication.css'

export default function Login({ username, setUsername, setAuthorized }) {
    // create a username and password state variable
    const [password, setPassword] = useState("");

    const sendLoginData = credentials => {
        return new Promise((resolve, reject) => {
            fetch('http://localhost:8000/loginRequest', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(credentials)
            })
                .then(res => res.json()).then(data => resolve(data))
                .catch(err => console.log(err));
        })
    }

    const handleLogIn = (event) => {
        event.preventDefault();
        sendLoginData({ username, password })
            .then(data => {
                if (!(data.login)) {
                    setUsername("");
                    setPassword("");
                }
                setAuthorized(data.login);
            })
    }
    return (
        <div className="authentication-page">
            <h1>Welcome Back</h1>
            <form onSubmit={handleLogIn}>
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
                    <button type="submit" className='authenticationButton'>Log In</button>
                </div>
            </form>
            <p>Don't Have An Account? <a href="/register">Create One</a></p>
        </div>
    )
}