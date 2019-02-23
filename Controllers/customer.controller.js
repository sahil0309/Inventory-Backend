const db = require('../DB');
console.log('Customer Controller');
module.exports.GetCustomer = function (req, res) {
    try {
        var sql = "call GetCustomer()";
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

module.exports.GetCustomerById = (req, res) => {
    try {

        let customerId = req.params.id;
        console.log('Params', customerId);
        var sql = `call GetCustomerById(${customerId})`;
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

module.exports.AddCustomer = (req, res) => {
    try {
        console.log(req.body);
        let customerUserName = req.body.customerUserName;
        let customerFirstName = req.body._customerFirstName;
        let customerLastName = req.body.customerLastName;
        let customerEmail = req.body.customerEmail;
        let customerMobileNumber = req.body.customerMobileNumber;
        let createdBy = 1;
        var sql = `call AddCustomer('${customerUserName}','${customerFirstName}','${customerLastName}',
             '${customerEmail}',
            '${customerMobileNumber}',${createdBy})`;
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

module.exports.EditCustomer = (req, res) => {
    try {
        console.log(req.body);
        let customerId=req.body.customerId;
        let customerUserName = req.body.customerUserName;
        let customerFirstName = req.body._customerFirstName;
        let customerLastName = req.body.customerLastName;
        let customerEmail = req.body.customerEmail;
        let customerMobileNumber = req.body.customerMobileNumber;
        let updatedBy = 1;
        var sql = `call EditCustomer(${customerId},'${customerUserName}','${customerFirstName}','${customerLastName}',
             '${customerEmail}',
            '${customerMobileNumber}',${createdBy})`;
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

module.exports.DeleteCustomer = (req, res) => {
    try {
        console.log(req.body);
        let customerId = req.body.customerId;
        let reason = req.body.reason
        let updatedBy = 1;
        var sql = `call DeleteCustomer(${customerId},${reason},${updatedBy})`;
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