var fs = require("fs");
var http = require("http");

function Calculator(){
}

Calculator.prototype.render = function()
{
	var htmlCalc = "<html><body><h2>Please input your seed number</h2>"+
	"<input id=\"input\" type=\"text\"></br>"+
	"<select id=\"dropdown\">"+
		"<option value=\"sum\">Summation</option>"+
		"<option value=\"fact\">Factorial</option>"+
	"</select>"+
	"<button id=\"button1\" onclick=\"myFunction();return false;\">Action</button>"+
	"</body>"+
	"</html>";
	
	return htmlCalc;
};

Calculator.prototype.computeFactorial = function(n){
	var num = parseInt(n);
	var fib = 1;
	if(num == ""){//if it is empty
		
		return ("Please don't leave it empty");
	}
	else if(num == 0){//if it is equals to 0
		
		return ("Your answer is 1");
	}
	else if(num<0){// if it is negative numbers
		return ("Can't calculate negative numbers");
	}
	else{
		for(var i = 1 ; i <= num ; i++){//Making calculations
			fib = fib * i;
		}
		
		return ("Fibonnacci is: "+ fib);
	}
};

Calculator.prototype.computeSummation = function(n){
	var num = parseInt(n);
	
	var sum = 0;
	if(num == ""){//If it is empty
		return ("Please don't leave it empty");
	}
	else if(num == 0){//if it is equals to 0
		
		return ("Your answer is 0");
	}
	else if(num<0){// if it is negative numbers
		
		return  ("Can't calculate negative numbers");
	}
	else{
		for(var i = 0; i <= num ; i++){//Making calculations
			sum=sum+i;
		}
		return ("Sum is: "+sum);
	}
};

module.exports = Calculator;