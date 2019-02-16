const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
//const product_controller = require('./Controllers/product.controller');
const routes = require('./Routes/routes');

// initialize our express app
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cors());
app.use('/api', routes);


let port = 3000;
app.listen(port, () => {
    console.log('Server is up and running on port numner ' + port);
});

