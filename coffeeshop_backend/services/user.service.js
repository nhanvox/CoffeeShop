const UserModel = require("../models/user.model.js");
const jwt = require("jsonwebtoken");

class UserServices {

    static async registerUser(email, password) {
        try {
            console.log("-----Email --- Password-----", email, password);

            const createUser = new UserModel({ email, password });
            return await createUser.save();
        } catch (err) {
            throw err;
        }
    }

    static async getUserByEmail(email) {
        try {
            return await UserModel.findOne({ email });
        } catch (err) {
            console.log(err);
        }
    }

    static async checkUser(email) {
        try {
            return await UserModel.findOne({ email });
        } catch (error) {
            throw error;
        }
    }

    static async generateAccessToken(tokenData, JWTSecret_Key, JWT_EXPIRE) {
        return jwt.sign(tokenData, JWTSecret_Key, { expiresIn: JWT_EXPIRE });
    }

    static async getUserNameById(userId) {
        try {
            const user = await UserModel.findById(userId).select('email');
            return user ? user.email : null;
        } catch (err) {
            throw err;
        }
    }

    static async getUserInfoById(userId) {
        try {
            return await UserModel.findById(userId);
        } catch (err) {
            throw err;
        }
    }

    static async updateUserById(userId, updateData) {
        try {
            return await UserModel.findByIdAndUpdate(userId, updateData, { new: true });
        } catch (err) {
            throw err;
        }
    }
}

module.exports = UserServices;