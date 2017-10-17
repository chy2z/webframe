<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>vue-component</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
</head>
<script>
window.onload=function(){
	
	    // todo-item 组件现在接受一个
	    // "prop"，类似于一个自定义属性
	    // 这个属性名为 todo。
	    // 注册全局组件
	    Vue.component('todo-item', {
			props : [ 'todo' ],
			template : '<li>{{ todo.text }}</li>'
		});
	    
	    //创建实例
		var app1 = new Vue({
			el : '#app1',
			data : {
				groceryList : [ {
					id : 0,
					text : '蔬菜'
				}, {
					id : 1,
					text : '奶酪'
				}, {
					id : 2,
					text : '随便其他什么人吃的东西'
				} ]
			}
		});
	    
	    //局部模版
	    var child={
	          template: '<div>A custom component!</div>'
	    };
	    
	    //创建实例
		var app2= new Vue({		
			  el : '#app2',
			  components: {			    
			    'my-component': child
			  }
		});
	    
	    		
	    var data1 = { counter: 0 }
	    
		var app3=new Vue({
		  el: '#app3',			
		  components:{
			  'simple-counter':{
				  template: '<button v-on:click="counter += 1">{{ counter }}</button>',
				  // 技术上 data 的确是一个函数了，因此 Vue 不会警告，
				  // 但是我们返回给每个组件的实例却引用了同一个 data 对象
				  data:function(){
					  return data1;
				  }
			  }
		  }
		});
		
		var app4=new Vue({
			  el: '#app4',
			  components:{
				  'simple-counter':{
					  template: '<button v-on:click="counter += 1">{{ counter }}</button>',
					  // 为每个组件返回全新的 data 对象
					  data:function(){
						  return { counter: 0 };
					  }
				  }
			  }
		});
		
	}
</script>
<body>

<div id="app1">
  <ol>
    <!--
      现在我们为每个 todo-item 提供 todo 对象
      todo 对象是变量，即其内容可以是动态的。
      我们也需要为每个组件提供一个“key”，晚些时候我们会做个解释。
    -->
    <todo-item
      v-for="item in groceryList"
      v-bind:todo="item"
      v-bind:key="item.id">
    </todo-item>
  </ol>
</div>

<div id="app2">
  <my-component></my-component>
</div>


<div id="app3">
  <simple-counter></simple-counter>
  <simple-counter></simple-counter>
  <simple-counter></simple-counter>
</div>

<div id="app4">
  <simple-counter></simple-counter>
  <simple-counter></simple-counter>
  <simple-counter></simple-counter>
</div>

</body>
</html>