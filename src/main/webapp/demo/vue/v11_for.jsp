<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>vue-for</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
</head>
<script>
window.onload=function(){
	 
	var vu1 = new Vue({
			el : "#app1",
			data : {
				items : [ {
					message : 'Foo'
				}, {
					message : 'Bar'
				} ]
			}
		});
	
	var vu2 = new Vue({
		el : "#app2",
		data : {
			parentMessage:"Top",
			items : [ {
				message : 'java'
			}, {
				message : 'c#'
			} ]
		}
	});
	
	//循环显示json属性
	var vu3 = new Vue({
		el : "#app3",
		data : {
			jsonObject:{
				name:'chy',
				age:21,
				sex:'男'
			}			
		}
	});
	
	//循环显示json属性
	var vu4 = new Vue({
		el : "#app4",
		data : {
			jsonObject:{
				name:'chy',
				age:25,
				sex:'男'
			}
		}
	});
	
	var vu5 = new Vue({
		el : "#app5",
		data : {
			jsonArry:[
					{
						name:'chy',
						age:25,
						sex:'男'
					},
					{
						name:'zjj',
						age:25,
						sex:'女'
					}
			]
		}
	});

}
</script>
<body>
	<div id="app1">
		<ul>
		  <li v-for="item in items">
		    {{ item.message }}
		  </li>
		</ul>
	</div>
	
	<div id="app2">
		<ul>
		  <li v-for="(item, index) in items">
		    {{ parentMessage }} - {{ index+1 }} - {{ item.message }}
		  </li>
		</ul>
	</div>
	
	<div id="app3">
		<ul>
		  <li v-for="value in jsonObject">
		    {{ value }}
		  </li>
		</ul>
	</div>
	
	<div id="app4">
	   <ul>
		  <li v-for="(value, key, index) in jsonObject">
		   {{ index+1 }}. {{ key }}: {{ value }}
		  </li>
		</ul>
	</div>
	
	<div id="app5">
	   <ul>
		  <li v-for="(value, key, index) in jsonArry">
		         <ul>
		          <li v-for="(value, key, index) in value">
		           {{ index+1 }}. {{ key }}: {{ value }}
		          </li>
		         </ul>
		  </li>
		</ul>
	</div>
</body>
</html>
