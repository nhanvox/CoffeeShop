const router = require("express").Router();
const OrderController = require('../controller/order.controller.js');

router.post("/order", OrderController.addToOrder);
router.get("/order/:id", OrderController.getOrderById);
router.get("/ordersbyuser/:id", OrderController.getOrdersByUser);
router.get("/orders", OrderController.getAllOrders);

module.exports = router;