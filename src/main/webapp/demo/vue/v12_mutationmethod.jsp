<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>vue-mutationmethod</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
</head>
<script type="text/javascript">
window.onload=function(){

	var example1 = new Vue({
		el : '#app1',
		data : {
			items : [ {
				message : 'Foo',
				color:'red',
				isOK:true,
				msg:'hi'
			}, {
				message : 'Bar',
				color:'blue'	
			} ,{
				message : 'Zpp',
				color:'green'
			}]
		},
		methods:{
			changeItem:function(){
				//不能触发状态更新
				//example1.items[indexOfItem] = newValue
				//---------------替代方法----------------------
				//赋值，同时也将触发状态更新
				Vue.set(example1.items, 1, {message:'Noo',color:'black'});				
				console.log("item1:"+example1.items[1].message);
			},
			changeValue:function(){
				//赋值，同时也将触发状态更新
				Vue.set(example1.items[1], 'message','Moo');
			},
			changeLength:function(len){
				//不能触发状态更新
				//example1.items.length = newLength
				//---------------替代方法----------------------
				//赋值，同时也将触发状态更新	
				example1.items.splice(len);
				
				console.log("size:"+example1.items.length); 
				
				console.log("item1:"+(typeof(example1.items[1])=="undefined"?"null":example1.items[1].message));
			},
			insert:function(){
				//赋值，同时也将触发状态更新
				Vue.set(example1.items,example1.items.length, {message:'Joo',color:'black'});	
			},
			del:function(){
				//赋值，同时也将触发状态更新
				Vue.delete(example1.items,example1.items.length-1);	
			},
			assign:function(){
				//assign不起作用
				/*
				example1.items[1] = Object.assign({}, example1.items[1], {
					  isOK: true,
					  msg: 'hi'
				});	
				*/
				Vue.set(example1.items[1],"msg", 'hi');	
				Vue.set(example1.items[1],"isOK", true);	
			}
		}	
	});	
	
	
	var vu2=new Vue({
		   el:"#app2",
		   data: {
			  numbers: [ 1, 2, 3, 4, 5 ]
			},
			computed: {
			  evenNumbers: function () {
			    return this.numbers.filter(function (number) {
			      return number % 2 === 0
			    })
			  }
			}
	});
	
	var vu3=new Vue({
		el:"#app3",
		data: {
			  numbers: [ 1, 2, 3, 4, 5 ]
			},
			methods: {
			  even: function (numbers) {
			    return numbers.filter(function (number) {
			      return number % 2 === 0
			    })
			  }
			}	
	});
	
	var vu4=new Vue({
		el:"#app4"		
	});
	
	
	Vue.component('todo-item', {
		  template: '\
		    <li>\
		      {{ title }}\
		      {{ memo }}\
		      <button v-on:click="$emit(\'remove\')">X</button>\
		    </li>\
		  ',
		  props: ['title','memo']
	});
	
	var vu5=new Vue({
		el:"#app5",
		data:{
			newTodoText:"",
			nextTodoId: 4,
			todos:[
			       {
			           id: 1,
			           title: 'Do the dishes',
			           memo:'d'
			         },
			         {
			           id: 2,
			           title: 'Take out the trash',			           
			           memo:'t'
			         },
			         {
			           id: 3,
			           title: 'Mow the lawn',
			           memo:'l'
			         }
			]
		},
		methods: {
		    addNewTodo: function () {		   
		      this.todos.push({
			        id: this.nextTodoId++,
			        title: this.newTodoText,
			        memo:'i'
			  });			    	
		      this.newTodoText = '';
		    }
		 }
	});
}
</script>
<body>
	<div id="app1">
		<li v-for="item in items"><span v-bind:style="item.color"> {{ item.message }} </span> <span
			v-show="item.isOK"> {{ item.msg }} </span></li>
		<button v-on:click="changeItem()">changeItem</button>
		<button v-on:click="changeValue()">changeItem</button>
		<button v-on:click="changeLength(1)">changeValue1</button>
		<button v-on:click="changeLength(3)">changeValue3</button>
		<button v-on:click="insert()">insert</button>
		<button v-on:click="del()">delete</button>
		<button v-on:click="assign()">assign</button>
	</div>

	<div id="app2">
		<li v-for="n in evenNumbers">{{ n }}</li>
	</div>

	<br>
	<div id="app3">
		<li v-for="n in even(numbers)">{{ n }}</li>
	</div>

	<br>
	<div id="app4">
		<li v-for="n in 10">{{ n }}</li>
	</div>

	<br>
	<div id="app5">
		<input v-model="newTodoText" v-on:keyup.enter="addNewTodo" placeholder="Add a todo">
		<ul>
			<li is="todo-item" v-for="(todo, index) in todos" v-bind:key="todo.id" v-bind:title="todo.title" v-bind:memo="todo.memo"
				v-on:remove="todos.splice(index, 1)"></li>
		</ul>
	</div>
</body>
</html>