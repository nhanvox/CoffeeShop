// src/Router.js
import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Users from './pages/Users.js';
import AddUser from './pages/AddUser.js';
import EditUser from './pages/EditUser.js';
import Products from './pages/Products.js';
import AddProduct from './pages/AddProduct.js';
import EditProduct from './pages/EditProduct.js';
import Categories from './pages/Categories.js';
import AddCategory from './pages/AddCategory.js';
import EditCategory from './pages/EditCategory.js';
import Dashboard from './pages/Dashboard.js';

const AppRouter = () => (
    <Routes>
        <Route path="/" element={<Dashboard />} />
        <Route path="/users" element={<Users />} />
        <Route path="/add-user" element={<AddUser />} />
        <Route path="/edit-user/:id" element={<EditUser />} />
        <Route path="/products" element={<Products />} />
        <Route path="/add-product" element={<AddProduct />} />
        <Route path="/edit-product/:id" element={<EditProduct />} />
        <Route path="/categories" element={<Categories />} />
        <Route path="/add-category" element={<AddCategory />} />
        <Route path="/edit-category/:id" element={<EditCategory />} />
    </Routes>
);

export default AppRouter;
