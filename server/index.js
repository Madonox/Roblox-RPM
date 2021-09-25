const Database = require("@replit/database");
const db = new Database();
const express = require('express');
var bodyParser = require('body-parser');
var app = express();
const adminTerminalCode = process.env['administrationTerminal']
// Package fetch

var jsonParser = bodyParser.json();
 
// create application/x-www-form-urlencoded parser
var urlencodedParser = bodyParser.urlencoded({ extended: false });

app.get('/packages/:package',function(req,res) {
  db.get(req.params.package).then(value => {
    if (value != null) {
      res.send(value);
      console.log("Package downloaded: "+req.params.package);
    }
  });
});
app.get('/packageList',function(req,res){
  db.list().then(keys => {
    res.send(keys);
  });
});
app.get('/',function(req,res){
  res.send("Roblox Package Manager\nDatabase storage page.");
});
// Package uploading
app.post('/packageFetch/:packageName',jsonParser,function(req,res){
  setTimeout(function(){
    console.log(req.body);
  },3000);
  db.get(req.params.packageName).then(value => {
    if (value == null) {
      if (req.body != null) {
         if (req.body.source != null) {
          db.set(req.params.packageName, req.body.source).then(() => {
            res.send("Package added to the database!");
            console.log("Package added to database: "+req.params.packageName);
          });
        } else {
          res.send("Package not added, incorrect JSON body.");
        }
      } else {
        res.send("Package not added, null JSON body.");
      }
    } else {
      res.send("Package not added, pre-existing package under this name found!");
    }
  });
});
// Admin terminal
app.get(adminTerminalCode+'/deleteEntry/:key',function(req,res){
  db.get(req.params.key).then(value=>{
    if (value != null) {
      db.delete(req.params.key).then(() => {
      res.send("Request handled, key deleted: "+req.params.key);
     });
    } else {
      res.send("Key not found, did not delete anything.")
    };
  });
});
// Deploying
const port = 3000;
app.listen(port, () => {
  console.log(`RPM Service Provider listening at http://localhost:${port}`)
})
