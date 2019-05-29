var express=require('express');
var app=express();
app.use(express.static('.'));
var mysql=require('mysql');

//connection to sql
var connection=mysql.createConnection({
	host:'localhost',
	user:'root',
	password:'aslanoz',
	database:'aslan'
});

app.get('/student',function(req,res){
	
	var name=req.query.student;
	var time=req.query.term;
	var output="";
	var line="";
	var counter=0;
	//connecting database with one another
	var request ='SELECT student.id,firstname,lastname,dob,major,grades.courseid,studentid,term,grade,course.id,description FROM student,grades,course WHERE student.id=grades.studentid&&grades.courseid=course.id&&student.id=\''+name+'\'&&term=\''+time+'\'';

	connection.query(request,function(err,rows,fields){//Sending a request
		
			
			output="<table <tr><th>Student ID</th><th>First Name</th><th>Last Name</th><th>Term</th><th>Course ID</th><th>Description</th><th>Grade</th></tr><tr>";//Creating table
			for(var i=0;i<rows.length;i++){//looping through table
				line="<td>"+rows[i].id+"</td><td>"+rows[i].firstname+"</td><td>"+rows[i].lastname+"</td><td>"+rows[i].term+"</td><td>"+rows[i].courseid+"</td><td>"+rows[i].description+"</td><td>"+rows[i].grade+"</td></tr><tr>";//inputing to the table
				output+=line;
				counter++;
			}
			if(counter==0)
				res.send("Nothing to show!");
			else{
				res.send(output);
			}
		});
	
});
app.get('/table',function(req,res){
	var dbTable=req.query.table;
	var output="";
	var request="SELECT * FROM "+dbTable;//getting table name
	connection.query(request,function(err,rows,fields){//sending a request
				
			if(dbTable=='student'){//basic tables with the same in every if statement
				output="<table <tr><th>Student ID</th><th>First Name</th><th>Last Name</th><th>Birth date</th><th>Major</th></tr><tr>";				
				for(var i=0;i<rows.length;i++){
					line="<td>"+rows[i].id+"</td><td>"+rows[i].firstname+"</td><td>"+rows[i].lastname+"</td><td>"+rows[i].dob+"</td><td>"+rows[i].major+"</td></tr><tr>";
					output+=line;
				}
				
			}
			else if(dbTable=='course'){
				output="<table <tr><th>Course ID</th><th>Description</th><tr>";
				for(var i=0;i<rows.length;i++){
					line="<td>"+rows[i].id+"</td><td>"+rows[i].description+"</td></tr></tr>";
					output+=line;
				}
				
			}
			else if(dbTable=='grades'){
				output="<table><tr><th>Student ID</th><th>Course ID</th><th>Term</th><th>Grade</th><tr>";
				for(var i=0;i<rows.length;i++){
					line="<td>"+rows[i].studentid+"</td><td>"+rows[i].courseid+"</td><td>"+rows[i].term+"</td><td>"+rows[i].grade+"</td></tr><tr>";
					output+=line;
				}
				
			}
			output+="</tr></table>";
				res.send(output);
		});
});
app.listen(8080,function(){
	console.log("server is runnning");
});