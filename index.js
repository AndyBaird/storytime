//Key require block
var bodyParser = require('body-parser');
var cors = require('cors');
var express = require('express');
var ip = require('ip');
var morgan = require('morgan');
var fs = require('fs');


//Server routes (can be deleted)
var Routes = require('./src/routes.js');

// sample code - Feel free to delete this section
console.log("Start sample code, Hello from the Node Express Base Service...");
console.log('Routes: ', Routes);

//Begin server base code
var app = express();
var portData = fs.readFileSync(__dirname + '/docker/config/webport.txt');
var port = parseInt(portData.toString());

//Serves up static files from the /public directory (if you delete the /public folder, delete this section of code too)
app.use(express.static(__dirname + '/public'));

//Setting up server environment
app.use(morgan('combined'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

//Post endpoint (can be deleted)
app.post('/send', Routes.postToServer);

//express app listener (starts the server)
var listener = app.listen(port, function() {
  var host = listener.address().address;
  if(!host || host === "::") host = "localhost";
  var portUsed = listener.address().port;
  var serverIP = ip.address();
  console.log("ip: ", serverIP);
  console.log("Server listening in docker container at http://%s:%s", serverIP, portUsed);
  console.log('Server listening locally at http://%s:%s', host, portUsed);
});




