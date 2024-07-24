const FavProductService = require('../services/favproduct.service.js');

exports.addFavProduct = async (req, res, next) => {
    try {
        const product = await FavProductService.addFavProduct(req.body);
        res.json({ success: true, product: product });
    } catch (err) {
        next(err);
    }
};

exports.getFavProductsByUser = async (req, res, next) => {
    try {
        const { id: userId } = req.params;
        const favproduct = await FavProductService.getFavProductByIdUser(userId);
        if (!favproduct || favproduct.length === 0) {
            return res
                .status(404)
                .json({ success: false, message: "No favou product found for this userID:" + userId });
        }
        res.status(200).json({ success: true, favproduct });
    } catch (err) {
        next(err);
    }
};

exports.deleteFavProduct = async (req, res, next) => {
    try {
        const favProductId = req.params.id;
        await FavProductService.deleteFavProduct(favProductId);
        res.json({ success: true, message: 'Product Favourite deleted successfully' });
    } catch (err) {
        next(err);
    }
};

exports.getAllFavProducts = async (req, res, next) => {
    try {
        const productfav = await FavProductService.getAllProducts();
        res.json({ success: true, productfav: productfav });
    } catch (err) {
        next(err);
    }
};