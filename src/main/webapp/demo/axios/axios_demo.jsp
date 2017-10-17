<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Axios</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/plug/axios.min.js"></script>
</head>
<script type="text/javascript">

    var domain="/myspringmvc";   

    function getString(){
    	
    	 var customerArray = new Array();
    		customerArray.push({id: "1", name: "李四", age: 21,birthDay:"2016-09-30 12:12:12"});
    	    customerArray.push({id: "2", name: "张三", age: 21,birthDay:"2016-09-30 10:09:08"});	    	
	    
	    axios({
  		  method: 'post',
  		  url: domain+'/parmeter/getuserlist',
  		  data:customerArray  		 
  		})
		.then(function (response) {
		  console.log(response);
		})
		.catch(function (error) {
		       console.log(error);
		});
    }
    
    
 
    function postJson(){  	
    	 var data= { account:decodeURIComponent("你好"),pwd:"123456" };    	
    	 axios({
    		  method: 'post',  //用get传要编码
    		  url: domain+'/parmeter/getparameter',
    		  params: data
    		})
		.then(function (response) {
		  console.log(response);
		})
		.catch(function (error) {
		       console.log(error);
		});
    }
    
    function getJson(){ 
   	 var data= { account:decodeURIComponent("你好"),pwd:"123456" };   	 
   	 axios({
   		  method: 'get',  //用get传要编码
   		  url: domain+'/parmeter/showparameter',
   		  params: data 		
   		})
		.then(function (response) {
		  console.log(response);
		})
		.catch(function (error) {
		       console.log(error);
		});
   }
    
</script>
<body>
<input type="button" value="get-string" onclick="getString();">
<input type="button" value="post-json" onclick="postJson();">
<input type="button" value="get-json" onclick="getJson();">
</body>
</html>