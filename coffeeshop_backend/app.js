const express = require("express");
const bodyParser = require("body-parser")
const UserRoute = require("./routes/user.routes.js");
const ProductRoute = require("./routes/product.routes.js")
const CategoryRoute = require("./routes/category.routes.js")
const CartRoute = require("./routes/cart.routes.js")
const app = express();

app.use(bodyParser.json())

app.use("/", UserRoute);
app.use("/", ProductRoute);
app.use("/", CategoryRoute);
app.use("/", CartRoute);

module.exports = app;