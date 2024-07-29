import React, { useEffect, useState } from 'react';
import { Grid, Paper, Typography, CircularProgress } from '@mui/material';
import { getTotalUsers, getTotalProducts, getTotalOrders, getTotalRevenue, getOrderStatusCounts } from '../services/api';
import { PieChart, Pie, Cell, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042'];

const Dashboard = () => {
    const [stats, setStats] = useState({
        totalUsers: 0,
        totalProducts: 0,
        totalOrders: 0,
        totalRevenue: 0,
    });
    const [orderStatusCounts, setOrderStatusCounts] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchStats = async () => {
            try {
                const [usersRes, productsRes, ordersRes, revenueRes, orderStatusCountsRes] = await Promise.all([
                    getTotalUsers(),
                    getTotalProducts(),
                    getTotalOrders(),
                    getTotalRevenue(),
                    getOrderStatusCounts(),
                ]);

                setStats({
                    totalUsers: usersRes.data.totalUsers,
                    totalProducts: productsRes.data.totalProducts,
                    totalOrders: ordersRes.data.totalOrders,
                    totalRevenue: revenueRes.data.totalRevenue,
                });

                const formattedStatusCounts = orderStatusCountsRes.data.map(status => ({
                    name: status._id,
                    value: status.count,
                }));

                setOrderStatusCounts(formattedStatusCounts);
                setLoading(false);
            } catch (error) {
                console.error('Error fetching statistics:', error);
                setError('Error fetching statistics');
                setLoading(false);
            }
        };

        fetchStats();
    }, []);

    if (loading) {
        return <div style={{ textAlign: 'center', marginTop: '20px' }}><CircularProgress /></div>;
    }

    if (error) {
        return <div style={{ textAlign: 'center', marginTop: '20px' }}>{error}</div>;
    }

    return (
        <div style={{ padding: '20px' }}>
            <Typography variant="h4" gutterBottom>
                Thống kê
            </Typography>
            <Grid container spacing={3}>
                <Grid item xs={12} sm={6} md={3}>
                    <Paper elevation={3} style={{ padding: '20px' }}>
                        <Typography variant="h6" gutterBottom>
                            Tổng số người dùng
                        </Typography>
                        <Typography variant="h4">
                            {stats.totalUsers}
                        </Typography>
                    </Paper>
                </Grid>
                <Grid item xs={12} sm={6} md={3}>
                    <Paper elevation={3} style={{ padding: '20px' }}>
                        <Typography variant="h6" gutterBottom>
                            Tổng số sản phẩm
                        </Typography>
                        <Typography variant="h4">
                            {stats.totalProducts}
                        </Typography>
                    </Paper>
                </Grid>
                <Grid item xs={12} sm={6} md={3}>
                    <Paper elevation={3} style={{ padding: '20px' }}>
                        <Typography variant="h6" gutterBottom>
                            Tổng số hóa đơn
                        </Typography>
                        <Typography variant="h4">
                            {stats.totalOrders}
                        </Typography>
                    </Paper>
                </Grid>
                <Grid item xs={12} sm={6} md={3}>
                    <Paper elevation={3} style={{ paddingTop: '20px', paddingBottom: '20px', paddingLeft:'10px',paddingRight:'10px' }}>
                        <Typography variant="h6" gutterBottom>
                            Tổng doanh thu
                        </Typography>
                        <Typography variant="h4">
                            {stats.totalRevenue.toLocaleString() + ' VNĐ'}
                        </Typography>
                    </Paper>
                </Grid>
                <Grid item xs={12}>
                    <Paper elevation={3} style={{ padding: '20px' }}>
                        <Typography variant="h6" gutterBottom>
                            Thống kê đơn hàng
                        </Typography>
                        <ResponsiveContainer width="100%" height={300}>
                            <PieChart>
                                <Pie
                                    data={orderStatusCounts}
                                    cx="50%"
                                    cy="50%"
                                    outerRadius={100}
                                    fill="#8884d8"
                                    dataKey="value"
                                    label
                                >
                                    {orderStatusCounts.map((entry, index) => (
                                        <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                                    ))}
                                </Pie>
                                <Tooltip />
                                <Legend />
                            </PieChart>
                        </ResponsiveContainer>
                    </Paper>
                </Grid>
            </Grid>
        </div>
    );
};

export default Dashboard;
