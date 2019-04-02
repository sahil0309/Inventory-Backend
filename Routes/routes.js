const express = require('express');
const router = express.Router();

console.log('Controllers Executing ');
// Require the controllers WHICH WE DID NOT CREATE YET!!
const product_controller = require('../Controllers/product.controller');
const category_controller = require('../Controllers/category.controller');
const purchase_controller = require('../Controllers/purchase.controller');
const dealer_controller =  require('../Controllers/dealer.controller');
const customer_controller = require('../Controllers/customer.controller');
const bill_controller = require('../Controllers/bill.controller');

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
router.get('/purchase',purchase_controller.GetPurchase);
router.get('/purchase/:id', purchase_controller.GetPurchaseById);
router.post('/purchase', purchase_controller.AddPurchase);
router.put('/purchase', purchase_controller.EditPurchase);
router.delete('/purchase', purchase_controller.DeletePurchase);

//Stock Report Route
router.get('/stockReport', purchase_controller.GetStockReport);

//Dealer Routes
router.get('/dealer',dealer_controller.GetDealer);
router.get('/dealer/:id',dealer_controller.GetDealerById);
router.post('/dealer',dealer_controller.AddDealer);
router.put('/dealer',dealer_controller.EditDealer);
router.delete('/dealer',dealer_controller.DeleteDealer);

//Customer Routes
router.get('/customer',customer_controller.GetCustomer);
router.get('/customer/:id',customer_controller.GetCustomerById);
router.post('/customer',customer_controller.AddCustomer);
router.put('/customer',customer_controller.EditCustomer);
router.delete('/customer',customer_controller.DeleteCustomer);

// Bill Routes

router.post('/bill',bill_controller.AddBill);

module.exports = router;