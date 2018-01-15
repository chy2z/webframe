<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>vue-hello</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue@2.5.1.min.js"></script>
</head>
<script>
  window.onload=function(){	  
	  
	  //渲染
	  var app1 = new Vue({
		    el: '#app1',
		    data: {
		      message: 'Hello',
		      message2:"chy"
		    }	    
	  });	
	 
	  app1.message="Hello World！";
	  
	  //加载数据
	  var app2 = new Vue({
		  el: '#app2',
		  data: {
		    message: '页面加载于 ' + new Date().toLocaleString()
		  }
		});
	  
	  //条件
	  var app3=new Vue({
		  el:"#app3",
		  data:{
			  seen: true
		  }
	  });
	  
	  //循环
	  var app4 = new Vue({
		  el: '#app4',
		  data: {
		    todos: [
		      { text: '学习 JavaScript' },
		      { text: '学习 Vue' },
		      { text: '整个牛项目' }
		    ]
		  }
	   });
	  
	  //绑定一个事件监听器
	  var app5=new Vue({
		  el: '#app5',
		  data: {
		    message: 'Hello Vue.js!',
		    message2:''
		  },
		  methods: {
		    reverseMessage: function () {
		    	this.message=this.message.split('').reverse().join('');
		        this.message2 = this.message+" "+ new Date().toLocaleString();
		    }
		  }
	  });
	  
	  app5.message2=app5.message+" "+new Date().toLocaleString();  
	  
	  //输入和应用状态之间的双向绑定
	  var app6 = new Vue({
			el : '#app6',
			data : {
				message : 'Hello Vue!'
			}
		});
}
</script>
<body>
	<div id="app1">
		<p>Original message: "{{ message }}"</p>
		<p>Original message: "{{ message2 }}"</p>
	</div>
	<br>
	<div id="app2">
		<span v-bind:title="message"> 鼠标悬停几秒钟查看此处动态绑定的提示信息！ </span>
	</div>
	<br>
	<div id="app3">
		<p v-if="seen">现在你看到我了</p>
	</div>
	<br>
	<div id="app4">
		<ol>
			<li v-for="todo in todos">{{ todo.text }}</li>
		</ol>
	</div>
	<br>
	<div id="app5">
		<p>{{ message2 }}</p>
		<button v-on:click="reverseMessage">逆转消息</button>
	</div>
	<br>
	<div id="app6">
		<p>{{ message }}</p>
		<input v-model="message">
	</div>
</body>
</html>
