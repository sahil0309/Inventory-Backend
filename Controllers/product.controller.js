 const db = require('../DB');
console.log('Product Controller');
  const test = function(req,res){
 
    var sql = "CREATE TABLE customers (name VARCHAR(255), address VARCHAR(255))";
    db.query(sql, function (err, result) {
      if (err) {
        console.log(err);
      }
      else{
       console.log("Table created");
      }
    });
    // db.query(sql).then()
}

module.exports=test;