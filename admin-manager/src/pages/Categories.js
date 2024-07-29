// src/pages/Categories.js
import React, { useEffect, useState } from "react";
import {
  Button,
  IconButton,
  List,
  ListItem,
  ListItemSecondaryAction,
  ListItemText,
  CircularProgress,
} from "@mui/material";
import { Edit, Delete } from "@mui/icons-material";
import axios from "axios";
import { useNavigate } from "react-router-dom";

const Categories = () => {
  const [categories, setCategories] = useState([]); // Khởi tạo là một mảng
  const [loading, setLoading] = useState(true); // Để theo dõi trạng thái tải dữ liệu
  const [error, setError] = useState(null); // Để theo dõi lỗi nếu có
  const navigate = useNavigate();

  useEffect(() => {
    axios
      .get("http://192.168.1.119:3000/getallcategory")
      .then((response) => {
        if (response.data && Array.isArray(response.data.categories)) {
          setCategories(response.data.categories);
        } else {
          setError("Invalid response format");
        }
        setLoading(false);
      })
      .catch((error) => {
        setError("Error fetching categories");
        setLoading(false);
        console.error("Error fetching categories:", error);
      });
  }, []);

  const handleEdit = (id) => {
    navigate(`/edit-category/${id}`);
  };

  const handleDelete = (id) => {
    // Gọi API để xóa category
    axios
      .delete(`http://192.168.1.119:3000/category/${id}`)
      .then((response) => {
        setCategories(categories.filter((category) => category._id !== id));
      })
      .catch((error) => {
        console.error("Error deleting category:", error);
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
      <h1>Categories</h1>
      <Button
        variant="contained"
        color="primary"
        onClick={() => navigate("/add-category")}
      >
        Add Category
      </Button>
      <List>
        {categories.map((category) => (
          <ListItem
            key={category._id}
            sx={{
              border: "1px solid #ddd",
              borderRadius: "4px",
              marginBottom: "10px",
            }}
          >
            <ListItemText primary={category.name} />
            <ListItemSecondaryAction>
              <IconButton
                edge="end"
                aria-label="edit"
                onClick={() => handleEdit(category._id)}
              >
                <Edit />
              </IconButton>
              <IconButton
                edge="end"
                aria-label="delete"
                onClick={() => handleDelete(category._id)}
              >
                <Delete />
              </IconButton>
            </ListItemSecondaryAction>
          </ListItem>
        ))}
      </List>
    </div>
  );
};

export default Categories;
