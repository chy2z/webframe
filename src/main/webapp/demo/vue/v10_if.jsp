<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>vue-if</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
</head>
<script>
window.onload=function(){
	  var vu1=new Vue({
		  el:"#app1",
		  data:{	
			  isOK:true
		  }	  
	  });
	  
	  var vu2=new Vue({
		  el:"#app2",
		  data:{	
			  isJava:false
		  }	  
	  });
	  
	  var vu3=new Vue({
		  el:"#app3",
		  data:{	
			  type:'B'
		  }		 
	  }); 
	  
	  //每次切换时，输入框不被重新渲染
	  var vu4=new Vue({
		  el:"#app4",
		  data:{	
			loginType:'username'
		  },
		  methods:{
			  click:function(){
				  this.loginType=   this.loginType=="username"?"":"username";
			  }
		  }
	  }); 
	  
	  //每次切换时，输入框都将被重新渲染
	  var vu5=new Vue({
		  el:"#app5",
		  data:{	
			loginType:'username'
		  },
		  methods:{
			  click:function(){
				  this.loginType=   this.loginType=="username"?"":"username";
			  }
		  }
	  }); 
	  
	  var vu1=new Vue({
		  el:"#app6",
		  data:{	
			  isOK:true
		  }	  
	  });
}
</script>
<body>
	<div id="app1">
		<h1 v-if="isOK">Yes</h1>
		<h1 v-else>No</h1>
	</div>
	
	<div id="app2">
		<template v-if="isJava">
		<h1>java</h1>
		<p>Paragraph 1</p>
		<p>Paragraph 2</p>
		</template>
		<template v-else>
		<h1>c#</h1>
		<p>Paragraph 1</p>
		<p>Paragraph 2</p>
		</template>
	</div>
	
	<div id="app3">
		<div v-if="type === 'A'">A</div>
		<div v-else-if="type === 'B'">B</div>
		<div v-else-if="type === 'C'">C</div>
		<div v-else>Not A/B/C</div>
		<input v-model="type">
	</div>		
	
	
	<div id="app4">
		<template v-if="loginType === 'username'">
		   <label>Username</label>
		   <input placeholder="Enter your username">
		</template>
		<template v-else> 
		  <label>Email</label>
		  <input placeholder="Enter your email address"> 
		</template>
		<button v-on:click="click()">toggle loginType</button>
	</div>
	
	<div id="app5">
		<template v-if="loginType === 'username'">
		   <label>Username</label>
		   <input placeholder="Enter your username" key="username">
		</template>
		<template v-else> 
		  <label>Email</label>
		  <input placeholder="Enter your email address" key="email"> 
		</template>
		<button v-on:click="click()">toggle loginType</button>
	</div>
	
	<div id="app6">
	   <h1 v-show="isOK">注意， v-show 不支持 <template> 语法，也不支持 v-else!</h1>
	</div>
</body>
</html>
