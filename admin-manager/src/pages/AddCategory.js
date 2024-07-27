// src/pages/AddCategory.js
import React, { useState } from 'react';
import axios from 'axios';
import {useNavigate } from 'react-router-dom';

const AddCategory = () => {
    const [name, setName] = useState('');
    const navigate = useNavigate();

    const handleSubmit = async (event) => {
        event.preventDefault();
        try {
            await axios.post('http://192.168.175.111:3000/category', { name });
            alert('Category added successfully');
            navigate('/categories');
        } catch (error) {
            console.error('Error adding category:', error);
        }
    };

    return (
        <div>
            <h1>Add Category</h1>
            <form onSubmit={handleSubmit}>
                <input
                    type="text"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    placeholder="Name"
                    required
                />
                <button type="submit">Add Category</button>
            </form>
        </div>
    );
};

export default AddCategory;
