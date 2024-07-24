const db = require("../config/db.js");
const mongoose = require("mongoose");
const { Schema } = mongoose;

const profileSchema = new Schema(
  {
    userid: { type: mongoose.Schema.Types.ObjectId, ref: "user" },
    name: { type: String },
    phoneNumber: { type: String },
    address: { type: String },
    image: { type: String },
  },
  { timestamps: true }
);

const Profile = db.model("Profile", profileSchema);
module.exports = Profile;
