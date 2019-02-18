const db = require('../DB');
console.log('User Controller');
module.exports.GetProduct = function (req, res) {
  try {
    var sql = "call GetProducts()";
    db.query(sql, function (err, result) {
      if (err) {
        res.status(400).send('Failure Hogya Bawa');

      }
      else {
        res.status(200).json(result[0]);
      }
    })
  }
  catch (e) {
    res.status(400).send('Failure');
  }
}

module.exports.GetProductById = (req, res) => {
  try {

    let productID = req.params.id;
    console.log('Params', req.params);
    var sql = `call GetProductById(${productID})`;
    db.query(sql, (err, result) => {
      if (err) {
        console.log(err);
        res.status(400).send('Failure Hogya Bawa');
      }
      else {
        console.log(result);
        res.status(200).json(result[0][0]);
      }
    })
  }
  catch (e) {
    res.send(400).send('Error');
  }
}


module.exports.AddProduct = (req, res) => {
  try {
    console.log(req.body);
    let productName = req.body.productName;
    let categoryId = req.body.categoryId;
    let createdBy = 1;
    var sql = `call AddProduct('${productName}',${categoryId},${createdBy})`;
    db.query(sql, (err, result) => {
      if (err) {
        console.log(err);
        res.status(400).send('Failure Hogya Bawa');
      }
      else {
        console.log(result);
        res.status(200).json(result[0][0]);
      }
    })
  }
  catch (e) {
    res.send(400).send('Error');
  }
}

module.exports.EditProduct = (req, res) => {
  try {
    console.log(req.body);
    let productId = req.body.productId;
    let productName = req.body.productName;
    let categoryId = req.body.categoryId;
    let reason = null;
    let updatedBy = 1;
    var sql = `call EditProduct(${productId},'${productName}',${categoryId},${reason},${updatedBy})`;
    db.query(sql, (err, result) => {
      if (err) {
        console.log(err);
        res.status(400).send('Failure Hogya Bawa');
      }
      else {
        console.log(result);
        res.status(200).json(result[0][0]);
      }
    })
  }
  catch (e) {
    res.send(400).send('Error');
  }
}

module.exports.DeleteProduct = (req, res) => {
  try {
    console.log(req.body);
    let productId = req.body.productId;
    let reason = null;
    let updatedBy = 1;
    var sql = `call DeleteProduct(${productId},${reason},${updatedBy})`;
    db.query(sql, (err, result) => {
      if (err) {
        console.log(err);
        res.status(400).send('Failure Hogya Bawa');
      }
      else {
        console.log(result);
        res.status(200).json(result[0][0]);
      }
    })
  }
  catch (e) {
    res.send(400).send('Error');
  }
}
