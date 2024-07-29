import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Button, TextField, MenuItem, Select, FormControl, InputLabel, Switch, FormControlLabel, Typography, Card, CardMedia } from '@mui/material';

const AddProduct = () => {
    const [name, setName] = useState('');
    const [price, setPrice] = useState('');
    const [description, setDescription] = useState('');
    const [categoryid, setCategoryId] = useState('');
    const [image, setImage] = useState('');
    const [isBestSeller, setIsBestSeller] = useState(false);
    const [isNewProduct, setIsNewProduct] = useState(true);
    const [categories, setCategories] = useState([]);
    const [errors, setErrors] = useState({});

    useEffect(() => {
        axios.get('http://192.168.175.111:3000/getallcategory')
            .then(response => {
                if (response.data && Array.isArray(response.data.categories)) {
                    setCategories(response.data.categories);
                }
            })
            .catch(error => {
                console.error('Error fetching categories:', error);
            });
    }, []);

    const validate = () => {
        let tempErrors = {};
        tempErrors.name = name ? "" : "Name is required.";
        tempErrors.price = price ? "" : "Price is required.";
        tempErrors.categoryid = categoryid ? "" : "Category is required.";
        tempErrors.image = image ? "" : "Image URL is required.";
        setErrors(tempErrors);
        return Object.values(tempErrors).every(x => x === "");
    }

    const handleSubmit = async (event) => {
        event.preventDefault();
        if (validate()) {
            try {
                await axios.post('http://192.168.175.111:3000/products', { name, price, description, categoryid, image, isBestSeller, isNewProduct });
                alert('Product added successfully');
            } catch (error) {
                console.error('Error adding product:', error);
            }
        }
    };

    return (
        <div>
            <h1>Add Product</h1>
            <form onSubmit={handleSubmit}>
                <TextField
                    type="text"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    label="Name"
                    required
                    fullWidth
                    margin="normal"
                    {...(errors.name && { error: true, helperText: errors.name })}
                />
                <TextField
                    type="number"
                    value={price}
                    onChange={(e) => setPrice(e.target.value)}
                    label="Price"
                    required
                    fullWidth
                    margin="normal"
                    {...(errors.price && { error: true, helperText: errors.price })}
                />
                <TextField
                    value={description}
                    onChange={(e) => setDescription(e.target.value)}
                    label="Description"
                    multiline
                    rows={4}
                    fullWidth
                    margin="normal"
                />
                <FormControl fullWidth margin="normal" {...(errors.categoryid && { error: true })}>
                    <InputLabel>Category</InputLabel>
                    <Select
                        value={categoryid}
                        onChange={(e) => setCategoryId(e.target.value)}
                        required
                    >
                        {categories.map(category => (
                            <MenuItem key={category._id} value={category._id}>
                                {category.name}
                            </MenuItem>
                        ))}
                    </Select>
                    {errors.categoryid && <Typography variant="caption" color="error">{errors.categoryid}</Typography>}
                </FormControl>
                <TextField
                    value={image}
                    onChange={(e) => setImage(e.target.value)}
                    label="Image URL"
                    fullWidth
                    margin="normal"
                    {...(errors.image && { error: true, helperText: errors.image })}
                />
                {image && (
                    <Card sx={{ maxWidth: 345, marginTop: 2 }}>
                        <CardMedia
                            component="img"
                            height="140"
                            image={image}
                            alt="Product Image"
                        />
                    </Card>
                )}
                <FormControlLabel
                    control={
                        <Switch
                            checked={isBestSeller}
                            onChange={(e) => setIsBestSeller(e.target.checked)}
                        />
                    }
                    label="Best Seller"
                />
                <FormControlLabel
                    control={
                        <Switch
                            checked={isNewProduct}
                            onChange={(e) => setIsNewProduct(e.target.checked)}
                        />
                    }
                    label="New Product"
                />
                <Button type="submit" variant="contained" color="primary">
                    Add Product
                </Button>
            </form>
        </div>
    );
};

export default AddProduct;
