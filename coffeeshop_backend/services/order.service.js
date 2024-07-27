const Order = require("../models/order.model.js");

class OrderService {
    static async addToOrder(data) {
        const order = new Order(data);
        return await order.save();
    }

    static async getOrderById(id) {
        return await Order.findById(id);
    }

    static async getOrdersByUser(userId) {
        return await Order.find({ userid: userId }).populate("itemorders.productid").populate("itemorders.cartid");
    }

    static async getAllOrders() {
        return await Order.find({});
    }
}

module.exports = OrderService;
