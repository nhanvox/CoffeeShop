// const UserModel = require("./user.model.js");
const db = require('../config/db.js');
const mongoose = require('mongoose');
const { Schema } = mongoose;

const favProductSchema = new Schema({
    productid: { type: mongoose.Schema.Types.ObjectId, ref: "Product" },
    userId: { type: mongoose.Schema.Types.ObjectId, ref: "UserModel" },
}, { timestamps: true });

const FavProduct = db.model('FavProduct', favProductSchema);
module.exports = FavProduct;
