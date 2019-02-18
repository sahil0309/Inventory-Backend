const express = require('express');
const router = express.Router();

console.log('Controllers Executing ');
// Require the controllers WHICH WE DID NOT CREATE YET!!
const product_controller = require('../Controllers/product.controller');
const category_controller = require('../Controllers/category.controller');
const stock_controller = require('../Controllers/stock.controller');

// a simple test url to check that all of our files are communicating correctly.
router.get('/product', product_controller.GetProduct);
router.get('/product/:id', product_controller.GetProductById);
router.post('/product', product_controller.AddProduct);
router.put('/product', product_controller.EditProduct);
router.delete('/product', product_controller.DeleteProduct);


//Category Routes
router.get('/category', category_controller.GetCategory);
router.get('/category/:id', category_controller.GetCategoryById);
router.post('/category', category_controller.AddCategory);
router.put('/category', category_controller.EditCategory);
router.delete('/category', category_controller.DeleteCategory);

//Stock Routes 
router.get('/stock', stock_controller.GetStock);
router.get('/stock/:id', stock_controller.GetStockById);
router.post('/stock', stock_controller.AddStock);
router.put('/stock', stock_controller.EditStock);
router.delete('/stock', stock_controller.DeleteStock);

//Stock Report Route
router.get('/stockReport', stock_controller.GetStockReport);

module.exports = router;