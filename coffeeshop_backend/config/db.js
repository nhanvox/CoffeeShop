// const mongoose = require('mongoose');

// const connection = mongoose.createConnection('mongodb+srv://nhanvo654:35s00TQi1hYmSDIc@tododb.uixh8a2.mongodb.net/').on('open',()=>{console.log("MongoDB Connected");}).on('error',()=>{
//     console.log("MongoDB Connection error");
// });

// module.exports = connection;

const mongoose = require('mongoose');


const connection = mongoose
    .createConnection(
        "mongodb+srv://dangkychi:admin12345@coffeeshop.ngkw3zf.mongodb.net/coffeeshop_db"
    )
    .on("open", () => {
        console.log("MongoDB Connected");
    })
    .on("error", () => {
        console.log("MongoDB Connection error");
    });

module.exports = connection;
