const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const Product = require('../models/products');


// For adding Prodcuts 
adminRouter.post('/admin/add-product',admin,async (req,res) => {
    try {
        const {name, description, images, quantity, price , category} = req.body; 

        let product = new Product({
            name,
            description,
            price,
            quantity,
            images,
            category,
        });
        
        product = await product.save();
        res.json(product);

    } catch (error) {
        
      console.log('here is the problem route');
        res.status(500).json({error: error.message});
    }
});


/// get request
adminRouter.get('/admin/get-products',admin,async (req,res) => {
    try {
        const products  = await Product.find({});
        res.json(products);
    } catch (e) {
        res.status(500).json({error: e.message});
    }
});

// delete products
adminRouter.post("/admin/delete-products",admin,async (req,res)=>{
    try {
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);
        
        res.json(product);
    } catch (e) {
        res.status(500).json({error: e.message});
    }
});

module.exports = adminRouter;