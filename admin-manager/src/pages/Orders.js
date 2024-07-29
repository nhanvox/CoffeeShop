import React, { useEffect, useState } from 'react';
import {
    Button, CircularProgress, Dialog, DialogActions,
    DialogContent, DialogContentText, DialogTitle, TextField, Table, TableBody,
    TableCell, TableContainer, TableHead, TableRow, Paper, Typography, Select, MenuItem, FormControl, InputLabel
} from '@mui/material';
import axios from 'axios';
import { updateOrderStatus } from '../services/api';

const Orders = () => {
    const [orders, setOrders] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [search, setSearch] = useState('');
    const [statusFilter, setStatusFilter] = useState('');
    const [openWarningDialog, setOpenWarningDialog] = useState(false);
    const [warningMessage, setWarningMessage] = useState('');

    useEffect(() => {
        const fetchOrders = async () => {
            try {
                const response = await axios.get('http://192.168.1.173:3000/orders');
                if (Array.isArray(response.data.orders)) {
                    setOrders(response.data.orders);
                } else {
                    setOrders([]);
                }
                setLoading(false);
            } catch (error) {
                console.error('Error fetching orders:', error);
                setLoading(false);
                setError('Error fetching orders');
            }
        };

        fetchOrders();
    }, []);

    const handleSearchChange = (event) => {
        setSearch(event.target.value);
    };

    const handleStatusFilterChange = (event) => {
        setStatusFilter(event.target.value);
    };

    const handleConfirm = async (order) => {
        try {
            let newStatus = "Đã Xác Nhận";
            if (order.status === "Đã Xác Nhận") {
                newStatus = "Hoàn Thành";
            }
            await updateOrderStatus(order._id, newStatus);
            setOrders(orders.map(o => o._id === order._id ? { ...o, status: newStatus } : o));
        } catch (error) {
            console.error('Error confirming order:', error);
        }
    };

    const handleCancel = async (order) => {
        if (order.status === "Đã Xác Nhận" || order.status === "Hoàn Thành") {
            setWarningMessage('Đơn hàng đã xác nhận hoặc hoàn thành không thể hủy');
            setOpenWarningDialog(true);
            return;
        }

        try {
            await updateOrderStatus(order._id, "Đã Hủy");
            setOrders(orders.map(o => o._id === order._id ? { ...o, status: "Đã Hủy" } : o));
        } catch (error) {
            console.error('Error canceling order:', error);
        }
    };

    const handleCloseWarningDialog = () => {
        setOpenWarningDialog(false);
    };

    const filteredOrders = orders.filter(order =>
        (order.name.toLowerCase().includes(search.toLowerCase()) ||
            order.phoneNumber.toLowerCase().includes(search.toLowerCase()) ||
            order.address.toLowerCase().includes(search.toLowerCase())) &&
        (statusFilter === '' || order.status === statusFilter)
    );

    const formatPrice = (price) => {
        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + ' VNĐ';
    };

    if (loading) {
        return <div><CircularProgress /></div>; // Display loading state
    }

    if (error) {
        return <div>{error}</div>; // Display error if any
    }

    return (
        <div style={{ fontFamily: 'Montserrat, sans-serif' }}>
            <Typography marginTop={'20px'} variant="h4" gutterBottom sx={{ fontFamily: 'Montserrat, sans-serif' }}>
                Danh sách đơn hàng
            </Typography>
            <div style={{ display: 'flex', alignItems: 'center', marginBottom: '20px', gap: '20px' }}>
                <TextField
                    label="Tìm kiếm đơn hàng"
                    variant="outlined"
                    value={search}
                    onChange={handleSearchChange}
                    style={{ marginLeft: 'auto' }}
                    sx={{
                        backgroundColor: 'white',
                        '& .MuiInputLabel-root': { fontSize: '12px', textAlign: 'center', top: '-4px', fontFamily: 'Montserrat, sans-serif' },
                        '& .MuiOutlinedInput-root': { fontFamily: 'Montserrat, sans-serif' },
                        '& .MuiOutlinedInput-notchedOutline': { borderColor: 'rgba(0, 0, 0, 0.23)' }, // optional: to ensure the outline color is default
                    }}
                    InputProps={{ sx: { height: '39px' } }}
                />
                <FormControl variant="outlined" style={{ minWidth: 120 }}>
                    <InputLabel sx={{top:'-4px', fontSize: '12px', textAlign: 'center', fontFamily: 'Montserrat, sans-serif' }}>Trạng thái</InputLabel>
                    <Select
                        value={statusFilter}
                        onChange={handleStatusFilterChange}
                        label="Trạng thái"
                        sx={{ height: '39px', fontFamily: 'Montserrat, sans-serif', backgroundColor: 'white', fontSize: '12px' }}
                    >
                        <MenuItem value=""><em>Tất cả</em></MenuItem>
                        <MenuItem value="Chờ Xác Nhận">Chờ Xác Nhận</MenuItem>
                        <MenuItem value="Đã Xác Nhận">Đã Xác Nhận</MenuItem>
                        <MenuItem value="Hoàn Thành">Hoàn Thành</MenuItem>
                        <MenuItem value="Đã Hủy">Đã Hủy</MenuItem>
                    </Select>
                </FormControl>

            </div>
            <TableContainer component={Paper}>
                <Table sx={{ fontFamily: 'Montserrat, sans-serif' }}>
                    <TableHead>
                        <TableRow>
                            <TableCell sx={{ fontFamily: 'Montserrat, sans-serif', textAlign: 'center', width: '100px' }}>ID</TableCell>
                            <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Tên</TableCell>
                            <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Số điện thoại</TableCell>
                            <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Địa chỉ</TableCell>
                            <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Tổng số lượng</TableCell>
                            <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Tổng giá</TableCell>
                            <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Trạng thái</TableCell>
                            <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Ngày đặt hàng</TableCell>
                            <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Xác nhận ĐH</TableCell>
                            <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Hủy ĐH</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {filteredOrders.map((order, index) => (
                            <TableRow key={order._id}>
                                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif', textAlign: 'center' }}>{index + 1}</TableCell>
                                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>{order.name}</TableCell>
                                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>{order.phoneNumber}</TableCell>
                                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>{order.address}</TableCell>
                                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>{order.quantitysum}</TableCell>
                                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>{formatPrice(order.totalsum)}</TableCell>
                                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>{order.status}</TableCell>
                                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>{new Date(order.orderDate).toLocaleDateString()}</TableCell>
                                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>
                                    <Button onClick={() => handleConfirm(order)} sx={{ backgroundColor: 'green', color: 'white', fontFamily: 'Montserrat, sans-serif' }}>
                                        Xác nhận
                                    </Button>
                                </TableCell>
                                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>
                                    <Button onClick={() => handleCancel(order)} sx={{ backgroundColor: 'orange', color: 'white', fontFamily: 'Montserrat, sans-serif' }}>
                                        Hủy
                                    </Button>
                                </TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </TableContainer>
            <Dialog open={openWarningDialog} onClose={handleCloseWarningDialog}>
                <DialogTitle>Cảnh báo</DialogTitle>
                <DialogContent>
                    <DialogContentText>
                        {warningMessage}
                    </DialogContentText>
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleCloseWarningDialog} sx={{ backgroundColor: 'yellow', color: 'black', fontFamily: 'Montserrat, sans-serif' }}>OK</Button>
                </DialogActions>
            </Dialog>
        </div>
    );
};

export default Orders;
