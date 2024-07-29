import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';
import {
    Container,
    TextField,
    Button,
    Typography,
    Box,
    Paper,
    Divider,
    FormControl,
    MenuItem,
    Select,
    InputLabel,
    Switch,
    FormControlLabel,
    Card,
    CardMedia
} from '@mui/material';

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
    const navigate = useNavigate();

    useEffect(() => {
        axios.get('http://192.168.1.121:3000/getallcategory')
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
                await axios.post('http://192.168.1.121:3000/products', { name, price, description, categoryid, image, isBestSeller, isNewProduct });
                alert('Product added successfully');
                navigate('/products');
            } catch (error) {
                console.error('Error adding product:', error);
            }
        }
    };

    const handleCancel = () => {
        navigate('/products');
    };

    const switchLabelStyle = {
        fontFamily: 'Montserrat, sans-serif',
    };

    return (
        <Container maxWidth="lg" sx={{ mt: 1, fontFamily: 'Montserrat, sans-serif' }}>
            <Paper elevation={3} sx={{ p: 3, fontFamily: 'Montserrat, sans-serif' }}>
                <Typography variant="h5" component="h1" align="left" sx={{ mb: 3, fontFamily: 'Montserrat, sans-serif', fontWeight: 'bold' }}>
                    Thêm sản phẩm
                </Typography>
                <Divider sx={{ mb: 3 }} />
                <Box
                    component="form"
                    onSubmit={handleSubmit}
                    sx={{ display: 'flex', flexDirection: 'column', gap: 1, fontFamily: 'Montserrat, sans-serif' }}
                >
                    <FormControl fullWidth margin="normal" sx={{ mb: 1 }}>
                        <TextField
                            type="text"
                            value={name}
                            onChange={(e) => setName(e.target.value)}
                            label="Tên sản phẩm"
                            required
                            fullWidth
                            InputLabelProps={{
                                sx: { fontFamily: 'Montserrat, sans-serif' }
                            }}
                            InputProps={{
                                sx: { fontFamily: 'Montserrat, sans-serif' }
                            }}
                            {...(errors.name && { error: true, helperText: errors.name })}
                        />
                    </FormControl>
                    <FormControl fullWidth margin="normal" sx={{ mb: 1 }}>
                        <TextField
                            type="number"
                            value={price}
                            onChange={(e) => setPrice(e.target.value)}
                            label="Giá"
                            required
                            fullWidth
                            InputLabelProps={{
                                sx: { fontFamily: 'Montserrat, sans-serif' }
                            }}
                            InputProps={{
                                sx: { fontFamily: 'Montserrat, sans-serif' }
                            }}
                            {...(errors.price && { error: true, helperText: errors.price })}
                        />
                    </FormControl>
                    <FormControl fullWidth margin="normal" sx={{ mb: 1 }}>
                        <TextField
                            value={description}
                            onChange={(e) => setDescription(e.target.value)}
                            label="Mô tả"
                            multiline
                            rows={4}
                            fullWidth
                            InputLabelProps={{
                                sx: { fontFamily: 'Montserrat, sans-serif' }
                            }}
                            InputProps={{
                                sx: { fontFamily: 'Montserrat, sans-serif' }
                            }}
                        />
                    </FormControl>
                    <FormControl fullWidth margin="normal" sx={{ mb: 1 }}>
                        <InputLabel sx={{ fontFamily: 'Montserrat, sans-serif' }}>Danh mục</InputLabel>
                        <Select
                            value={categoryid}
                            onChange={(e) => setCategoryId(e.target.value)}
                            required
                            fullWidth
                            sx={{ fontFamily: 'Montserrat, sans-serif' }}
                            {...(errors.categoryid && { error: true })}
                        >
                            {categories.map(category => (
                                <MenuItem key={category._id} value={category._id} sx={{ fontFamily: 'Montserrat, sans-serif' }}>
                                    {category.name}
                                </MenuItem>
                            ))}
                        </Select>
                        {errors.categoryid && <Typography variant="caption" color="error" sx={{ fontFamily: 'Montserrat, sans-serif' }}>{errors.categoryid}</Typography>}
                    </FormControl>
                    <FormControl fullWidth margin="normal" sx={{ mb: 1 }}>
                        <TextField
                            value={image}
                            onChange={(e) => setImage(e.target.value)}
                            label="URL Hình ảnh"
                            fullWidth
                            InputLabelProps={{
                                sx: { fontFamily: 'Montserrat, sans-serif' }
                            }}
                            InputProps={{
                                sx: { fontFamily: 'Montserrat, sans-serif' }
                            }}
                            {...(errors.image && { error: true, helperText: errors.image })}
                        />
                    </FormControl>
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
                    <Box sx={{ display: 'flex', gap: 2, fontFamily: 'Montserrat, sans-serif' }}>
                        <FormControlLabel
                            control={
                                <Switch
                                    checked={isBestSeller}
                                    onChange={(e) => setIsBestSeller(e.target.checked)}
                                />
                            }
                            label={<Typography sx={switchLabelStyle}>Sản phẩm bán chạy</Typography>}
                        />
                        <FormControlLabel
                            control={
                                <Switch
                                    checked={isNewProduct}
                                    onChange={(e) => setIsNewProduct(e.target.checked)}
                                />
                            }
                            label={<Typography sx={switchLabelStyle}>Sản phẩm mới</Typography>}
                        />
                    </Box>
                    <Box sx={{ display: 'flex', justifyContent: 'flex-end', gap: 2, fontFamily: 'Montserrat, sans-serif' }}>
                        <Button
                            type="submit"
                            variant="contained"
                            sx={{ 
                                width: '150px', 
                                fontFamily: 'Montserrat, sans-serif',
                                backgroundColor: '#3366ff', // Màu nền mới
                                color: '#ffffff', // Màu văn bản
                                '&:hover': {
                                    backgroundColor: '#254db3' // Màu nền khi hover
                                }
                            }}
                        >
                            Thêm mới
                        </Button>
                        <Button
                            onClick={handleCancel}
                            variant="outlined"
                            color="error"
                            sx={{ width: '150px', fontFamily: 'Montserrat, sans-serif', fontWeight: 'bold' }}
                        >
                            Hủy
                        </Button>
                    </Box>
                </Box>
            </Paper>
        </Container>
    );
};

export default AddProduct;
