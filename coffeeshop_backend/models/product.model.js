const db = require('../config/db.js');
const mongoose = require('mongoose');
const { Schema } = mongoose;

const productSchema = new Schema({
    name: { type: String, required: true },
    price: { type: Number, required: true },
    description: { type: String },
    image: { type: String },
    categoryid: { type: mongoose.Schema.Types.ObjectId, ref: 'Category' },
    isBestSeller: { type: Boolean, default: false },
    isNewProduct: { type: Boolean, default: false }
}, { timestamps: true });

const Product = db.model('Product', productSchema);
module.exports = Product;
