var express = require("express");//Starting express
var app = express();
app.use(express("."));//Making sure we can work in the same directory for different files
var path = require("path");//using path to send my index.html to the localhost


app.get('/sum',function(req,res){//Sum function
	
	console.log("Doing summation with "+parseInt(req.query.answer));
	var sum = 0;
	if(req.query.answer == ""){//If it is empty
		res.send("Please don't leave it empty");
		console.log("Please don't leave it empty");
	}
	else if(parseInt(req.query.answer) == 0){//if it is equals to 0
		res.send("Your answer is 0");
		console.log("Your answer is 0");
	}
	else if(parseInt(req.query.answer)<0){// if it is negative numbers
		res.send("Can't calculate negative numbers");
		console.log("Can't calculate negative numbers");
	}
	else{
		for(var i = 0; i <= req.query.answer ; i++){//Making calculations
			sum=sum+i;
		}
		console.log("Sum is: "+sum);//Printing the answer
		res.send("Sum is: "+sum);
	}
});
app.get("/fact",function(req,res){//Factorial function
	console.log("Doing fibonnacci with "+ parseInt(req.query.answer));
	var fib = 1;
	if(req.query.answer == ""){//if it is empty
		res.send("Please don't leave it empty");
		console.log("Please don't leave it empty");
	}
	else if(parseInt(req.query.answer) == 0){//if it is equals to 0
		res.send("Your answer is 1");
		console.log("Your answer is 1");
	}
	else if(parseInt(req.query.answer)<0){// if it is negative numbers
		res.send("Can't calculate negative numbers");
		console.log("Can't calculate negative numbers");
	}
	else{
		for(var i = 1 ; i <= req.query.answer ; i++){//Making calculations
			fib = fib * i;
		}
		console.log("Fibonnacci is: "+fib);//Printing the answer
		res.send("Fibonnacci is: "+ fib);
	}
});
app.get('/', function(req,res,next) { // sending my html to the local host
    res.sendFile(path.join(__dirname + '/index.html'));
});
app.listen(8080,function(){//Listening the server
	console.log("Server is running");
});

