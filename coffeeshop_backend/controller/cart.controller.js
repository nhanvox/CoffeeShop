const CartService = require("../services/cart.service.js");

exports.addToCart = async (req, res, next) => {
  try {
    const cart = await CartService.addToCart(req.body);
    res.json({ success: true, cart: cart });
  } catch (err) {
    next(err);
  }
};

exports.getCart = async (req, res, next) => {
  try {
    const cart = await CartService.getCartById(req.params.id);
    if (!cart) {
      throw new Error("Product not found");
    }
    res.json({ success: true, cart: cart });
  } catch (err) {
    next(err);
  }
};

exports.updateCart = async (req, res, next) => {
  try {
    const updatedCart = await CartService.updateCart(req.params.id, req.body);
    res.json({ success: true, updatedCart });
  } catch (err) {
    next(err);
  }
};

exports.deleteCart = async (req, res, next) => {
  try {
    await CartService.deleteCart(req.params.id);
    res.json({ success: true, message: "Product deleted successfully" });
  } catch (err) {
    next(err);
  }
};

exports.getCartsByUser = async (req, res, next) => {
  try {
    const { id: userId } = req.params;
    const carts = await CartService.getCartsByUser(userId);
    if (!carts || carts.length === 0) {
      return res
        .status(404)
        .json({ success: false, message: "No carts found for this user" });
    }
    res.status(200).json({ success: true, carts });
  } catch (err) {
    next(err);
  }
};

exports.getAllCarts = async (req, res, next) => {
  try {
    const carts = await CartService.getAllCarts();
    res.json({ success: true, carts: carts });
  } catch (err) {
    next(err);
  }
};
