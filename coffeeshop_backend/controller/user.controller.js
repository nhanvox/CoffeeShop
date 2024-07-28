const UserServices = require("../services/user.service.js");

exports.register = async (req, res, next) => {
  try {
    const { email, password } = req.body;
    const duplicate = await UserServices.getUserByEmail(email);
    if (duplicate) {
      return res.status(400).json({ message: `Username ${email} is already registered` });
    }
    if (!email || !password) {
      return res.status(400).json({ message: "Email and password are required" });
    }
    if (password.length < 6) {
      return res.status(400).json({ message: "Password must be at least 6 characters long" });
    }
    const response = await UserServices.registerUser(email, password);
    res.json({ status: true, success: "User registered successfully" });
  } catch (err) {
    console.log("---> err -->", err);
    next(err);
  }
};

exports.login = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      throw new Error("Parameter are not correct");
    }
    let user = await UserServices.checkUser(email);
    if (!user) {
      throw new Error("User does not exist");
    }

    const isPasswordCorrect = await user.comparePassword(password);

    if (isPasswordCorrect === false) {
      throw new Error(`Username or Password does not match`);
    }

    // Creating Token

    let tokenData;
    tokenData = { _id: user._id, email: user.email };

    const token = await UserServices.generateAccessToken(
      tokenData,
      "secret",
      "1h"
    );

    res.status(200).json({ status: true, success: "sendData", token: token });
  } catch (error) {
    console.log(error, "err---->");
    next(error);
  }
};
exports.getUserNameById = async (req, res, next) => {
  try {
    const { userId } = req.params;
    const userName = await UserServices.getUserNameById(userId);
    if (!userName) {
      throw new Error("User not found");
    }
    res.status(200).json({ status: true, userName });
  } catch (err) {
    next(err);
  }
};

exports.getUserInfoById = async (req, res, next) => {
  try {
    const { userId } = req.params;
    const userInfo = await UserServices.getUserInfoById(userId);
    if (!userInfo) {
      throw new Error("User not found");
    }
    res.status(200).json({ status: true, userInfo });
  } catch (err) {
    next(err);
  }
};

exports.updateUserById = async (req, res, next) => {
  try {
    const { userId } = req.params;
    const updateData = req.body;
    const updatedUser = await UserServices.updateUserById(userId, updateData);
    if (!updatedUser) {
      throw new Error("User not found");
    }
    res.status(200).json({ status: true, updatedUser });
  } catch (err) {
    next(err);
  }
};

exports.changePass = async (req, res, next) => {
  try {
    const { userId } = req.params;
    const updateData = req.body;
    const updatedUser = await UserServices.changePass(userId, updateData);
    if (!updatedUser) {
      throw new Error("User not found");
    }
    res.status(200).json({ status: true, updatedUser });
  } catch (err) {
    next(err);
  }
};
exports.getAllUsers = async (req, res, next) => {
  try {
    const users = await UserServices.getAllUsers();
    res.status(200).json(users);
  } catch (err) {
    next(err);
  }
};

exports.deleteUser = async (req, res, next) => {
  try {
    const { userId } = req.params;
    const deletedUser = await UserServices.deleteUser(userId);
    if (!deletedUser) {
      throw new Error("User not found");
    }
    res.status(200).json({ status: true, message: "User deleted successfully" });
  } catch (err) {
    next(err);
  }
};
