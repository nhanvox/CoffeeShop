const Product = require('../models/product.model.js');
const ProductService = require('../services/product.service.js');

exports.createProduct = async (req, res, next) => {
    try {
        const product = await ProductService.addProduct(req.body);
        res.json({ success: true, product: product });
    } catch (err) {
        next(err);
    }
};

exports.getProduct = async (req, res, next) => {
    try {
        const product = await ProductService.getProductById(req.params.id);
        if (!product) {
            throw new Error('Product not found');
        }
        res.json({ success: true, product: product });
    } catch (err) {
        next(err);
    }
};

exports.updateProduct = async (req, res, next) => {
    try {
        const updatedProduct = await ProductService.updateProduct(req.params.id, req.body);
        res.json({ success: true, updatedProduct });
    } catch (err) {
        next(err);
    }
};

exports.deleteProduct = async (req, res, next) => {
    try {
        await ProductService.deleteProduct(req.params.id);
        res.json({ success: true, message: 'Product deleted successfully' });
    } catch (err) {
        next(err);
    }
};

exports.getAllProducts = async (req, res, next) => {
    try {
        const products = await ProductService.getAllProducts();
        res.json({ success: true, products: products });
    } catch (err) {
        next(err);
    }
};

exports.getProductsByCategory = async (req, res, next) => {
    try {
        const products = await ProductService.getProductsByCategory(req.params.id);
        res.json({ success: true, products });
    } catch (err) {
        next(err);
    }
};

exports.getBestSellers = async (req, res, next) => {
    try {
        const products = await ProductService.getBestSellers();
        res.json({ success: true, products });
    } catch (err) {
        next(err);
    }
};

exports.getNewProducts = async (req, res, next) => {
    try {
        const products = await ProductService.getNewProducts();
        res.json({ success: true, products });
    } catch (err) {
        next(err);
    }
};
exports.getTotalProducts = async (req, res) => {
    try {
      const totalProducts = await ProductService.getTotalProducts();
      res.json({ totalProducts });
    } catch (error) {
      res.status(500).json({ message: 'Error fetching total products', error });
    }
  };
