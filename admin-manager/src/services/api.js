// src/services/api.js
import axios from "axios";

const api = axios.create({
  baseURL: 'http://192.168.1.173:3000',
});

// User API
export const getUsers = () => api.get("/getAllUsers");
export const addUser = (user) => api.post("/register", user);
export const getUserById = (id) => api.get(`/getuserinfobyid/${id}`);
export const updateUser = (id, user) => api.put(`/updateuser/${id}`, user);
export const deleteUser = (id) => api.delete(`/deleteuser/${id}`);
export const getTotalUsers = () => api.get("/totalusers");

// Product API
export const getProducts = () => api.get("/products");
export const addProduct = (product) => api.post("/products", product);
export const getProductById = (id) => api.get(`/products/${id}`);
export const updateProduct = (id, product) =>
  api.put(`/products/${id}`, product);
export const deleteProduct = (id) => api.delete(`/products/${id}`);
export const getTotalProducts = () => api.get("/totalproducts");

// Category API
export const getCategories = () => api.get("/getallcategory");
export const addCategory = (category) => api.post("/addcategory", category);
export const getCategoryById = (id) => api.get(`/getcategorybyid/${id}`);
export const updateCategory = (id, category) =>
  api.put(`/updatecategory/${id}`, category);
export const deleteCategory = (id) => api.delete(`/deletecategory/${id}`);

// Order API
export const addToOrder = (order) => api.post("/order", order);
export const getOrderById = (id) => api.get(`/order/${id}`);
export const getOrdersByUser = (id) => api.get(`/ordersbyuser/${id}`);
export const getAllOrders = () => api.get("/orders");
export const getOrdersByStatus = (status) => api.get(`/status/${status}`);
export const updateOrderStatus = (id, status) => api.put(`/order/${id}/status`, { status });
export const getTotalOrders = () => api.get("/totalorders");
export const getTotalRevenue = () => api.get("/totalrevenue");
export const getOrderStatusCounts = () => api.get("/orderstatuscounts");