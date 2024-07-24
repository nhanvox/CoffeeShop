const router = require("express").Router();
const ProfileController = require("../controller/profile.controller.js");

router.post("/addprofile", ProfileController.addProfile);
router.get("/getprofile/:id", ProfileController.getProfileById);
router.put("/updateprofile/:id", ProfileController.updateProfile);
router.delete("/deleteprofile/:id", ProfileController.deleteProfile);
router.get("/profilebyuser/:id", ProfileController.getProfileByUser);
router.get("/profiles", ProfileController.getAllProfiles);

module.exports = router;
