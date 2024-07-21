const Category = require('../models/category.model.js');

class CategoryService {
    static async addCategory(name) {
        try {
            console.log("-----Category-----", name);
            const category = new Category({ name });
            return await category.save();
        } catch (err) {
            console.error("Error adding category:", err.message);
            throw err;
        }
    }

    static async getCategoryById(id) {
        try {
            return await Category.findById(id);
        } catch (err) {
            console.error("Error finding category:", err.message);
            throw err;
        }
    }

    static async updateCategory(id, updateData) {
        try {
            return await Category.findByIdAndUpdate(id, updateData, { new: true });
        } catch (err) {
            console.error("Error updating category:", err.message);
            throw err;
        }
    }

    static async deleteCategory(id) {
        try {
            return await Category.findByIdAndDelete(id);
        } catch (err) {
            console.error("Error deleting category:", err.message);
            throw err;
        }
    }

    static async getAllCategories() {
        try {
            return await Category.find({});
        } catch (err) {
            console.error("Error retrieving categories:", err.message);
            throw err;
        }
    }
}

module.exports = CategoryService;
