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
        console.log('Add Purchase',req.body);
        var purchaseId=12;
        let dealerId = req.body.dealerId;
        let vehicleNumber = req.body.vehicleNumber;
        let labourCharges = req.body.labourCharges;
        let purchaseArray = req.body.products;
        let amount = req.body.totalAmount;
        let netGst = 100;
        let totalAmount = amount + netGst;
        let amountPaid = 500;
        let balance = totalAmount - amountPaid;
        let modeofPayment = 'Cash';

        var sql = `call AddPurchase(${dealerId},'${vehicleNumber}',
        ${labourCharges},${amount},${netGst},${totalAmount},${amountPaid})`;
           const result= await dbQuery(sql);
           console.log('Purchase Id',result[0][0].purchaseID);
           purchaseId = result[0][0].purchaseID;

        purchaseArray.map(async (product) => {
            let sql1 = `call AddPurchaseProduct(${purchaseId},${product.productId},${product.quantityPurchased},
                ${product.costPrice},${100},${100},${100})`;
                await dbQuery(sql1);
            let sql2 =`call ManageStock(${product.productId},${product.quantityPurchased},'Normal','Add')`;
                await dbQuery(sql2);
        })
        
        if(amountPaid>0){
        var transactionSql = `call ManageTransaction(${purchaseId},${dealerId},${amountPaid},'${modeofPayment}','Purchase')`;
        await dbQuery(transactionSql);
       }
       if(balance>0){
         var outstandingSQl = `call ManageOutstandings(${dealerId},${balance},'Owe')`;
         await dbQuery(outstandingSQl)
       }

       res.send({
           status:'Success',
           message:'Purchase Successful'
       })
    }
    catch (e) {
        console.log('Error',e);
        res.status(400).send('Error');
    }
}

module.exports.EditPurchase = async(req, res) => {
    try {
        console.log('Edit Purchase',req.body);
        var purchaseId=req.body.purchaseId;
        let dealerId = req.body.dealerId;
        let vehicleNumber = req.body.vehicleNumber;
        let labourCharges = req.body.labourCharges;
        let purchaseArray = req.body.products;
        let amount = req.body.totalAmount;
        let netGst = 1000;
        let totalAmount = amount + netGst;
        let amountPaid = 100;
        let balance = totalAmount - amountPaid;
        let modeofPayment = 'Cash';

        var sql = `call EditPurchase(${purchaseId},${dealerId},'${vehicleNumber}',
        ${labourCharges},${amount},${netGst},${totalAmount},${amountPaid})`;
             await dbQuery(sql);

        var sql2=`call GetProductsPurchase(${purchaseId})`;
        let result = await dbQuery(sql2)[0][0];
        console.log(result);
        let prevProductsArray = result[0][0];
        console.log(prevProductsArray);
        prevProductsArray.map(async (product)=>{
            let sql = `call ManageStock(${product.productId},${product.quantityPurchased},'Normal','Subtract')`;
            await dbQuery(sql);
        })
        
        var sql3 = `call DeletePurchaseProducts(${purchaseId})`;
        await dbQuery(sql3);

        purchaseArray.map(async (product) => {
            let sql1 = `call AddPurchaseProduct(${purchaseId},${product.productId},${product.quantityPurchased},
                ${product.costPrice},${100},${100},${100})`;
                await dbQuery(sql1);
           
        })
        
        if(amountPaid>0){
        var transactionSql = `call ManageTransaction(${purchaseId},${dealerId},${amountPaid},'${modeofPayment}','Purchase')`;
        await dbQuery(transactionSql);
       }
       if(balance>0){
         var outstandingSQl = `call ManageOutstandings(${dealerId},${balance},'Owe')`;
         await dbQuery(outstandingSQl)
       }

       res.send({
           status:'Success',
           message:'Purchase Updation Successful'
       })
    }
    catch (e) {
        console.log('Error',e);
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
                //console.log('Purchase Id',purchaseId);
                reject(err);
            }
            else{
                console.log(result);
               // console.log('Purchase Id :- ',purchaseId);
                resolve(result);
            }
        })

    })
}