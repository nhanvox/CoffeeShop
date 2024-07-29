const db = require("../config/db.js");
const mongoose = require("mongoose");
const { Schema } = mongoose;

const orderSchema = new Schema(
  {
    userid: { type: mongoose.Schema.Types.ObjectId, ref: "user" },
    itemorders: [
      {
        productid: { type: mongoose.Schema.Types.ObjectId, ref: "Product" },
        size: { type: String, required: true },
        sugar: { type: String, required: true },
        ice: { type: String, required: true },
        quantity: { type: Number, required: true },
      },
    ],
    quantitysum: { type: Number, required: true },
    totalsum: { type: Number, required: true },
    phoneNumber: { type: String, required: true },
    name: { type: String, required: true },
    address: { type: String, required: true },
    deliverycharges: { type: Number, required: true },
    status: {
      type: String,
      default: "Chờ Xác Nhận",
      enum: ["Chờ Xác Nhận", "Đã Xác Nhận", "Hoàn Thành", "Đã Hủy"],
    },
    paymentMethod: { type: String, required: true },
    orderDate: { type: Date, default: Date.now },
  },
  { timestamps: true }
);

const Order = db.model("Order", orderSchema);
module.exports = Order;
