import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Button, IconButton, List, ListItem, ListItemSecondaryAction, ListItemText, CircularProgress, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, Typography, TextField } from '@mui/material';
import { Visibility, Delete } from '@mui/icons-material';
import { useNavigate } from 'react-router-dom';

const Users = () => {
    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [search, setSearch] = useState('');
    const [selectedUser, setSelectedUser] = useState(null);
    const [openProfileDialog, setOpenProfileDialog] = useState(false);
    const [openConfirmDialog, setOpenConfirmDialog] = useState(false);
    const [userToDelete, setUserToDelete] = useState(null);
    const navigate = useNavigate();

    useEffect(() => {
        axios.get('http://192.168.175.111:3000/getallusers')
            .then(response => {
                setUsers(response.data);
                setLoading(false);
            })
            .catch(error => {
                console.error('Error fetching users:', error);
                setError('Error fetching users');
                setLoading(false);
            });
    }, []);

    const handleView = (id) => {
        axios.get(`http://192.168.175.111:3000/profilebyuser/${id}`)
            .then(response => {
                if (response.data.success && response.data.profile) {
                    setSelectedUser(response.data.profile);
                } else {
                    setSelectedUser(null);
                }
                setOpenProfileDialog(true);
            })
            .catch(error => {
                setSelectedUser(null);
                setOpenProfileDialog(true);
            });
    };

    const handleDeleteClick = (id) => {
        setUserToDelete(id);
        setOpenConfirmDialog(true);
    };

    const handleDelete = () => {
        axios.delete(`http://192.168.175.111:3000/deleteuser/${userToDelete}`)
            .then(response => {
                setUsers(users.filter(user => user._id !== userToDelete));
                setOpenConfirmDialog(false);
                setUserToDelete(null);
            })
            .catch(error => {
                console.error('Error deleting user:', error);
                setError('Error deleting user');
                setOpenConfirmDialog(false);
            });
    };

    const handleCloseProfileDialog = () => {
        setOpenProfileDialog(false);
        setSelectedUser(null);
    };

    const handleCloseConfirmDialog = () => {
        setOpenConfirmDialog(false);
        setUserToDelete(null);
    };

    const handleSearchChange = (event) => {
        setSearch(event.target.value);
    };

    const filteredUsers = users.filter(user =>
        user.email.toLowerCase().includes(search.toLowerCase())
    );

    if (loading) {
        return <div><CircularProgress /></div>; // Hiển thị trạng thái tải
    }

    if (error) {
        return <div>{error}</div>; // Hiển thị lỗi nếu có
    }

    return (
        <div>
            <h1>Danh sách người dùng</h1>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
                <Button variant="contained" color="primary" onClick={() => navigate('/add-user')} sx={{ marginBottom: '20px' }}>
                    Thêm người dùng
                </Button>
                <TextField
                    label="Tìm kiếm người dùng"
                    variant="outlined"
                    value={search}
                    onChange={handleSearchChange}
                    style={{ marginLeft: 'auto' }}
                    sx={{ '& .MuiInputLabel-root': { fontSize: '12px', textAlign: 'center', top: '-4px' } }}
                    InputProps={{ sx: { height: '39px' } }}
                />
            </div>
            <List>
                {filteredUsers.map(user => (
                    <ListItem key={user._id} sx={{ border: '1px solid #ddd', borderRadius: '4px', marginBottom: '10px' }}>
                        <ListItemText primary={user.email} />
                        <ListItemSecondaryAction>
                            <IconButton edge="end" aria-label="view" onClick={() => handleView(user._id)}>
                                <Visibility />
                            </IconButton>
                            <IconButton edge="end" aria-label="delete" onClick={() => handleDeleteClick(user._id)}>
                                <Delete />
                            </IconButton>
                        </ListItemSecondaryAction>
                    </ListItem>
                ))}
            </List>
            <Dialog open={openProfileDialog} onClose={handleCloseProfileDialog}>
                <DialogTitle>Thông tin người dùng</DialogTitle>
                <DialogContent>
                    <DialogContentText component="div">
                        {selectedUser ? (
                            <div>
                                <Typography>Họ tên: {selectedUser.name || ''}</Typography>
                                <Typography>Số điện thoại: {selectedUser.phoneNumber || ''}</Typography>
                                <Typography>Địa chỉ: {selectedUser.address || ''}</Typography>
                            </div>
                        ) : (
                            <Typography>Thông tin người dùng chưa được cập nhật.</Typography>
                        )}
                    </DialogContentText>
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleCloseProfileDialog} color="primary">Đóng</Button>
                </DialogActions>
            </Dialog>
            <Dialog open={openConfirmDialog} onClose={handleCloseConfirmDialog}>
                <DialogTitle>Xác nhận xóa</DialogTitle>
                <DialogContent>
                    <DialogContentText>
                        Bạn có chắc muốn xóa người dùng này?
                    </DialogContentText>
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleCloseConfirmDialog} color="primary">Hủy</Button>
                    <Button onClick={handleDelete} color="primary">Xóa</Button>
                </DialogActions>
            </Dialog>
        </div>
    );
};

export default Users;
