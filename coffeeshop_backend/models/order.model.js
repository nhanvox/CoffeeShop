const db = require("../config/db.js");
const mongoose = require("mongoose");
const { Schema } = mongoose;

const orderSchema = new Schema(
    {
        userid: { type: mongoose.Schema.Types.ObjectId, ref: "user" },
        itemorders: [
            {
                cartid: { type: mongoose.Schema.Types.ObjectId, ref: "Cart" },
                productid: { type: mongoose.Schema.Types.ObjectId, ref: "Product" }
            }
        ],
        quantitysum: { type: Number, required: true },
        totalsum: { type: Number, required: true },
        address: { type: String, required: true },
        status: { type: String, default: "Chờ", enum: ["Chờ", "Hoàn Thành", "Hủy"] },
        paymentMethod: { type: String, required: true },
        orderDate: { type: Date, default: Date.now }
    },
    { timestamps: true }
);

const Order = db.model("Order", orderSchema);
module.exports = Order;