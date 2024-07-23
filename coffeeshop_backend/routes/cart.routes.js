const router = require("express").Router();
const CartController = require("../controller/cart.controller.js");

router.post("/carts", CartController.addToCart);
router.get("/cart/:id", CartController.getCart);
router.put("/cart/:id", CartController.updateCart);
router.delete("/cart/:id", CartController.deleteCart);
router.get("/cartsbyuser/:id", CartController.getCartsByUser);
router.get("/carts", CartController.getAllCarts);

module.exports = router;
