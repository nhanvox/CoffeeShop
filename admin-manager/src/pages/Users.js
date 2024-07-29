// src/pages/Users.js
import React, { useEffect, useState } from 'react';
import {
  Button, IconButton, CircularProgress, Dialog, DialogActions,
  DialogContent, DialogContentText, DialogTitle, TextField, Table, TableBody,
  TableCell, TableContainer, TableHead, TableRow, Paper, Typography
} from '@mui/material';
import { Edit, Delete } from '@mui/icons-material';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const Users = () => {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [search, setSearch] = useState('');
  const [openConfirmDialog, setOpenConfirmDialog] = useState(false);
  const [userToDelete, setUserToDelete] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchUsersAndProfiles = async () => {
      try {
        const usersResponse = await axios.get('http://192.168.1.121:3000/getallusers');
        const profilesResponse = await axios.get('http://192.168.1.121:3000/profiles');

        const profilesArray = profilesResponse.data.profiles || profilesResponse.data; // Adjust according to the actual response structure
        if (!Array.isArray(profilesArray)) {
          throw new Error('Invalid profiles data format');
        }

        const profilesMap = profilesArray.reduce((map, profile) => {
          map[profile.userid] = profile;
          return map;
        }, {});

        const usersWithProfiles = usersResponse.data.map(user => ({
          ...user,
          profile: profilesMap[user._id] || { name: 'Trống', phoneNumber: 'Trống', address: 'Trống' }
        }));

        setUsers(usersWithProfiles);
        setLoading(false);
      } catch (error) {
        console.error('Error fetching users and profiles:', error);
        setLoading(false);
        setError('Error fetching users and profiles');
      }
    };

    fetchUsersAndProfiles();
  }, []);

  const handleEdit = (id) => {
    navigate(`/edit-user/${id}`);
  };

  const handleDeleteClick = (id) => {
    setUserToDelete(id);
    setOpenConfirmDialog(true);
  };

  const handleDelete = () => {
    axios.delete(`http://192.168.1.121:3000/deleteuser/${userToDelete}`)
      .then(response => {
        setUsers(users.filter(user => user._id !== userToDelete));
        setOpenConfirmDialog(false);
        setUserToDelete(null);
      })
      .catch(error => {
        console.error('Error deleting user:', error);
        setOpenConfirmDialog(false);
      });
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
    <div style={{ fontFamily: 'Montserrat, sans-serif' }}>
      <Typography marginTop={'20px'} variant="h4" gutterBottom sx={{ fontFamily: 'Montserrat, sans-serif' }}>
        Danh sách người dùng
      </Typography>
      <div style={{ display: 'flex', alignItems: 'center', marginBottom: '20px', gap: '20px' }}>
        <Button
          sx={{ fontFamily: 'Montserrat, sans-serif', backgroundColor: '#3366ff', color: '#ffffff', '&:hover': { backgroundColor: '#254db3' } }}
          variant="contained"
          onClick={() => navigate('/add-user')}
        >
          Thêm người dùng
        </Button>
        <TextField
          label="Tìm kiếm người dùng"
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
              <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Họ Tên</TableCell>
              <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Email</TableCell>
              <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Địa chỉ</TableCell>
              <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Số điện thoại</TableCell>
              <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Ngày tạo</TableCell>
              <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>Hành động</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {filteredUsers.map((user, index) => (
              <TableRow key={user._id}>
                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif', textAlign: 'center' }}>{index + 1}</TableCell>
                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>{user.profile?.name || 'Trống'}</TableCell>
                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>{user.email}</TableCell>
                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>{user.profile?.address || 'Trống'}</TableCell>
                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>{user.profile?.phoneNumber || 'Trống'}</TableCell>
                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif' }}>{new Date(user.createdAt).toLocaleDateString()}</TableCell>
                <TableCell sx={{ fontFamily: 'Montserrat, sans-serif', textAlign: 'center' }}>
                  <IconButton aria-label="edit" onClick={() => handleEdit(user._id)} sx={{ color: '#3366ff' }}>
                    <Edit />
                  </IconButton>
                  <IconButton aria-label="delete" onClick={() => handleDeleteClick(user._id)} sx={{ color: 'red' }}>
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
            Bạn có chắc muốn xóa người dùng này?
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleCloseConfirmDialog} sx={{ backgroundColor: 'yellow', color: 'black', fontFamily: 'Montserrat, sans-serif' }}>Hủy</Button>
          <Button onClick={handleDelete} sx={{ backgroundColor: 'red', color: 'white', fontFamily: 'Montserrat, sans-serif' }}>Xóa</Button>
        </DialogActions>
      </Dialog>
    </div>
  );
};

export default Users;
