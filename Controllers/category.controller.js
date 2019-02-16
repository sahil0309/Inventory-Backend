const db = require('../DB');
console.log('User Controller');
module.exports.GetCategory = function (req, res) {
  try {
    var sql = "call GetCategories()";
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

module.exports.AddProduct=(req,res)=>{
    try{
        console.log(req.body);
        let categoryName = req.body.categoryName;
        console.log(categoryName);
        let userId = req.body.userId;
        var sql = `call AddCategory('${categoryName}',${userId})`;
        db.query(sql,(err, result) =>{
          if (err) {
              console.log(err);
            res.status(400).send('Failure Hogya Bawa');
          }
          else {
              console.log(result);
            res.status(200).json(result[0]);
          }
        })
    }
    catch(e){
        res.send(400).send('Error');
    }
}

module.exports.EditProduct=(req,res)=>{
    try{
        console.log(req.body);
        let categoryId = req.body.categoryId;
        let categortyName = req.body.categortyName;
        let reason =req.body.reason;
        let updatedBy=1;
        console.log(categoryName);
        let userId = req.body.userId;
        var sql = `call EditCategory(${categoryId},'${categortyName},'${reason}',${updatedBy})`;
        db.query(sql,(err, result) =>{
          if (err) {
              console.log(err);
            res.status(400).send('Failure Hogya Bawa');
          }
          else {
              console.log(result);
            res.status(200).json(result[0]);
          }
        })
    }
    catch(e){
        res.send(400).send('Error');
    }
}

