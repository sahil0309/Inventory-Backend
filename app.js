const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
var jwt = require('jsonwebtoken');
const routes = require('./Routes/routes');

// initialize our express app
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cors());
app.use('/login',(req,res)=>{
    var token = jwt.sign({ id: 1 },'inventory');
      res.status(200).send({ auth: true, token: token });
})
//app.use('/api',verify, routes);
app.use('/api',routes);

function  verify(req,res,next){
    var token = req.headers['token'];
  if (!token) return res.status(401).send({ auth: false, message: 'No token provided.' });
  jwt.verify(token,'inventory', function(err, decoded) {
    if (err) return res.status(500).send({ auth: false, message: 'Failed to authenticate token.' });
    req.userId=decoded.id;
    next();
  })
}
let port = 3000;
app.listen(port, () => {
    console.log('Server is up and running on port numner ' + port);
});

