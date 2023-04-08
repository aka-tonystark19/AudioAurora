import React from 'react';
import { useState } from 'react';

export default function Login() {
    const handleLogIn = (event) => {}

    // create a username and password state variable
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");

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