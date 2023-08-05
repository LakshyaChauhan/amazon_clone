const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

const authRouter = express.Router();

authRouter.post("/api/signup", async(req, res) => {

    try {
        const { name, email, password } = req.body;
        const exsistingUser = await User.findOne({ email });
        if (exsistingUser) {
            return res.status(400).json({ msg: "User with same email already exsists!" });
        }

        const hashedPassword = await bcryptjs.hash(password, 8);
        console.log(hashedPassword);

        let user = new User({
            email,
            password: hashedPassword,
            name,
        });

        user = await user.save();
        res.json(user);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});

authRouter.post("/api/signin", async(req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: 'Account with this email id does not exsist!' });
        }
        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: 'Incorrect Password! Try again.' });
        }

        const token = jwt.sign({ id: user._id }, "passwordKey");
        res.json({ token, ...user._doc });
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

module.exports = authRouter;