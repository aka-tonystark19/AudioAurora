import React from 'react';
import { useState } from 'react';

export default function Register() {
    const handleRegister = (event) => {}

    // create a username and password state variable
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");

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
    </div>
  )
}