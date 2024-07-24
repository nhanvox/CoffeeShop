const ProfileService = require("../services/profile.service.js");

exports.addProfile = async (req, res, next) => {
  try {
    const profile = await ProfileService.addProfile(req.body);
    res.json({ success: true, profile: profile });
  } catch (err) {
    next(err);
  }
};

exports.getProfileById = async (req, res, next) => {
  try {
    const profile = await ProfileService.getProfileById(req.params.id);
    if (!profile) {
      throw new Error("Product not found");
    }
    res.json({ success: true, profile: profile });
  } catch (err) {
    next(err);
  }
};

exports.updateProfile = async (req, res, next) => {
  try {
    const updateProfile = await ProfileService.updateProfile(
      req.params.id,
      req.body
    );
    res.json({ success: true, updateProfile });
  } catch (err) {
    next(err);
  }
};

exports.deleteProfile = async (req, res, next) => {
  try {
    await ProfileService.deleteProfile(req.params.id);
    res.json({ success: true, message: "Profile deleted successfully" });
  } catch (err) {
    next(err);
  }
};

exports.getProfileByUser = async (req, res, next) => {
  try {
    const { id: userId } = req.params;
    const profile = await ProfileService.getProfileByUser(userId);
    if (!profile) {
      return res
        .status(404)
        .json({ success: false, message: "No profile found for this user" });
    }
    res.status(200).json({ success: true, profile });
  } catch (err) {
    next(err);
  }
};

exports.getAllProfiles = async (req, res, next) => {
  try {
    const profiles = await ProfileService.getAllProfiles();
    res.json({ success: true, profiles: profiles });
  } catch (err) {
    next(err);
  }
};
