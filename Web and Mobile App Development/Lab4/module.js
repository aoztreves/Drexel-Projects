var express = require("express");//Starting express
var app = express();
var http = require('http');
app.use(express("."));//Making sure we can work in the same directory for different files
var path = require("path");//using path to send my index.html to the localhost
var calculator = require("./calculatormodule.js");
var calc = new calculator();
var weather = require("./weathermodule.js");
var wthr = new weather();


app.get('/calculator',function(req,res){
	var output = calc.render();
	res.send(output);
});
app.get("/weather",function(req,res){
	var output = wthr.render();
	res.send(output);
});
app.get("/getWeather",function(req,res){
	res.send(wthr.getWeather());
});
app.get('/sum',function(req,res){//Sum function
	res.send(calc.computeSummation(req.query.answer));
});
app.get("/fact",function(req,res){//Factorial function
	res.send(calc.computeFactorial(req.query.answer));
});
app.get('/',function(req,res,next){
	res.sendFile(path.join(__dirname +'/index.html'));
});
app.listen(8080,function(){
	console.log("Server is running");
});