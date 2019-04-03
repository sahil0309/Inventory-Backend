const db = require('../DB');

module.exports.AddBill = async (req, res) => {
    try {
        console.log('Add Bill', req.body);
        var billId = 12;
        let dealerId = req.body.dealerId;
        let vehicleNumber = req.body.vehicleNumber;
        let labourCharges = req.body.labourCharges;
        let productsArray = req.body.products;
        let amount = req.body.totalAmount;
        let netGst = req.body.netGST;
        let totalAmount = amount + netGst;
        let amountPaid = 500;
        let balance = totalAmount - amountPaid;
        let modeofPayment = req.body.modeofPayment;

        var sql = `call AddBill(${dealerId},'${vehicleNumber}',
        ${labourCharges},${amount},${netGst},${totalAmount},${amountPaid})`;
        const result = await dbQuery(sql);
        console.log('Bill Id', result[0][0].billId);
        billId = result[0][0].billId;

        productsArray.map(async (product) => {
           
            let quantityPurchased = product.quantityPurchased;
            let GetPurchaseAvailability = `call GetPurchaseAvailability(${product.productId},'Normal')`;
            let result = await dbQuery(GetPurchaseAvailability);
            console.log('Result',result);
            let availabilityArray = result[0];
          console.log('Availability Array',availabilityArray);
            let costPrice = 0;
            availabilityArray.forEach(async (availablePurchase) => {
                if (quantityPurchased > 0) {
                    let quantity = availablePurchase.availability;
                    if (quantity >= quantityPurchased) {
                        costPrice = costPrice + quantityPurchased * availablePurchase.rate;
                        let sql = `call ManagePurchaseAvailability(${availablePurchase.purchase_productId},${quantityPurchased},
                           'Subtract')`;
                        await dbQuery(sql);
                        quantityPurchased = 0;
                    }
                    else {
                        let sql = `call ManagePurchaseAvailability(${availablePurchase.purchase_productId},${quantity},'Subtract')`;
                        await dbQuery(sql);
                        costPrice = costPrice + quantityPurchased * availablePurchase.rate;
                        quantityPurchased = quantityPurchased - quantity;
                    }
                }
                // else
                    // break;
            });


            let sql1 = `call AddBillProduct(${billId},${product.productId},${product.quantityPurchased},
                ${costPrice},${product.totalSellingPrice},${100},${100},${100})`;
            await dbQuery(sql1);

            let sql2 = `call ManageStock(${product.productId},${product.quantityPurchased},'Normal','Subtract')`;
            await dbQuery(sql2);
        })

        if (amountPaid > 0) {
            var transactionSql = `call ManageTransaction(${billId},${dealerId},${amountPaid},'${modeofPayment}','Sell')`;
            await dbQuery(transactionSql);
        }
        if (balance > 0) {
            var outstandingSQl = `call ManageOutstandings(${dealerId},${balance},'Recieve')`;
            await dbQuery(outstandingSQl);
        }

        res.send({
            status: 'Success',
            message: 'Sale Successful'
        })
    }
    catch (e) {
        console.log('Exception', e)
    }
}

async function dbQuery(sqlQuery) {
    return new Promise((resolve, reject) => {
        db.query(sqlQuery, (err, result) => {
            if (err) {
                console.log(err);
                //console.log('Purchase Id',purchaseId);
                reject(err);
            }
            else {
                console.log(result);
                // console.log('Purchase Id :- ',purchaseId);
                resolve(result);
            }
        })
    })
}