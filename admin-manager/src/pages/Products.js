// src/pages/Products.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Button, Card, CardActions, CardContent, CardMedia, IconButton, Typography, Grid, CircularProgress, TextField, MenuItem, Select, FormControl } from '@mui/material';
import { Edit, Delete } from '@mui/icons-material';
import { useNavigate } from 'react-router-dom';

const Products = () => {
    const [products, setProducts] = useState([]);
    const [categories, setCategories] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [search, setSearch] = useState('');
    const [selectedCategory, setSelectedCategory] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        axios.get('http://192.168.175.111:3000/products')
            .then(response => {
                if (response.data && Array.isArray(response.data.products)) {
                    setProducts(response.data.products);
                } else {
                    setError('Invalid response format');
                }
                setLoading(false);
            })
            .catch(error => {
                setError('Error fetching products');
                setLoading(false);
            });

        axios.get('http://192.168.175.111:3000/getallcategory')
            .then(response => {
                if (response.data && Array.isArray(response.data.categories)) {
                    setCategories(response.data.categories);
                } else {
                    setError('Invalid response format');
                }
            })
            .catch(error => {
                setError('Error fetching categories');
            });
    }, []);

    const handleDelete = (id) => {
        axios.delete(`http://192.168.175.111:3000/products/${id}`)
            .then(response => {
                setProducts(products.filter(product => product._id !== id));
            })
            .catch(error => {
                setError('Error deleting product');
            });
    };

    const handleSearchChange = (event) => {
        setSearch(event.target.value);
    };

    const handleCategoryChange = (event) => {
        setSelectedCategory(event.target.value);
    };

    const filteredProducts = products.filter(product => {
        return (
            product.name.toLowerCase().includes(search.toLowerCase()) &&
            (selectedCategory === '' || product.categoryid === selectedCategory)
        );
    });

    if (loading) {
        return <div><CircularProgress /></div>;
    }

    if (error) {
        return <div>{error}</div>;
    }

    return (
        <div>
            <h1>Danh sách sản phẩm</h1>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
                <Button variant="contained" color="primary" onClick={() => navigate('/add-product')}>
                    Thêm sản phẩm
                </Button>
                <div style={{ display: 'flex', gap: '10px' }}>
                    <TextField
                        label="Tìm kiếm sản phẩm"
                        variant="outlined"
                        value={search}
                        onChange={handleSearchChange}
                        sx={{ '& .MuiInputLabel-root': { fontSize: '12px', textAlign: 'center', top: '-4px' } }}
                        InputProps={{ sx: { height: '39px' } }}
                    />
                    <FormControl variant="outlined" sx={{ height: '39px', width: '40' }}>
                        <Select
                            value={selectedCategory}
                            onChange={handleCategoryChange}
                            displayEmpty
                            inputProps={{ 'aria-label': 'Without label' }}
                            sx={{ height: '39px', width: '40' }}
                        >
                            <MenuItem value="">
                                <em>All</em>
                            </MenuItem>
                            {categories.map(category => (
                                <MenuItem key={category._id} value={category._id}>
                                    {category.name}
                                </MenuItem>
                            ))}
                        </Select>
                    </FormControl>
                </div>
            </div>
            <Grid container spacing={2}>
                {filteredProducts.map(product => (
                    <Grid item key={product._id} xs={12} sm={6} md={2}>
                        <Card sx={{ height: 300, width: 170, display: 'flex', flexDirection: 'column', justifyContent: 'space-between' }}>
                            <CardMedia
                                component="img"
                                height="160"
                                image={product.image}
                                alt={product.name}
                            />
                            <CardContent sx={{ flexGrow: 1 }}>
                                <Typography gutterBottom variant="h7" component="div" sx={{
                                    display: '-webkit-box',
                                    WebkitBoxOrient: 'vertical',
                                    overflow: 'hidden',
                                    WebkitLineClamp: 2,
                                    lineClamp: 2,
                                }}>
                                    {product.name}
                                </Typography>
                                <Typography variant="body2" color="text.secondary">
                                    {product.price} vnđ
                                </Typography>
                            </CardContent>
                            <CardActions sx={{ justifyContent: 'space-between' }}>
                                <IconButton aria-label="edit" onClick={() => navigate(`/edit-product/${product._id}`)}>
                                    <Edit />
                                </IconButton>
                                <IconButton aria-label="delete" onClick={() => handleDelete(product._id)}>
                                    <Delete sx={{ color: 'red' }} />
                                </IconButton>
                            </CardActions>
                        </Card>
                    </Grid>
                ))}
            </Grid>
        </div>
    );
};

export default Products;
