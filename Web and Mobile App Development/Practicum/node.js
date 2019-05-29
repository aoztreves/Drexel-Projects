var express = require("express");//Starting express
var app = express();
app.use(express("."));//Making sure we can work in the same directory for different files
var path = require("path");//using path to send my index.html to the localhost


app.get('/part2',function(req,res){

	if(req.query.count< 0){//if it is equals to 0
		res.send("You can't do this, no negative numbers");
		console.log("You can't do this, no negative number");
		
	}
	else if(req.query.count == 0){// if it is negative numbers
		res.send("Nothing to print");
		console.log("Nothing to print");
	}
	else{
		var str ="";
		for(var i = 0; i < req.query.count ; i++){//Making calculations
			str= str + req.query.message;
		}
		console.log(str);//Printing the answer
		res.send(str);
	}
});
app.get('/', function(req,res,next) { // sending my html to the local host
    res.sendFile(path.join(__dirname + '/index.html'));
});
app.listen(8080,function(){//Listening the server
	console.log("Server is running");
});

