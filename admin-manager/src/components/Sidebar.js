// src/components/Sidebar.js

import React from 'react';
import { List, ListItem, ListItemText, ListItemIcon, Box } from '@mui/material';
import { Link, useLocation } from 'react-router-dom';
import DashboardIcon from '@mui/icons-material/Dashboard';
import CategoryIcon from '@mui/icons-material/Category';
import InventoryIcon from '@mui/icons-material/Inventory'; 
import GroupIcon from '@mui/icons-material/Group';  
import ListAltIcon from '@mui/icons-material/ListAlt'; 

const Sidebar = () => {
    const location = useLocation();

    const isActive = (path) => {
        return location.pathname === path;
    };

    return (
        <Box
            sx={{
                height: '100vh',
                backgroundColor: '#FFFfff',
                position: 'sticky',
                top: 0,
                width: '260px',
                color: '#000000',
                fontFamily: 'Montserrat, sans-serif'
            }}
        >
            <div style={{ padding: '20px', textAlign: 'center', borderBottom: '1px solid #FFFEF2' }}>
                <h2 style={{ color: '#00000', fontFamily: 'Montserrat, sans-serif' }}>CoffeeShop</h2>
            </div>
            <List sx={{ fontFamily: 'Montserrat, sans-serif' }}>
                <ListItem
                    button
                    component={Link}
                    to="/dashboard"
                    sx={{
                        backgroundColor: isActive('/dashboard') ? '#e4f2fd' : 'transparent',
                        '&:hover': { backgroundColor: '#e4f2fd' },
                        cursor: 'pointer',
                        color: '#3366ff',
                        fontFamily: 'Montserrat, sans-serif'
                    }}
                >
                    <ListItemIcon>
                        <DashboardIcon sx={{ color: '#3366ff' }} />
                    </ListItemIcon>
                    <ListItemText primary="Dashboard" sx={{ fontFamily: 'Montserrat, sans-serif' }} />
                </ListItem>
                <ListItem
                    button
                    component={Link}
                    to="/users"
                    sx={{
                        backgroundColor: isActive('/users') ? '#e4f2fd' : 'transparent',
                        '&:hover': { backgroundColor: '#e4f2fd' },
                        cursor: 'pointer',
                        color: '#3366ff',
                        fontFamily: 'Montserrat, sans-serif'
                    }}
                >
                    <ListItemIcon>
                        <GroupIcon sx={{ color: '#3366ff' }} />
                    </ListItemIcon>
                    <ListItemText primary="Users" sx={{ fontFamily: 'Montserrat, sans-serif' }} />
                </ListItem>
                <ListItem
                    button
                    component={Link}
                    to="/products"
                    sx={{
                        backgroundColor: isActive('/products') ? '#e4f2fd' : 'transparent',
                        '&:hover': { backgroundColor: '#e4f2fd' },
                        cursor: 'pointer',
                        color: '#3366ff',
                        fontFamily: 'Montserrat, sans-serif'
                    }}
                >
                    <ListItemIcon>
                        <InventoryIcon sx={{ color: '#3366ff' }} />
                    </ListItemIcon>
                    <ListItemText primary="Products" sx={{ fontFamily: 'Montserrat, sans-serif' }} />
                </ListItem>
                <ListItem
                    button
                    component={Link}
                    to="/categories"
                    sx={{
                        backgroundColor: isActive('/categories') ? '#e4f2fd' : 'transparent',
                        '&:hover': { backgroundColor: '#e4f2fd' },
                        cursor: 'pointer',
                        color: '#3366ff',
                        fontFamily: 'Montserrat, sans-serif'
                    }}
                >
                    <ListItemIcon>
                        <CategoryIcon sx={{ color: '#3366ff' }} />
                    </ListItemIcon>
                    <ListItemText primary="Categories" sx={{ fontFamily: 'Montserrat, sans-serif' }} />
                </ListItem>
                <ListItem
                    button
                    component={Link}
                    to="/orders"
                    sx={{
                        backgroundColor: isActive('/orders') ? '#e4f2fd' : 'transparent',
                        '&:hover': { backgroundColor: '#e4f2fd' },
                        cursor: 'pointer',
                        color: '#3366ff',
                        fontFamily: 'Montserrat, sans-serif'
                    }}
                >
                    <ListItemIcon>
                        <ListAltIcon sx={{ color: '#3366ff' }} />
                    </ListItemIcon>
                    <ListItemText primary="Orders" sx={{ fontFamily: 'Montserrat, sans-serif' }} />
                </ListItem>
            </List>
        </Box>
    );
};

export default Sidebar;
