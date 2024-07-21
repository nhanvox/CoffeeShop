const router = require("express").Router();
const UserController = require('../controller/user.controller.js');

router.post("/register", UserController.register);

router.post("/login", UserController.login);

router.get('/getusernamebyid/:userId', UserController.getUserNameById);
router.get('/getuserinfobyid/:userId', UserController.getUserInfoById);
router.put('/updateuser/:userId', UserController.updateUserById);

module.exports = router;