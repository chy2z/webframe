<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jwt web token</title>
<link rel="stylesheet" type="text/css" href="../css/default.css" />
<script language="JavaScript" src="../js/jquery.min.js" ></script>
<script language="JavaScript" src="../js/jquery.json.min.js" ></script>
</head>
<script type="text/javascript">
    var domain='/myspringmvc';
    
    function gettoken(){    
	     var data = { uname:$("#uname").val(),upwd:$("#upwd").val() };	
		 $.ajax({
	        url: domain+"/login/token",
	        type: "POST",     
	        data: data,   
	        success: function(data){
	            $("#token").val(data);
	        },
	        error: function(res){
	           alert(res.responseText);
	        }
	    });
    }
	   
    function checktoken(){
    	 var data = { utoken:$("#token").val() };	
		 $.ajax({
	        url: domain+"/login/check",
	        type: "POST",     
	        data: data,   
	        success: function(data){
	            $("#token").val(data);
	        },
	        error: function(res){
	           alert(res.responseText);
	        }
	    });
    }
    
</script>
<body>
<div><h1>jwt web token</h1></div>    
<span>用户名</span>
<input id="uname" type="text" />
<span>密码</span>
<input id="upwd" type="text"  />
<input type="button" value="提交" onclick="gettoken();" >
<input type="button" value="验证" onclick="checktoken();" >
<input id="token" type="text" style="width:500px"  />
</body>
</html>