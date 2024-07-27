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
