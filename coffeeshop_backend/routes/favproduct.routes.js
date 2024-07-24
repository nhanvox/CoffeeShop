const router = require("express").Router();
const FavProductController = require('../controller/favproduct.controller.js');

router.post("/favproduct", FavProductController.addFavProduct);
router.get("/favproductsbyuser/:id", FavProductController.getFavProductsByUser);
router.delete("/favproduct/:id", FavProductController.deleteFavProduct);
router.get("/favproducts", FavProductController.getAllFavProducts);

module.exports = router;