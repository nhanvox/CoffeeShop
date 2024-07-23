const db = require("../config/db.js");
const mongoose = require("mongoose");
const { Schema } = mongoose;

const cartSchema = new Schema(
  {
    productid: { type: mongoose.Schema.Types.ObjectId, ref: "Product" },
    userid: { type: mongoose.Schema.Types.ObjectId, ref: "user" },
    size: { type: String },
    total: { type: Number },
    quantity: { type: Number, required: true },
    sugar: { type: String },
    ice: { type: String },
  },
  { timestamps: true }
);

const Cart = db.model("Cart", cartSchema);
module.exports = Cart;
