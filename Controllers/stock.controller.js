const db = require('../DB');
console.log('Stock Controller');
module.exports.GetStock = function (req, res) {
    try {
        var sql = "call GetStock()";
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

module.exports.GetStockReport = function (req, res) {
    try {
        var sql = "call GetStockReport()";
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

module.exports.GetStockById = (req, res) => {
    try {

        let stockID = req.params.id;
        console.log('Params', req.params);
        var sql = `call GetStockById(${stockID})`;
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


module.exports.AddStock = (req, res) => {
    try {
        console.log(req.body);
        let productId = req.body.productId;
        let costPrice = req.body.costPrice;
        let sellingPrice = req.body.sellingPrice;
        let purchaseDate = req.body.purchaseDate;
        let quantityAvailable = req.body.quantityAvailable;
        let dealerId = req.body.dealerId;
        let createdBy = 1;
        var sql = `call AddStock(${productId},${costPrice},${sellingPrice},'${purchaseDate}',${quantityAvailable}
            ,${dealerId},${createdBy})`;
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

module.exports.EditStock = (req, res) => {
    try {
        console.log(req.body);
        let stockId = req.body.stockId;
        let productId = req.body.productId;
        let costPrice = req.body.costPrice;
        let sellingPrice = req.body.sellingPrice;
        let purchaseDate = req.body.purchaseDate;
        let quantityAvailable = req.body.quantityAvailable;
        let dealerId = req.body.dealerId;
        let reason = null;
        let updatedBy = 1;
        var sql = `call EditStock(${stockId},${productId},${costPrice},${sellingPrice},'${purchaseDate}',${quantityAvailable}
            ,${dealerId},${reason},${updatedBy})`;
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

module.exports.DeleteStock = (req, res) => {
    try {
        console.log(req.body);
        let stockId = req.body.stockId;
        let reason = null;
        let updatedBy = 1;
        var sql = `call DeleteStock(${stockId},${reason},${updatedBy})`;
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