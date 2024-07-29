// src/pages/EditCategory.js
import React, { useState, useEffect } from "react";
import axios from "axios";
import { useParams, useNavigate } from "react-router-dom";

const EditCategory = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [name, setName] = useState("");

    useEffect(() => {
        axios.get(`http://192.168.1.173:3000/category/${id}`)
            .then(response => {
                setName(response.data.name);
            })
            .catch(error => console.error('Error fetching category:', error));
    }, [id]);

    const handleSubmit = async (event) => {
        event.preventDefault();
        try {
            await axios.put(`http://192.168.1.173:3000/category/${id}`, { name });
            alert('Category updated successfully');
            navigate('/categories');
        } catch (error) {
            console.error('Error updating category:', error);
        }
    };

  return (
    <div>
      <h1>Edit Category</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="Name"
          required
        />
        <button type="submit">Update Category</button>
      </form>
    </div>
  );
};

export default EditCategory;
