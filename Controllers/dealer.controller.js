const db = require('../DB');
console.log('Dealer Controller');
module.exports.GetDealer = function (req, res) {
    try {
        var sql = "call GetDealer()";
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

module.exports.GetDealerById = (req, res) => {
    try {

        let dealerId = req.params.id;
        console.log('Params', dealerId);
        var sql = `call GetDealerById(${dealerId})`;
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

module.exports.AddDealer = (req, res) => {
    try {
        console.log(req.body);
        let dealerUserName = req.body.dealerUserName;
        let dealerContactPerson = req.body.dealerContactPerson;
        let dealerType = req.body.dealerType;
        let dealerAgencyName = req.body.dealerAgencyName;
        let dealerAddress = req.body.dealerAddress;
        let dealerCity = req.body.dealerCity;
        let dealerPinCode = req.body.dealerPinCode;
        let dealerEmail = req.body.dealerEmail;
        let dealerMobileNumber = req.body.dealerMobileNumber;
        let dealerPhoneNumber = req.body.dealerPhoneNumber;
        let createdBy = 1;
        var sql = `call AddDealer('${dealerUserName}','${dealerContactPerson}',
        '${dealerType}',
        '${dealerAgencyName}',
             '${dealerAddress}',
            '${dealerCity}',${dealerPinCode},'${dealerEmail}','${dealerMobileNumber}',
            '${dealerPhoneNumber}',${createdBy})`;
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

module.exports.EditDealer = (req, res) => {
    try {
        console.log(req.body);
        let dealerId = req.body.dealerId;
        let dealerUserName = req.body.dealerUserName;
        let dealerContactPerson = req.body.dealerContactPerson;
        let dealerType = req.body.dealerType;
        let dealerAgencyName = req.body.dealerAgencyName;
        let dealerAddress = req.body.dealerAddress;
        let dealerCity = req.body.dealerCity;
        let dealerPinCode = req.body.dealerPinCode;
        let dealerEmail = req.body.dealerEmail;
        let dealerMobileNumber = req.body.dealerMobileNumber;
        let dealerPhoneNumber = req.body.dealerPhoneNumber;
        let updatedBy = 1;
        var sql = `call EditDealer(${dealerId},'${dealerUserName}','${dealerContactPerson}',
        '${dealerType}',
        '${dealerAgencyName}',
        '${dealerAddress}',
        '${dealerCity}',${dealerPinCode},'${dealerEmail}','${dealerMobileNumber}','${dealerPhoneNumber}',
        ${updatedBy})`;
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

module.exports.DeleteDealer = (req, res) => {
    try {
        console.log(req.body);
        let dealerId = req.body.dealerId;
        let reason = req.body.reason
        let updatedBy = 1;
        var sql = `call DeleteDealer(${dealerId},${reason},${updatedBy})`;
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