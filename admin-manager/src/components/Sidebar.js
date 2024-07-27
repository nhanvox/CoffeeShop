// src/components/Sidebar.js
import React from 'react';
import { List, ListItem, ListItemText } from '@mui/material';
import { Link } from 'react-router-dom';

const Sidebar = () => {
    return (
        <div style={{ width: '200px' }}>
            <List>
                <ListItem button component={Link} to="/users">
                    <ListItemText primary="Users" />
                </ListItem>
                <ListItem button component={Link} to="/products">
                    <ListItemText primary="Products" />
                </ListItem>
                <ListItem button component={Link} to="/categories">
                    <ListItemText primary="Categories" />
                </ListItem>
            </List>
        </div>
    );
};

export default Sidebar;
