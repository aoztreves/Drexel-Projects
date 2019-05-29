var fs = require("fs");
var http = require("http");

function weather(){
}
weather.prototype.render = function() {
	var htmlWeather="<html><body><form>"+
	"<input id=\"input\" type=\"text\">"+
	"<button type=\"button\" id=\"lunch\" onclick=\"getZipcode()\">Get Weather!</button>"+
	"<p> My Key: c0e2d4a64a675bcb</p>"+
	"</form></body></html>";
	return htmlWeather;
};
weather.prototype.getWeather = function(){
	

};
module.exports = weather;