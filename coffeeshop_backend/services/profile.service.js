const Profile = require("../models/profile.model.js");

class ProfileService {
  static async addProfile(data) {
    const profile = new Profile(data);
    return await profile.save();
  }

  static async getProfileById(id) {
    return await Profile.findById(id);
  }

  static async updateProfile(id, updateData) {
    return await Profile.findByIdAndUpdate(id, updateData, { new: true });
  }

  static async deleteProfile(id) {
    return await Profile.findByIdAndDelete(id);
  }

  static async getProfileByUser(userId) {
    return await Profile.findOne({ userid: userId });
  }

  static async getAllProfiles() {
    return await Profile.find({});
  }
}

module.exports = ProfileService;
