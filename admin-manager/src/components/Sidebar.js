// src/components/Sidebar.js
import React from 'react';
import { List, ListItem, ListItemText } from '@mui/material';
import { Link } from 'react-router-dom';

const Sidebar = () => {
    return (
        <div style={{ height: '100vh', width: '220px', backgroundColor: '#171717', position: 'sticky', top: 0 }}>
            <List>
                <ListItem button component={Link} to="/users">
                    <ListItemText primary="Người dùng" style={{ color: '#ffffff' }} />
                </ListItem>
                <ListItem button component={Link} to="/products">
                    <ListItemText primary="Sản phẩm" style={{ color: '#ffffff' }} />
                </ListItem>
                <ListItem button component={Link} to="/categories">
                    <ListItemText primary="Thể loại" style={{ color: '#ffffff' }} />
                </ListItem>
            </List>
        </div>
    );
};

export default Sidebar;
