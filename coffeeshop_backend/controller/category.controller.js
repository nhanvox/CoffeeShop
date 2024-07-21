const Category = require('../models/category.model.js');
const CategoryService = require('../services/category.service.js');

exports.createCategory = async (req, res, next) => {
    try {
        const name = req.body.name;
        if (!name) {
            return res.status(400).json({ success: false, message: "Name is required" });
        }
        const category = await CategoryService.addCategory(name);
        res.status(201).json({ success: true, category });
    } catch (err) {
        console.error("Error in createCategory controller:", err);
        next(err);
    }
};


exports.getCategory = async (req, res, next) => {
    try {
        const category = await CategoryService.getCategoryById(req.params.id);
        if (!category) {
            return res.status(404).json({ success: false, message: 'Category not found' });
        }
        res.json({ success: true, category: category });
    } catch (err) {
        next(err);
    }
};

exports.updateCategory = async (req, res, next) => {
    try {
        const updatedCategory = await CategoryService.updateCategory(req.params.id, req.body);
        res.json({ success: true, updatedCategory });
    } catch (err) {
        next(err);
    }
};

exports.deleteCategory = async (req, res, next) => {
    try {
        await CategoryService.deleteCategory(req.params.id);
        res.json({ success: true, message: 'Category deleted successfully' });
    } catch (err) {
        next(err);
    }
};

exports.getAllCategories = async (req, res, next) => {
    try {
        const categories = await CategoryService.getAllCategories();
        res.json({ success: true, categories });
    } catch (err) {
        next(err);
    }
};
