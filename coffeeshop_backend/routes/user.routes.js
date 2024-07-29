const router = require("express").Router();
const UserController = require("../controller/user.controller.js");

router.post("/register", UserController.register);
router.post("/login", UserController.login);
router.get("/getallusers", UserController.getAllUsers);
router.get("/getusernamebyid/:userId", UserController.getUserNameById);
router.get("/getuserinfobyid/:userId", UserController.getUserInfoById);
router.put("/updateuser/:userId", UserController.updateUserById);
router.put("/changepass/:userId", UserController.changePass);
router.delete("/deleteuser/:userId", UserController.deleteUser);
router.get("/totalusers", UserController.getTotalUsers);

module.exports = router;
