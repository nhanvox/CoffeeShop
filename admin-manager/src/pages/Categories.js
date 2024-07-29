import React, { useEffect, useState } from 'react';
import {
  Button, IconButton, CircularProgress, Dialog, DialogActions,
  DialogContent, DialogContentText, DialogTitle, TextField, Table, TableBody,
  TableCell, TableContainer, TableHead, TableRow, Paper
} from '@mui/material';
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
    axios.get('http://192.168.1.173:3000/getallcategory')
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
    axios.delete(`http://192.168.1.173:3000/category/${categoryToDelete}`)
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
    <div style={{ fontFamily: 'Montserrat, sans-serif' }}>
      <h1>Danh sách thể loại</h1>
      <div style={{ display: 'flex', alignItems: 'center', marginBottom: '20px', gap: '20px' }}>
        <Button 
          sx={{ 
            fontFamily: 'Montserrat, sans-serif',
            backgroundColor: '#3366ff', // Màu nền mới
            color: '#ffffff', // Màu văn bản
            '&:hover': {
              backgroundColor: '#254db3' // Màu nền khi hover
            }
          }} 
          variant="contained" 
          onClick={() => navigate('/add-category')}
        >
          Thêm thể loại
        </Button>
        <TextField
          label="Tìm kiếm thể loại"
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
      </div>
      <TableContainer component={Paper}>
        <Table sx={{ fontFamily: 'Montserrat, sans-serif' }}>
          <TableHead>
            <TableRow>
              <TableCell sx={{ fontFamily: 'Montserrat, sans-serif', textAlign: 'center', width: '100px' }}>ID</TableCell>
              <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Name</TableCell>
              <TableCell sx={{ fontFamily: 'Montserrat, sans-serif', textAlign: 'right', width: '100px' }}>Edit</TableCell>
              <TableCell sx={{ fontFamily: 'Montserrat, sans-serif', textAlign: 'center', width: '100px' }}>Delete</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {filteredCategories.map((category, index) => (
              <TableRow key={category._id}>
                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif', textAlign: 'center' }}>{index + 1}</TableCell>
                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>{category.name}</TableCell>
                <TableCell sx={{ textAlign: 'right', width: '100px' }}>
                  <IconButton edge="end" aria-label="edit" onClick={() => handleEdit(category._id)} sx={{ color: 'black', fontFamily: 'Montserrat, sans-serif' }}>
                    <Edit />
                  </IconButton>
                </TableCell>
                <TableCell sx={{ textAlign: 'center', width: '100px' }}>
                  <IconButton edge="end" aria-label="delete" onClick={() => handleDeleteClick(category._id)} sx={{ color: 'red', fontFamily: 'Montserrat, sans-serif' }}>
                    <Delete />
                  </IconButton>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
      <Dialog open={openConfirmDialog} onClose={handleCloseConfirmDialog}>
        <DialogTitle>Xác nhận xóa</DialogTitle>
        <DialogContent>
          <DialogContentText>
            Bạn có chắc muốn xóa thể loại này?
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <IconButton aria-label="edit" onClick={handleCloseConfirmDialog} sx={{ color: 'yellow', fontFamily: 'Montserrat, sans-serif' }}>
            <Edit />
          </IconButton>
          <IconButton aria-label="delete" onClick={handleDelete} sx={{ color: 'red', fontFamily: 'Montserrat, sans-serif' }}>
            <Delete />
          </IconButton>
        </DialogActions>
      </Dialog>
    </div>
  );
};

export default Categories;
