const Product = require('../models/product.model.js');

class ProductService {
    static async addProduct(data) {
        const product = new Product(data);
        return await product.save();
    }
    static async getProductById(id) {
        return await Product.findById(id);
    }

    static async updateProduct(id, updateData) {
        return await Product.findByIdAndUpdate(id, updateData, { new: true });
    }

    static async deleteProduct(id) {
        return await Product.findByIdAndDelete(id);
    }

    static async getAllProducts() {
        return await Product.find({});
    }

    static async getProductsByCategory(categoryId) {
        return await Product.find({ categoryid: categoryId });
    }

    static async getBestSellers() {
        return await Product.find({ isBestSeller: true });
    }

    static async getNewProducts() {
        return await Product.find({ isNewProduct: true });
    }
}

module.exports = ProductService;
