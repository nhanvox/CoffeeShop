// src/components/Header.js
import React from 'react';
import { AppBar, Toolbar, Typography } from '@mui/material';

const Header = () => {
    return (
        <AppBar position="sticky" sx={{ backgroundColor: '#3366ff' }}>
            <Toolbar>
                <Typography 
                    variant="h6" 
                    sx={{ 
                        fontFamily: 'Montserrat, sans-serif',
                        color: '#fffff' // Đảm bảo rằng văn bản có màu đen để dễ đọc
                    }}
                >
                    Admin Manager
                </Typography>
            </Toolbar>
        </AppBar>
    );
};

export default Header;
