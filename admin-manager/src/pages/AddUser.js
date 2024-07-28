// src/pages/AddUser.js
import React, { useState } from 'react';
import axios from 'axios';

const AddUser = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');

    const handleSubmit = async (event) => {
        event.preventDefault();
        try {
            await axios.post('http://192.168.1.123:3000/register', { email, password });
            alert('User added successfully');
        } catch (error) {
            console.error('Error adding user:', error);
        }
    };

    return (
        <div>
            <h1>Add User</h1>
            <form onSubmit={handleSubmit}>
                <input
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="Email"
                    required
                />
                <input
                    type="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="Password"
                    required
                />
                <button type="submit">Add User</button>
            </form>
        </div>
    );
};

export default AddUser;
