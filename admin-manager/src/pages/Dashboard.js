// src/pages/Dashboard.js
import React from 'react';
import { Grid, Paper, Typography } from '@mui/material';
import { Link } from 'react-router-dom';

const Dashboard = () => {
    return (
        <div style={{ padding: '20px' }}>
            <Typography variant="h4" gutterBottom>
                Admin Dashboard
            </Typography>
            <Grid container spacing={3}>
                <Grid item xs={12} md={4}>
                    <Link to="/users" style={{ textDecoration: 'none' }}>
                        <Paper style={{ padding: '20px', textAlign: 'center' }}>
                            <Typography variant="h6">Manage Users</Typography>
                        </Paper>
                    </Link>
                </Grid>
                <Grid item xs={12} md={4}>
                    <Link to="/products" style={{ textDecoration: 'none' }}>
                        <Paper style={{ padding: '20px', textAlign: 'center' }}>
                            <Typography variant="h6">Manage Products</Typography>
                        </Paper>
                    </Link>
                </Grid>
                <Grid item xs={12} md={4}>
                    <Link to="/categories" style={{ textDecoration: 'none' }}>
                        <Paper style={{ padding: '20px', textAlign: 'center' }}>
                            <Typography variant="h6">Manage Categories</Typography>
                        </Paper>
                    </Link>
                </Grid>
            </Grid>
        </div>
    );
};

export default Dashboard;
