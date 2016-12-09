
function postToServer(req, res) {
	var postData = req.body;
	console.log("Data sent to server: ", postData.test);
	// res.send("Cool Stuff");
	res.sendStatus(200);
};


module.exports = {
	postToServer: postToServer
};



function IsJsonString(str) {
  try {
    JSON.parse(str);
  } catch (e) {
    return false;
  }
  return true;
};
