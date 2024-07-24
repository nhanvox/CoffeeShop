const FavProduct = require('../models/favproduct.model.js');

class FavProductService {
    static async addFavProduct(data) {
        const favproduct = new FavProduct(data);
        return await favproduct.save();
    }

    static async getFavProductByIdUser(userId) {
        return await FavProduct.find({ userId: userId }).populate("productid");
    }

    static async deleteFavProduct(id) {
        return await FavProduct.findByIdAndDelete(id);
    }

    static async getAllProducts() {
        return await FavProduct.find({});
    }
}

module.exports = FavProductService;
