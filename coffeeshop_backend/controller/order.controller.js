const OrderService = require("../services/order.service.js");

exports.addToOrder = async (req, res, next) => {
  try {
    const order = await OrderService.addToOrder(req.body);
    res.json({ success: true, order: order });
  } catch (err) {
    next(err);
  }
};

exports.getOrderById = async (req, res, next) => {
  try {
    const order = await OrderService.getOrderById(req.params.id);
    if (!order) {
      throw new Error("Order not found");
    }
    res.json({ success: true, order: order });
  } catch (err) {
    next(err);
  }
};

exports.getOrdersByUser = async (req, res, next) => {
  try {
    const { id: userId } = req.params;
    const orders = await OrderService.getOrdersByUser(userId);
    if (!orders || orders.length === 0) {
      return res
        .status(404)
        .json({ success: false, message: "No orders found for this user" });
    }
    res.status(200).json({ success: true, orders });
  } catch (err) {
    next(err);
  }
};

exports.getAllOrders = async (req, res, next) => {
  try {
    const orders = await OrderService.getAllOrders();
    res.json({ success: true, orders: orders });
  } catch (err) {
    next(err);
  }
};

exports.getOrdersByStatus = async (req, res, next) => {
  try {
    const orders = await OrderService.getOrdersByStatus(req.params.status);
    if (!orders || orders.length === 0) {
      return res
        .status(404)
        .json({ success: false, message: "No orders found for this status" });
    }
    res.status(200).json({ success: true, orders });
  } catch (err) {
    next(err);
  }
};
exports.updateStatus = async (req, res) => {
  const { id } = req.params;
  const { status } = req.body;

  try {
    const updatedOrder = await OrderService.updateStatus(id, status);
    res.status(200).json(updatedOrder);
  } catch (error) {
    res.status(500).json({ message: "Error updating order status", error });
  }
};
exports.getTotalRevenue = async (req, res) => {
  try {
    const totalRevenue = await OrderService.getTotalRevenue();
    res.json({ totalRevenue });
  } catch (error) {
    res.status(500).json({ message: 'Error fetching total revenue', error });
  }
};
exports.getTotalOrders = async (req, res) => {
  try {
    const totalOrders = await OrderService.getTotalOrders();
    res.json({ totalOrders });
  } catch (error) {
    res.status(500).json({ message: 'Error fetching total orders', error });
  }
};
exports.getOrderStatusCounts = async (req, res) => {
  try {
    const statusCounts = await OrderService.getOrderStatusCounts();
    res.json(statusCounts);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching order status counts', error });
  }
};