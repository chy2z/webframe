<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>vue-instance</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
</head>
<script>
window.onload=function(){	  
	  
	var data = { a: 1,message:"hello" }
	
	var vm = new Vue({
	  el: '#app1',
	  data: data
	});
	
	// 他们引用相同的对象！
	console.log("vm.a === data.a=>"+(vm.a === data.a));	
	
	console.log("vm.$data === data =>"+(vm.$data === data));
	
	console.log("vm.$el === document.getElementById('app1') =>"+(vm.$el === document.getElementById('app1')));
	
	// $watch 是一个实例方法
	vm.$watch('a', function (newValue, oldValue) {
	    // 这个回调将在 `vm.a` 改变后调用
		vm.message=newValue;	    
		console.log("newValue:"+newValue+",oldValue"+oldValue);
	});  
	
}
</script>
<body>	
<div id="app1">
  <p>newValue: "{{ message }}"</p>	
  <input v-model=a>	
</div>
</body>
</html>
