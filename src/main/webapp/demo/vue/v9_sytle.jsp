<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>vue-style</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
</head>
<style>
.static{ font-size:20px;color:green;}
.active{ color:blue ;}
.text-danger{font-weight:bold;}
.component{ background-color:yellow; }
</style>
<script>
window.onload=function(){	 
	
	  var vu1=new Vue({
		  el:"#app1",
		  data:{
			  isActive: true,
			  hasError: false
		  }	  
	  });
	  
	  var vu2=new Vue({
		  el:"#app2",
		  data:{
			  classObject:{
				  active: false,
				  'text-danger': true
			  }
		  }	  
	  });
	  
	  var vu3=new Vue({
		  el:"#app3",
		  data:{			
		  },
		  computed:{
			  getClass:function(){
				  return {active:true,'text-danger':true};
			  }
		  }
	  });
	  
	  var vu4=new Vue({
		  el:"#app4",
		  data:{
			  class1: "active",
			  class2: "text-danger"
		  }	  
	  });
	  
	  var vu5=new Vue({
		  el:"#app5",
		  data:{
			  isActive:true,
			  class1: "active",
			  class2: "text-danger"
		  }	  
	  });  	 
	  
	  
	  // 一定要在 new Vue 前面初始化
	  Vue.component('my-component', {
		  template: '<p class="active text-danger">Hi Jack</p>'
	  });
	  
	  var vu6=new Vue({
		  el:"#app6",
		  data:{
			  styleObject:{
				  color: 'red',
				  fontSize: '20px'
			  },
			  baseStyles:{
				  color: 'green'
			  },
			  overridingStyles:{
				  fontSize: '30px'
			  }
		  }
	  });   	 
}
</script>
<body>
	<div id="app1">
		<div class="static" v-bind:class="{ 'active': isActive, 'text-danger': hasError }">style1</div>
	</div>

	<div id="app2">
		<div class="static" v-bind:class="classObject">style2</div>
	</div>
	
	<div id="app3">
		<div class="static" v-bind:class="getClass">style3</div>
	</div>
	
	<div id="app4">
		<div class="static" v-bind:class="[class1,class2]">style4</div>
	</div>
	
	<div id="app5">
		<div class="static" v-bind:class="[isActive?class1:'',class2]">style5</div>
		<div v-bind:class="[{class1: isActive }, class2]"></div>
	</div>
	
	<div id="app6">
		<my-component class='component'></my-component>
		<div v-bind:style="styleObject">styleObject</div>
		<div v-bind:style="[baseStyles, overridingStyles]">baseStyles overridingStyles</div>
	</div>
</body>
</html>
