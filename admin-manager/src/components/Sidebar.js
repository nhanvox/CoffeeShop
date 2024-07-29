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
                backgroundColor: '#FFFEF2',
                position: 'sticky',
                top: 0,
                width: '260px',
                color: '#000000'
            }}
        >
            <div style={{ padding: '20px', textAlign: 'center', borderBottom: '1px solid #FFFEF2' }}>
                <h2 style={{ color: '#000000' }}>CoffeeShop</h2>
            </div>
            <List>
                <ListItem
                    button
                    component={Link}
                    to="/"
                    sx={{
                        backgroundColor: isActive('/') ? '#FF725E' : 'transparent',
                        '&:hover': { backgroundColor: '#FF725E' },
                        cursor: 'pointer',
                        color: '#000000'
                    }}
                >
                    <ListItemIcon>
                        <DashboardIcon sx={{ color: '#000000' }} />
                    </ListItemIcon>
                    <ListItemText primary="Dashboard" />
                </ListItem>
                <ListItem
                    button
                    component={Link}
                    to="/users"
                    sx={{
                        backgroundColor: isActive('/users') ? '#FF725E' : 'transparent',
                        '&:hover': { backgroundColor: '#FF725E' },
                        cursor: 'pointer',
                        color: '#000000'
                    }}
                >
                    <ListItemIcon>
                        <GroupIcon sx={{ color: '#000000' }} />
                    </ListItemIcon>
                    <ListItemText primary="Users" />
                </ListItem>
                <ListItem
                    button
                    component={Link}
                    to="/products"
                    sx={{
                        backgroundColor: isActive('/products') ? '#FF725E' : 'transparent',
                        '&:hover': { backgroundColor: '#FF725E' },
                        cursor: 'pointer',
                        color: '#000000'
                    }}
                >
                    <ListItemIcon>
                        <InventoryIcon sx={{ color: '#000000' }} />
                    </ListItemIcon>
            <ListItemText primary="Products" />
                </ListItem>
                <ListItem
                    button
                    component={Link}
                    to="/categories"
                    sx={{
                        backgroundColor: isActive('/categories') ? '#FF725E' : 'transparent',
                        '&:hover': { backgroundColor: '#FF725E' },
                        cursor: 'pointer',
                        color: '#000000'
                    }}
                >
                    <ListItemIcon>
                        <CategoryIcon sx={{ color: '#000000' }} />
                    </ListItemIcon>
                    <ListItemText primary="Categories" />
                </ListItem>
                <ListItem
                    button
                    component={Link}
                    to="/orders"
                    sx={{
                        backgroundColor: isActive('/orders') ? '#FF725E' : 'transparent',
                        '&:hover': { backgroundColor: '#FF725E' },
                        cursor: 'pointer',
                        color: '#000000'
                    }}
                >
                    <ListItemIcon>
                        <ListAltIcon sx={{ color: '#000000' }} />
                    </ListItemIcon>
                    <ListItemText primary="Orders" />
                </ListItem>
            </List>
        </Box>
    );
};

export default Sidebar;
