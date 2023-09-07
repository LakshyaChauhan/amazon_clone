const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const Product = require('../models/products');


// For adding Prodcuts 
adminRouter.post('/admin/add-product',admin,async (req,res) => {
    try {
        const {name, description, images, quantity, price , category} = req.body; 

        let product = Product(
            name,
            description,
            images,
            quantity,
            price,
            category,
        );
        
        product = await product.save();
        res.json(product);

    } catch (error) {
        res.status(500).json({error: error.message});
    }
});

module.exports = adminRouter;