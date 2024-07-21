const router = require("express").Router();
const CategoryController = require('../controller/category.controller.js');

router.post("/category", CategoryController.createCategory);
router.get("/category/:id", CategoryController.getCategory);
router.put("/category/:id", CategoryController.updateCategory);
router.delete("/category/:id", CategoryController.deleteCategory);
router.get("/getallcategory", CategoryController.getAllCategories);

module.exports = router;
