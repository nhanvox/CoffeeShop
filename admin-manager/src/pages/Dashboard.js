// src/pages/Dashboard.js
import React, { useEffect, useState } from 'react';
import { Grid, Paper, Typography, Box } from '@mui/material';
import axios from 'axios';
import { People, Category, ListAlt, MonetizationOn } from '@mui/icons-material';

const Dashboard = () => {
    const [stats, setStats] = useState({
        totalCustomers: 0,
        totalProducts: 0,
        totalCategories: 0,
        totalOrders: 0,
        totalRevenue: 0
    });

    useEffect(() => {
        const fetchData = async () => {
            try {
                // Replace with your API endpoints
                const customers = await axios.get('http://192.168.1.173:3000/getallusers');
                const products = await axios.get('http://192.168.1.173:3000/products');
                const categories = await axios.get('http://192.168.1.173:3000/getallcategory');
                // const orders = await axios.get('http://192.168.1.173:3000/orders');
                // const revenue = await axios.get('http://192.168.1.173:3000/revenue');

                setStats({
                    totalCustomers: customers.data.length,
                    totalProducts: products.data.length,
                    totalCategories: categories.data.length,
                    // totalOrders: orders.data.length,
                    // totalRevenue: revenue.data.total
                });
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        };

        fetchData();
    }, []);

    return (
        <div style={{ padding: '20px' }}>
            <Typography variant="h4" gutterBottom>
                Admin Dashboard
            </Typography>
            <Grid container spacing={3}>
                <Grid item xs={12} md={3}>
                    <Paper style={{ padding: '20px', textAlign: 'center' }}>
                        <Box display="flex" alignItems="center" justifyContent="center">
                            <People style={{ fontSize: 40, marginRight: 10 }} />
                            <div>
                                <Typography variant="h6">{stats.totalCustomers}</Typography>
                                <Typography>Tổng số khách hàng</Typography>
                            </div>
                        </Box>
                    </Paper>
                </Grid>
                <Grid item xs={12} md={3}>
                    <Paper style={{ padding: '20px', textAlign: 'center' }}>
                        <Box display="flex" alignItems="center" justifyContent="center">
                            <Category style={{ fontSize: 40, marginRight: 10 }} />
                            <div>
                                <Typography variant="h6">{stats.totalProducts}</Typography>
                                <Typography>Tổng số sản phẩm</Typography>
                            </div>
                        </Box>
                    </Paper>
                </Grid>
                <Grid item xs={12} md={3}>
                    <Paper style={{ padding: '20px', textAlign: 'center' }}>
                        <Box display="flex" alignItems="center" justifyContent="center">
                            <ListAlt style={{ fontSize: 40, marginRight: 10 }} />
                            <div>
                                <Typography variant="h6">{stats.totalCategories}</Typography>
                                <Typography>Tổng số thể loại</Typography>
                            </div>
                        </Box>
                    </Paper>
                </Grid>
                <Grid item xs={12} md={3}>
                    <Paper style={{ padding: '20px', textAlign: 'center' }}>
                        <Box display="flex" alignItems="center" justifyContent="center">
                            <MonetizationOn style={{ fontSize: 40, marginRight: 10 }} />
                            <div>
                                <Typography variant="h6">{stats.totalRevenue} $</Typography>
                                <Typography>Tổng lợi nhuận</Typography>
                            </div>
                        </Box>
                    </Paper>
                </Grid>
            </Grid>
        </div>
    );
};

export default Dashboard;
