<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>vue-template</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
</head>
<script>
window.onload=function(){
	var ve1=new Vue({
		el:"#app1",
		data:{
			message:"hello word"
		}	
	});
	
	var ve2=new Vue({
		el:"#app2",
		data:{
			rawHtml:"<span style='color:red;'>code</span>"
		}	
	});
	
	var ve3=new Vue({
		el:"#app3",
		data:{
			dynamicId:'app-1',
			isButtonDisabled:true,
			src:"https://www.baidu.com/img/baidu_jgylogo3.gif",
			seen:false
		},		
	    methods : {
	    	click : function() {
					this.src = "https://p4.ssl.qhimg.com/t01a334284ab2c07df4.png";
					alert(this.$el.querySelector("#app-1").innerHTML);
					alert(this.$el.querySelector("#list-app-1").innerHTML);
				}
			}
		});
	}
</script>
<body>
<div id="app1">
	<div>Message: {{ message }}</div>
	<div v-once>这个将不会改变: {{ message }}</div>
	<input v-model="message">
</div>
<br>
<div id="app2">
	<div> {{ rawHtml }}</div>
	<div v-html="rawHtml"></div>	
</div>
<br>
<div id="app3">
		<div v-bind:id="dynamicId">
			<button v-on:click="click()">get id</button>
		</div>
		<br>
		<div v-bind:id="'list-' + dynamicId"><button v-bind:disabled="isButtonDisabled">Button</button></div>	
		<br>	
		<img v-bind:src="src"></img>
		<p v-if="seen">隐藏了</p>
		<p v-else>现在你看到我了</p>
	</div>
</body>
</html>