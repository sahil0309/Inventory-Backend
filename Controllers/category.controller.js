const db = require('../DB');
console.log('User Controller');
module.exports.GetCategory = function(req,res){

  var sql = "call GetCategories()";
  db.query(sql, function (err, result) {
    if (err) {
      console.log(err);
      res.status(400);

    }
    else{
    //  console.log(result);
    //  console.log(res.json(result[0]));
    res.status(200).json(result[0]);
    }
  });
}

