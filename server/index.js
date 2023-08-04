// Imports from package
const express = require("express");
const mongoose = require("mongoose");

//init
const PORT = 3000;
const app = express();
const DB = "";

// Imports from other files
const authRouter = require("./routes/auth"); 

//middleware
app.use(express.json());
app.use(authRouter);

//connections
mongoose.connect(DB).then(() => {
    console.log("Connection Established");
})
.catch(e => {
    console.log(e);
})

//Creating an API
// GET ,PUT , POST , DELETE , UPDATE ->CRUD
app.listen(PORT,"0.0.0.0",()=>{
    console.log(`connected to ${PORT}`)
})  
