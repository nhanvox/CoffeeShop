// src/pages/Users.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import { Button, IconButton, List, ListItem, ListItemSecondaryAction, ListItemText, CircularProgress } from '@mui/material';
import { Edit, Delete } from '@mui/icons-material';
import { useNavigate } from 'react-router-dom';

const Users = () => {
    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const navigate = useNavigate();

  useEffect(() => {
    axios
      .get("http://192.168.1.119:3000/getallusers")
      .then((response) => {
        setUsers(response.data);
        setLoading(false);
      })
      .catch((error) => {
        console.error("Error fetching users:", error);
        setError("Error fetching users");
        setLoading(false);
      });
  }, []);

    const handleDelete = (id) => {
        axios.delete(`http://192.168.175.111:3000/deleteuser/${id}`)
            .then(response => {
                setUsers(users.filter(user => user._id !== id));
            })
            .catch(error => {
                console.error('Error deleting user:', error);
                setError('Error deleting user');
            });
    };

  if (loading) {
    return (
      <div>
        <CircularProgress />
      </div>
    ); // Hiển thị trạng thái tải
  }

  if (error) {
    return <div>{error}</div>; // Hiển thị lỗi nếu có
  }

    return (
        <div>
            <h1>Users</h1>
            <Button variant="contained" color="primary" onClick={() => navigate('/add-user')} sx={{ marginBottom: '20px' }}>
                Add User
            </Button>
            <List>
                {users.map(user => (
                    <ListItem key={user._id} sx={{ border: '1px solid #ddd', borderRadius: '4px', marginBottom: '10px' }}>
                        <ListItemText primary={user.email} />
                        <ListItemSecondaryAction>
                            <IconButton edge="end" aria-label="edit" onClick={() => navigate(`/edit-user/${user._id}`)}>
                                <Edit />
                            </IconButton>
                            <IconButton edge="end" aria-label="delete" onClick={() => handleDelete(user._id)}>
                                <Delete />
                            </IconButton>
                        </ListItemSecondaryAction>
                    </ListItem>
                ))}
            </List>
        </div>
    );
};

export default Users;
