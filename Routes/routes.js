const express = require('express');
const router = express.Router();

console.log('Controllers Executing ');
// Require the controllers WHICH WE DID NOT CREATE YET!!
const product_controller = require('../Controllers/product.controller');
const user_controller = require('../Controllers/user.controller');
const category_controller = require('../Controllers/category.controller');

// a simple test url to check that all of our files are communicating correctly.
router.get('/product', product_controller);
router.get('/user', user_controller);

router.get('/category',category_controller.GetCategory);
module.exports = router;