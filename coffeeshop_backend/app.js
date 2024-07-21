const express = require("express");
const bodyParser = require("body-parser")
const UserRoute = require("./routes/user.routes.js");
const ToDoRoute = require('./routes/todo.routes.js');
const ProductRoute = require("./routes/product.routes.js")
const CategoryRoute = require("./routes/category.routes.js")
const app = express();

app.use(bodyParser.json())

app.use("/", UserRoute);
app.use("/", ToDoRoute);
app.use("/", ProductRoute);
app.use("/", CategoryRoute);

module.exports = app;