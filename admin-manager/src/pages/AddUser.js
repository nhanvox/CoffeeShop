// src/pages/AddUser.js
import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const AddUser = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [errorMessage, setErrorMessage] = useState('');
    const navigate = useNavigate();

    const handleSubmit = async (event) => {
        event.preventDefault();
        try {
            await axios.post('http://192.168.175.111:3000/register', { email, password });
            alert('User added successfully');
            setEmail('');
            setPassword('');
            setErrorMessage('');
            navigate('/users');
        } catch (error) {
            if (error.response && error.response.data) {
                setErrorMessage(error.response.data.message || 'Error adding user');
            } else {
                setErrorMessage('Error adding user');
            }
            console.error('Error adding user:', error);
        }
    };

    return (
        <div>
            <h1>Add User</h1>
            {errorMessage && <div style={{ color: 'red' }}>{errorMessage}</div>}
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
