// Db Connections 
const mysql = require('mysql');
var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "Gmail@123",
    database:'testing'
  });
  
  console.log("I am Executing");
  //ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Gmail@123';
  con.connect(function(err,db) {
      console.log("Connection Called");
    if (err) console.log(err);
    else{
    console.log("Connected!");
    
    }
  });

  module.exports=con;