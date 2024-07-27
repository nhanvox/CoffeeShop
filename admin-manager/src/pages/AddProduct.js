// src/pages/AddProduct.js
import React, { useState } from 'react';
import axios from 'axios';

const AddProduct = () => {
    const [name, setName] = useState('');
    const [price, setPrice] = useState('');
    const [description, setDescription] = useState('');
    const [categoryid, setCategoryId] = useState('');

    const handleSubmit = async (event) => {
        event.preventDefault();
        try {
            await axios.post('http://192.168.175.111:3000/products', { name, price, description, categoryid });
            alert('Product added successfully');
        } catch (error) {
            console.error('Error adding product:', error);
        }
    };

    return (
        <div>
            <h1>Add Product</h1>
            <form onSubmit={handleSubmit}>
                <input
                    type="text"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    placeholder="Name"
                    required
                />
                <input
                    type="number"
                    value={price}
                    onChange={(e) => setPrice(e.target.value)}
                    placeholder="Price"
                    required
                />
                <textarea
                    value={description}
                    onChange={(e) => setDescription(e.target.value)}
                    placeholder="Description"
                ></textarea>
                <input
                    type="text"
                    value={categoryid}
                    onChange={(e) => setCategoryId(e.target.value)}
                    placeholder="Category ID"
                    required
                />
                <button type="submit">Add Product</button>
            </form>
        </div>
    );
};

export default AddProduct;
