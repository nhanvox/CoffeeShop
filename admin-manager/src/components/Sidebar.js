// src/components/Sidebar.js
import React from 'react';
import { List, ListItem, ListItemText, ListItemIcon, Box, Collapse, Typography } from '@mui/material';
import { Link, useLocation } from 'react-router-dom';
import DashboardIcon from '@mui/icons-material/Dashboard';
import ShoppingCartIcon from '@mui/icons-material/ShoppingCart';
import PeopleIcon from '@mui/icons-material/People';
import BarChartIcon from '@mui/icons-material/BarChart';
import ExpandLess from '@mui/icons-material/ExpandLess';
import ExpandMore from '@mui/icons-material/ExpandMore';
import CategoryIcon from '@mui/icons-material/Category';

const Sidebar = () => {
    const [open, setOpen] = React.useState({ products: false, orders: false });
    const location = useLocation();

    const handleClick = (section) => {
        setOpen(prevOpen => ({ ...prevOpen, [section]: !prevOpen[section] }));
    };

    const isActive = (path) => {
        return location.pathname === path;
    };

    return (
        <Box
            sx={{
                height: '100vh',
                backgroundColor: '#ffffff',
                position: 'sticky',
                top: 0,
                width: '220px',
                borderRight: '1px solid #e0e0e0'
            }}
        >
            <List>
                <ListItem
                    button
                    component={Link}
                    to="/dashboard"
                    sx={{
                        backgroundColor: isActive('/dashboard') ? '#e0f7fa' : '#ffffff',
                        '&:hover': { backgroundColor: '#e0f7fa' },
                        cursor: 'pointer',
                        color: '#0288d1'
                    }}
                >
                    <ListItemIcon>
                        <DashboardIcon sx={{ color: isActive('/dashboard') ? '#0288d1' : '#0288d1' }} />
                    </ListItemIcon>
                    <ListItemText primary="Dashboard" sx={{ color: isActive('/dashboard') ? '#0288d1' : '#0288d1' }} />
                </ListItem>

                <ListItem
                    button
                    onClick={() => handleClick('products')}
                    sx={{
                        backgroundColor: isActive('/products') ? '#e0f7fa' : '#ffffff',
                        '&:hover': { backgroundColor: '#e0f7fa' },
                        cursor: 'pointer',
                        color: '#0288d1'
                    }}
                >
                    <ListItemIcon>
                        <CategoryIcon sx={{ color: isActive('/products') ? '#0288d1' : '#0288d1' }} />
                    </ListItemIcon>
                    <ListItemText primary="Products" sx={{ color: isActive('/products') ? '#0288d1' : '#0288d1' }} />
                    {open.products ? <ExpandLess sx={{ color: '#0288d1' }} /> : <ExpandMore sx={{ color: '#0288d1' }} />}
                </ListItem>
                <Collapse in={open.products} timeout="auto" unmountOnExit>
                    <List component="div" disablePadding>
                        <ListItem button component={Link} to="/products" sx={{ pl: 4 }}>
                            <ListItemText primary="All Products" sx={{ color: '#0288d1' }} />
                        </ListItem>
                        <ListItem button component={Link} to="/products/new" sx={{ pl: 4 }}>
                            <ListItemText primary="Add Product" sx={{ color: '#0288d1' }} />
                        </ListItem>
                    </List>
                </Collapse>

                <ListItem
                    button
                    onClick={() => handleClick('orders')}
                    sx={{
                        backgroundColor: isActive('/orders') ? '#e0f7fa' : '#ffffff',
                        '&:hover': { backgroundColor: '#e0f7fa' },
                        cursor: 'pointer',
                        color: '#0288d1'
                    }}
                >
                    <ListItemIcon>
                        <ShoppingCartIcon sx={{ color: isActive('/orders') ? '#0288d1' : '#0288d1' }} />
                    </ListItemIcon>
                    <ListItemText primary="Orders" sx={{ color: isActive('/orders') ? '#0288d1' : '#0288d1' }} />
                    {open.orders ? <ExpandLess sx={{ color: '#0288d1' }} /> : <ExpandMore sx={{ color: '#0288d1' }} />}
                </ListItem>
                <Collapse in={open.orders} timeout="auto" unmountOnExit>
                    <List component="div" disablePadding>
                        <ListItem button component={Link} to="/orders" sx={{ pl: 4 }}>
                            <ListItemText primary="All Orders" sx={{ color: '#0288d1' }} />
                        </ListItem>
                        <ListItem button component={Link} to="/orders/new" sx={{ pl: 4 }}>
                            <ListItemText primary="Add Order" sx={{ color: '#0288d1' }} />
                        </ListItem>
                    </List>
                </Collapse>

                <ListItem
                    button
                    component={Link}
                    to="/customers"
                    sx={{
                        backgroundColor: isActive('/customers') ? '#e0f7fa' : '#ffffff',
                        '&:hover': { backgroundColor: '#e0f7fa' },
                        cursor: 'pointer',
                        color: '#0288d1'
                    }}
                >
                    <ListItemIcon>
                        <PeopleIcon sx={{ color: isActive('/customers') ? '#0288d1' : '#0288d1' }} />
                    </ListItemIcon>
                    <ListItemText primary="Customers" sx={{ color: isActive('/customers') ? '#0288d1' : '#0288d1' }} />
                </ListItem>

                <ListItem
                    button
                    component={Link}
                    to="/statistics"
                    sx={{
                        backgroundColor: isActive('/statistics') ? '#e0f7fa' : '#ffffff',
                        '&:hover': { backgroundColor: '#e0f7fa' },
                        cursor: 'pointer',
                        color: '#0288d1'
                    }}
                >
                    <ListItemIcon>
                        <BarChartIcon sx={{ color: isActive('/statistics') ? '#0288d1' : '#0288d1' }} />
                    </ListItemIcon>
                    <ListItemText primary="Statistics" sx={{ color: isActive('/statistics') ? '#0288d1' : '#0288d1' }} />
                </ListItem>
            </List>
        </Box>
    );
};

export default Sidebar;
