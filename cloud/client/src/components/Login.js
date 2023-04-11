import React from 'react';
import { useState } from 'react';

export default function Login({ username, setUsername, setAuthorized }  ) {
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
        sendLoginData({username, password})
        .then(data => { 
            if (!(data.login)) {
                setUsername("");
                setPassword("");
            }
            setAuthorized(data.login);
        })
    }
    return(
        <div className="login-page">
            <h1>Log In</h1>
            <form onSubmit={handleLogIn}>
                <label for="username"> Username:</label>
                <input type="text" value={username} onChange={event => setUsername(event.target.value)}/>
                <label for="password"> Password:</label>
                <input type="password" value={password} onChange={event => setPassword(event.target.value)}/>
                <button type="submit">Log In</button>
            </form>
        <a href="/register">Don't Have An Account?</a>
        </div>
    )
}