const router = require("express").Router();
const ProductController = require('../controller/product.controller.js');

router.post("/products", ProductController.createProduct);
router.get("/products/:id", ProductController.getProduct);
router.put("/products/:id", ProductController.updateProduct);
router.delete("/products/:id", ProductController.deleteProduct);
router.get("/products", ProductController.getAllProducts);
router.get("/productsbycategory/:id", ProductController.getProductsByCategory);
router.get("/productsbestseller", ProductController.getBestSellers);
router.get("/productsnew", ProductController.getNewProducts);
router.get("/totalproducts", ProductController.getTotalProducts);

module.exports = router;