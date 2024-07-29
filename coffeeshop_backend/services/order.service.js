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
    return await Order.find({ userid: userId }).populate(
      "itemorders.productid"
    );
  }

  static async getAllOrders() {
    return await Order.find({});
  }

  static async getOrdersByStatus(status) {
    return await Order.find({ status });
  }

  static async updateStatus(id, status) {
    const order = await Order.findById(id);
    if (!order) {
      throw new Error("Order not found");
    }
    order.status = status;
    return await order.save();
  }
  static async getTotalRevenue() {
    const totalRevenue = await Order.aggregate([
      { $match: { status: "Hoàn Thành" } },
      { $group: { _id: null, total: { $sum: '$totalsum' } } }
    ]);

    return totalRevenue[0] ? totalRevenue[0].total : 0;
  }
  static async getTotalOrders() {
    return await Order.countDocuments();
  }
  static async getOrderStatusCounts() {
    return await Order.aggregate([
      { $group: { _id: "$status", count: { $sum: 1 } } }
    ]);
  }
}

module.exports = OrderService;
