const db = require('../DB');
console.log('User Controller');
const test = function(req,res){

  var sql = "call GetUser()";
  //console.log(db);
  //var sql='select * from user';
  db.query(sql, function (err, result) {
    if (err) {
      console.log(err);
    }
    else{
     console.log(result);
     console.log(res.json(result[0]));
    }
  });
}
// db.query(sql).then(response=>{
//     console.log(response.json());
    
// }).catch(err=>console.log(err))
// }

module.exports=test;