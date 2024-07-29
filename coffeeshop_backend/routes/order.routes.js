const router = require("express").Router();
const OrderController = require("../controller/order.controller.js");

router.post("/order", OrderController.addToOrder);
router.get("/order/:id", OrderController.getOrderById);
router.get("/ordersbyuser/:id", OrderController.getOrdersByUser);
router.get("/orders", OrderController.getAllOrders);
router.get("/status/:status", OrderController.getOrdersByStatus);
router.put("/order/:id/status", OrderController.updateStatus);
router.get("/totalrevenue", OrderController.getTotalRevenue);
router.get("/totalorders", OrderController.getTotalOrders);
router.get("/orderstatuscounts", OrderController.getOrderStatusCounts);

module.exports = router;
