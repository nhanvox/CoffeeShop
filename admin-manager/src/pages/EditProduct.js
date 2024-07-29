// src/pages/EditProduct.js
import React, { useState, useEffect } from "react";
import axios from "axios";
import { useParams, useNavigate } from "react-router-dom";

const EditProduct = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const [name, setName] = useState("");
  const [price, setPrice] = useState("");
  const [description, setDescription] = useState("");
  const [categoryid, setCategoryId] = useState("");

  useEffect(() => {
    axios
      .get(`http://192.168.1.119:3000/products/${id}`)
      .then((response) => {
        const product = response.data;
        setName(product.name);
        setPrice(product.price);
        setDescription(product.description);
        setCategoryId(product.categoryid);
      })
      .catch((error) => console.error("Error fetching product:", error));
  }, [id]);

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      await axios.put(`http://192.168.1.119:3000/products/${id}`, {
        name,
        price,
        description,
        categoryid,
      });
      alert("Product updated successfully");
      navigate("/products");
    } catch (error) {
      console.error("Error updating product:", error);
    }
  };

  return (
    <div>
      <h1>Edit Product</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="Name"
          required
        />
        <input
          type="number"
          value={price}
          onChange={(e) => setPrice(e.target.value)}
          placeholder="Price"
          required
        />
        <textarea
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          placeholder="Description"
        ></textarea>
        <input
          type="text"
          value={categoryid}
          onChange={(e) => setCategoryId(e.target.value)}
          placeholder="Category ID"
          required
        />
        <button type="submit">Update Product</button>
      </form>
    </div>
  );
};

export default EditProduct;
