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
        FormControl,
    } from '@mui/material';

    const AddUser = () => {
        const [email, setEmail] = useState('');
        const [password, setPassword] = useState('');
        const [errorMessage, setErrorMessage] = useState('');
        const navigate = useNavigate();

        const handleSubmit = async (event) => {
            event.preventDefault();
            try {
                await axios.post('http://192.168.1.121:3000/register', { email, password });
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

        const handleCancel = () => {
            navigate('/users');
        };

        return (
            <Container maxWidth="lg" sx={{ mt: 5, fontFamily: 'Montserrat, sans-serif' }}>
                <Paper elevation={3} sx={{ p: 3, fontFamily: 'Montserrat, sans-serif' }}>
                <Typography variant="h5" component="h1" align="left" sx={{ mb: 3, fontFamily: 'Montserrat, sans-serif', fontWeight: 'bold' }}>
                        Thêm người dùng
                    </Typography>
                    <Divider sx={{ mb: 3 }} />
                    {errorMessage && <Typography sx={{ color: 'red', mb: 3 }}>{errorMessage}</Typography>}
                    <Box
                        component="form"
                        onSubmit={handleSubmit}
                        sx={{ display: 'flex', flexDirection: 'column', gap: 1, fontFamily: 'Montserrat, sans-serif' }}
                    >
                        <FormControl fullWidth margin="normal" sx={{ mb: 1 }}>
                            <TextField
                                label="Email"
                                type="email"
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                                required
                                fullWidth
                                InputLabelProps={{
                                    sx: { fontFamily: 'Montserrat, sans-serif' }
                                }}
                                InputProps={{
                                    sx: { fontFamily: 'Montserrat, sans-serif' }
                                }}
                            />
</FormControl>
                        <FormControl fullWidth margin="normal" sx={{ mb: 2 }}>
                            <TextField
                                label="Mật khẩu"
                                type="password"
                                value={password}
                                onChange={(e) => setPassword(e.target.value)}
                                required
                                fullWidth
                                InputLabelProps={{
                                    sx: { fontFamily: 'Montserrat, sans-serif' }
                                }}
                                InputProps={{
                                    sx: { fontFamily: 'Montserrat, sans-serif' }
                                }}
                            />
                        </FormControl>
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

    export default AddUser;