// src/pages/Products.js
import React, { useEffect, useState } from "react";
import axios from "axios";
import { Link } from "react-router-dom";

const Products = () => {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    axios
      .get("http://192.168.1.119:3000/products")
      .then((response) => setProducts(response.data))
      .catch((error) => console.error("Error fetching products:", error));
  }, []);

  return (
    <div>
      <h1>Products</h1>
      <Link to="/add-product">Add Product</Link>
      <ul>
        {products.map((product) => (
          <li key={product._id}>
            {product.name}
            <Link to={`/edit-product/${product._id}`}>Edit</Link>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Products;
