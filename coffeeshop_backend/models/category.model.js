const db = require('../config/db.js');
const mongoose = require('mongoose');
const { Schema } = mongoose;

const categorySchema = new Schema({
    name: { type: String, required: true }
}, { timestamps: true });

const Category = db.model('Category', categorySchema);
module.exports = Category;
