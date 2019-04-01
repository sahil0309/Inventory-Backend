const db = require('../DB');

module.exports.AddSale = async (req, res) => {
    try {
        let mode = req.body.mode;
        let productsArray = req.body.products;

        productsArray.map(async (product) => {
            let quantityPurchased = product.quantityPurchased;
            let GetPurchaseAvailability = `call GetPurchaseAvailability(${product.productId},'Normal')`;
            let result = dbQuery(GetPurchaseAvailability);
            let availabilityArray = result[0];
            let costPrice = 0;
            availabilityArray.forEach(availablePurchase => {
                if (quantityPurchased > 0) {
                    let quantity = availablePurchase.availability;
                    if (quantity >= quantityPurchased) {
                        costPrice = costPrice + quantityPurchased * availablePurchase.rate;
                        let sql = `call ManagePurchaseAvailablity(${availablePurchase.purchase_productId},${quantityPurchased},
                           'Subtract')`;
                        dbQuery(sql);
                        quantityPurchased = 0;
                    }
                    else {
                        let sql = `call ManagePurchaseAvailablity(${availablePurchase.purchase_productId},${quantity},'Subtract')`;
                        dbQuery(sql);
                        costPrice = costPrice + quantityPurchased * availablePurchase.rate;
                        quantityPurchased = quantityPurchased - quantity;
                    }
                }
                else
                    break;
            });

            let sql2 = `call ManageStock(${product.productId},${product.quantityPurchased},'Normal','Subtract')`;
            await dbQuery(sql2);
        })

        if (amountPaid > 0) {
            var transactionSql = `call ManageTransaction(${sellId},${dealerId},${amountPaid},'${modeofPayment}','Sell')`;
            await dbQuery(transactionSql);
        }
        if (balance > 0) {
            var outstandingSQl = `call ManageOutstandings(${dealerId},${balance},'Recieve')`;
            await dbQuery(outstandingSQl)
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

function dbQuery(sqlQuery) {
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