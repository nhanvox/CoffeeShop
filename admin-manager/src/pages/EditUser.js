// src/pages/EditUser.js
import React, { useState, useEffect } from "react";
import axios from "axios";
import { useParams, useNavigate } from "react-router-dom";

const EditUser = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

    useEffect(() => {
        axios.get(`http://192.168.1.121:3000/getuserinfobyid/${id}`)
            .then(response => {
                setEmail(response.data.email);
            })
            .catch(error => console.error('Error fetching user:', error));
    }, [id]);

    const handleSubmit = async (event) => {
        event.preventDefault();
        try {
            await axios.put(`http://192.168.1.121:3000/updateuser/${id}`, { email, password });
            alert('User updated successfully');
            navigate('/users');
        } catch (error) {
            console.error('Error updating user:', error);
        }
    };

  return (
    <div>
      <h1>Edit User</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          placeholder="Email"
          required
        />
        <input
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          placeholder="Password"
        />
        <button type="submit">Update User</button>
      </form>
    </div>
  );
};

export default EditUser;
