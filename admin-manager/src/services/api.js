// src/services/api.js
import axios from 'axios';

const api = axios.create({
    baseURL: 'http://192.168.1.121:3000',
});

export const getUsers = () => api.get('/getAllUsers');
export const addUser = (user) => api.post('/register', user);
export const getUserById = (id) => api.get(`/getuserinfobyid/${id}`);
export const updateUser = (id, user) => api.put(`/updateuser/${id}`, user);
export const deleteUser = (id) => api.delete(`/deleteuser/${id}`);

export const getProducts = () => api.get('/products');
export const addProduct = (product) => api.post('/products', product);
export const getProductById = (id) => api.get(`/products/${id}`);
export const updateProduct = (id, product) => api.put(`/products/${id}`, product);
export const deleteProduct = (id) => api.delete(`/products/${id}`);

export const getCategories = () => api.get('/getallcategory');
export const addCategory = (category) => api.post('/addcategory', category);
export const getCategoryById = (id) => api.get(`/getcategorybyid/${id}`);
export const updateCategory = (id, category) => api.put(`/updatecategory/${id}`, category);
export const deleteCategory = (id) => api.delete(`/deletecategory/${id}`);
