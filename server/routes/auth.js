const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");

const authRouter = express.Router();

authRouter.post("/api/signup", async (req ,res)=>{
    
    try{ 
        const {name,email,password} = req.body;
        const exsistingUser = await User.findOne({email});
        if(exsistingUser){
            return res.status(400).json({msg:"User with same email already exsists!"});
        }

    const hashedPassword = await bcryptjs.hash(password,8);

    let user = new User({
        email,
        password : hashedPassword,
        name,
    });

    user = await user.save();
    console.log('running auth.js done');
    res.json(user);
}catch(e){
    console.log('running auth.js error');
    res.status(500).json({error : e.message});
}

})

module.exports = authRouter;