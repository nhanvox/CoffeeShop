const Cart = require("../models/cart.model.js");

class CartService {
  static async addToCart(data) {
    const cart = new Cart(data);
    return await cart.save();
  }

  static async getCartById(id) {
    return await Cart.findById(id);
  }

  static async updateCart(id, updateData) {
    return await Cart.findByIdAndUpdate(id, updateData, { new: true });
  }

  static async deleteCart(id) {
    return await Cart.findByIdAndDelete(id);
  }

  static async getCartsByUser(userId) {
    return await Cart.find({ userid: userId }).populate("productid");
  }

  static async getAllCarts() {
    return await Cart.find({});
  }
}

module.exports = CartService;
