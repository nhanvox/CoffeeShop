import React, { useState } from 'react';
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
} from '@mui/material';

const AddCategory = () => {
  const [name, setName] = useState("");
  const navigate = useNavigate();

    const handleSubmit = async (event) => {
        event.preventDefault();
        try {
            await axios.post('http://192.168.1.121:3000/category', { name });
            alert('Category added successfully');
            navigate('/categories');
        } catch (error) {
            console.error('Error adding category:', error);
        }
    };

    const handleCancel = () => {
        navigate('/categories');
    };

    return (
        <Container maxWidth="lg" sx={{ mt: 5, fontFamily: 'Montserrat, sans-serif' }}>
            <Paper elevation={3} sx={{ p: 3, fontFamily: 'Montserrat, sans-serif' }}>
                <Typography variant="h5" component="h1" align="left" sx={{ mb: 3, fontFamily: 'Montserrat, sans-serif' }}>
                    Thêm thể loại
                </Typography>
                <Divider sx={{ mb: 3 }} />
                <Box
                    component="form"
                    onSubmit={handleSubmit}
                    sx={{ display: 'flex', flexDirection: 'column', gap: 2, fontFamily: 'Montserrat, sans-serif' }}
                >
                    <TextField
                        label="Tên thể loại"
                        value={name}
                        onChange={(e) => setName(e.target.value)}
                        placeholder="Nhập tên thể loại..."
                        required
                        fullWidth
                        sx={{ mb: 2 }}
                        InputLabelProps={{
                            sx: { fontFamily: 'Montserrat, sans-serif' }
                        }}
                        InputProps={{
                            sx: { fontFamily: 'Montserrat, sans-serif' }
                        }}
                    />
                    <Box sx={{ display: 'flex', justifyContent: 'flex-end', gap: 2, fontFamily: 'Montserrat, sans-serif' }}>
                        <Button
                            type="submit"
                            variant="contained"
                            color="primary"
                            sx={{ width: '150px', fontFamily: 'Montserrat, sans-serif' }}
                        >
                            Thêm mới
                        </Button>
                        <Button
                            onClick={handleCancel}
                            variant="outlined"
                            color="error"
                            sx={{ width: '150px', fontFamily: 'Montserrat, sans-serif' }}
                        >
                            Hủy
                        </Button>
                    </Box>
                </Box>
            </Paper>
        </Container>
    );
};

export default AddCategory;
