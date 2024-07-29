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
                backgroundColor: '#1c2536',
                position: 'sticky',
                top: 0,
                width: '260px',
                color: '#ffffff'
            }}
        >
            <div style={{ padding: '20px', textAlign: 'center', borderBottom: '1px solid #2c3e50' }}>
                <h2 style={{ color: '#ffffff' }}>CoffeeShop</h2>
            </div>
            <List>
                <ListItem
                    button
                    component={Link}
                    to="/"
                    sx={{
                        backgroundColor: isActive('/') ? '#5048e5' : 'transparent',
                        '&:hover': { backgroundColor: '#5048e5' },
                        cursor: 'pointer',
                        color: '#ffffff'
                    }}
                >
                    <ListItemIcon>
                        <DashboardIcon sx={{ color: '#ffffff' }} />
                    </ListItemIcon>
                    <ListItemText primary="Dashboard" />
                </ListItem>
                <ListItem
                    button
                    component={Link}
                    to="/users"
                    sx={{
                        backgroundColor: isActive('/users') ? '#5048e5' : 'transparent',
                        '&:hover': { backgroundColor: '#5048e5' },
                        cursor: 'pointer',
                        color: '#ffffff'
                    }}
                >
                    <ListItemIcon>
                        <GroupIcon sx={{ color: '#ffffff' }} />
                    </ListItemIcon>
                    <ListItemText primary="Users" />
                </ListItem>
                <ListItem
                    button
                    component={Link}
                    to="/products"
                    sx={{
                        backgroundColor: isActive('/products') ? '#5048e5' : 'transparent',
                        '&:hover': { backgroundColor: '#5048e5' },
                        cursor: 'pointer',
                        color: '#ffffff'
                    }}
                >
                    <ListItemIcon>
                        <InventoryIcon sx={{ color: '#ffffff' }} />
                    </ListItemIcon>
                    <ListItemText primary="Products" />
                </ListItem>
                <ListItem
                    button
                    component={Link}
                    to="/categories"
                    sx={{
                        backgroundColor: isActive('/categories') ? '#5048e5' : 'transparent',
                        '&:hover': { backgroundColor: '#5048e5' },
                        cursor: 'pointer',
                        color: '#ffffff'
                    }}
                >
                    <ListItemIcon>
                        <CategoryIcon sx={{ color: '#ffffff' }} />
                    </ListItemIcon>
                    <ListItemText primary="Categories" />
                </ListItem>
                <ListItem
                    button
                    component={Link}
                    to="/orders"
                    sx={{
                        backgroundColor: isActive('/orders') ? '#5048e5' : 'transparent',
                        '&:hover': { backgroundColor: '#5048e5' },
                        cursor: 'pointer',
                        color: '#ffffff'
                    }}
                >
                    <ListItemIcon>
                        <ListAltIcon sx={{ color: '#ffffff' }} />
                    </ListItemIcon>
                    <ListItemText primary="Orders" />
                </ListItem>
            </List>
        </Box>
    );
};

export default Sidebar;
