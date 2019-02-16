const db = require('../DB');
console.log('User Controller');
module.exports.GetCategory = function (req, res) {
  try {
    var sql = "call GetCategory()";
    db.query(sql, function (err, result) {
      if (err) {
        //console.log(err);
        res.status(400).send('Failure Hogya Bawa');

      }
      else {
        //  console.log(result);
        //  console.log(res.json(result[0]));
        res.status(200).json(result[0]);
      }
    })
  }
  catch (e) {
    res.status(400).send('Failure');

  }


}

