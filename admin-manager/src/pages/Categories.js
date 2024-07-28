import React, { useEffect, useState } from 'react';
import { Button, IconButton, List, ListItem, ListItemSecondaryAction, ListItemText, CircularProgress, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, TextField } from '@mui/material';
import { Edit, Delete } from '@mui/icons-material';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const Categories = () => {
    const [categories, setCategories] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [search, setSearch] = useState('');
    const [openConfirmDialog, setOpenConfirmDialog] = useState(false);
    const [categoryToDelete, setCategoryToDelete] = useState(null);
    const navigate = useNavigate();

    useEffect(() => {
        axios.get('http://192.168.175.111:3000/getallcategory')
            .then(response => {
                if (response.data && Array.isArray(response.data.categories)) {
                    setCategories(response.data.categories);
                } else {
                    setError('Invalid response format');
                }
                setLoading(false);
            })
            .catch(error => {
                setError('Error fetching categories');
                setLoading(false);
                console.error('Error fetching categories:', error);
            });
    }, []);

    const handleEdit = (id) => {
        navigate(`/edit-category/${id}`);
    };

    const handleDeleteClick = (id) => {
        setCategoryToDelete(id);
        setOpenConfirmDialog(true);
    };

    const handleDelete = () => {
        axios.delete(`http://192.168.175.111:3000/category/${categoryToDelete}`)
            .then(response => {
                setCategories(categories.filter(category => category._id !== categoryToDelete));
                setOpenConfirmDialog(false);
                setCategoryToDelete(null);
            })
            .catch(error => {
                console.error('Error deleting category:', error);
                setOpenConfirmDialog(false);
            });
    };

    const handleCloseConfirmDialog = () => {
        setOpenConfirmDialog(false);
        setCategoryToDelete(null);
    };

    const handleSearchChange = (event) => {
        setSearch(event.target.value);
    };

    const filteredCategories = categories.filter(category =>
        category.name.toLowerCase().includes(search.toLowerCase())
    );

    if (loading) {
        return <div><CircularProgress /></div>; // Hiển thị trạng thái tải
    }

    if (error) {
        return <div>{error}</div>; // Hiển thị lỗi nếu có
    }

    return (
        <div>
            <h1>Danh sách thể loại</h1>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '20px' }}>
                <Button variant="contained" color="primary" onClick={() => navigate('/add-category')}>
                    Thêm thể loại
                </Button>
                <TextField
                    label="Tìm kiếm thể loại"
                    variant="outlined"
                    value={search}
                    onChange={handleSearchChange}
                    style={{ marginLeft: 'auto' }}
                    sx={{ '& .MuiInputLabel-root': { fontSize: '12px', textAlign: 'center', top: '-4px' } }}
                    InputProps={{ sx: { height: '39px' } }}
                />
            </div>
            <List>
                {filteredCategories.map(category => (
                    <ListItem key={category._id} sx={{ border: '1px solid #ddd', borderRadius: '4px', marginBottom: '10px' }}>
                        <ListItemText primary={category.name} />
                        <ListItemSecondaryAction>
                            <IconButton edge="end" aria-label="edit" onClick={() => handleEdit(category._id)}>
                                <Edit />
                            </IconButton>
                            <IconButton edge="end" aria-label="delete" onClick={() => handleDeleteClick(category._id)}>
                                <Delete />
                            </IconButton>
                        </ListItemSecondaryAction>
                    </ListItem>
                ))}
            </List>
            <Dialog open={openConfirmDialog} onClose={handleCloseConfirmDialog}>
                <DialogTitle>Xác nhận xóa</DialogTitle>
                <DialogContent>
                    <DialogContentText>
                        Bạn có chắc muốn xóa thể loại này?
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

export default Categories;
