const db = require('../DB');
console.log('Purchase Controller');
module.exports.GetPurchase = function (req, res) {
    try {
        var sql = "call GetPurchase()";
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

module.exports.GetPurchaseById = (req, res) => {
    try {

        let PurchaseID = req.params.id;
        console.log('Params', req.params);
        var sql = `call GetPurchaseById(${PurchaseID})`;
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
        res.status(400).send('Error');
    }
}


module.exports.AddPurchase = async(req, res) => {
    try {
        console.log(req.body);
        let purchaseId;
        let dealerId = req.body.dealerId;
        let vehicleNumber = req.body.vehicleNumber;
        let labourCharges = req.body.labourCharges;
        let purchaseArray = req.body.purchaseArray;
        let amount = req.body.amount;
        let netGst = req.body.netGst;
        let totalAmount = req.body.totalAmount;
        let amountPaid = req.body.amountPaid;
        let balance = amount - amountPaid;
        let modeofPayment = req.body.modeofPayment;

        var sql = `call AddPurchase(${dealerId},${vehicleNumber},${labourCharges},
            ${amount},${netGst},${totalAmount},${amountPaid},${purchaseId})`;
            await dbQuery(sql);
      /*  db.query(sql, (err, result) => {
            if (err) {
                console.log(err);
                res.status(400).send('Failure Hogya Bawa');
            }
            else {
                console.log(result);
            
            }
        })*/


        /*[
          {
              productId;
              quantity;
              rate;
              cgst;
              sgst;
              igst;
          }
        ]
        */
       
        purchaseArray.map(async (product) => {
            var sql = `call AddPurchaseProduct(${purchaseId},${product.productId},${product.quantity},
                ${product.rate},${product.cgst},${product.sgst},${product.igst}})`;
                await dbQuery(sql);
               /* db.query(sql, (err, result) => {
                    if (err) {
                        console.log(err);
                        res.status(400).send('Failure Hogya Bawa');
                    }
                    else {
                        console.log(result);
                    
                    }
                })*/
        })
        
        if(amountPaid>0){
        var transactionSql = `call ManageTransaction(${purchaseId},${dealerId},${amountPaid},${modeofPayment},'Purchase')`;
        await dbQuery(transactionSql);
       /*db.query(transactionSql, (err, result) => {
            if (err) {
                console.log(err);
                res.status(400).send('Failure Hogya Bawa');
            }
            else {
                console.log(result);
            
            }
        })*/
       }
       if(balance>0){
        var outstandingSQl = `call ManageOutstandings(${dealerId},${balance},'debit')`;
        await dbQuery(outstandingSQl)
        /* db.query(outstandingSQl, (err, result) => {
            if (err) {
                console.log(err);
                res.status(400).send('Failure Hogya Bawa');
            }
            else {
                console.log(result);
            
            }
        })*/
       }
    }
    catch (e) {
        res.status(400).send('Error');
    }
}

module.exports.EditPurchase = (req, res) => {
    try {
        console.log(req.body.purchaseTimeStamp);
        let date = Date.parse(req.body.purchaseTimeStamp);
        console.log('date', date);
        let purchaseId = req.body.purchaseId;
        let productId = req.body.productId;
        let costPrice = req.body.costPrice;
        let quantityPurchased = req.body.quantityPurchased;
        let purchaseTimeStamp = req.body.purchaseTimeStamp;
        let dealerId = req.body.dealerId;
        let updatedBy = 1;
        var sql = `call EditPurchase(${purchaseId},${productId},${costPrice},${quantityPurchased},
           ' ${purchaseTimeStamp}'
            ,${dealerId},${updatedBy})`;
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
        res.status(400).send('Error');
    }
}

module.exports.DeletePurchase = (req, res) => {
    try {
        console.log(req.body);
        let PurchaseId = req.body.PurchaseId;
        let reason = null;
        let updatedBy = 1;
        var sql = `call DeletePurchase(${PurchaseId},${reason},${updatedBy})`;
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
        res.status(400).send('Error');
    }
}

function dbQuery(sqlQuery){
    return new Promise((resolve,reject)=>{
        db.query(sqlQuery,(err,result)=>{
            if(err){
                console.log(err);
                reject(err);
            }
            else{
                console.log(result);
                resolve(result);
            }
        })

    })
}