<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Getters</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vuex.js"></script>
</head>
<script>
window.onload=function(){
	  
	//Getters对状态数据进行二次处理
	//直接使用辅助函数mapGetters将其映射到本地计算属性中去
	
	const store = new Vuex.Store({
		  state: {
			name:"test",
			len:99,
		    todos: [
		      { id: 1, text: '...', done: true },
		      { id: 2, text: '...', done: false }
		    ]
		  },
		  getters: {
		    doneTodos: state => {
		      return state.todos.filter(todo => todo.done)
		    },
		    doneTodosCount: (state, getters) => {
		        return getters.doneTodos.length
		    }
		  }
		});
	
	
	 var app = new Vue({
		  el: '#app',
		  store,
		  data:{
			  localCount:100
		  },
		  computed:{
			  getLocalCount(){
				 return  this.localCount; 
			  },
			  doneTodosCount(){
				  return this.$store.getters.doneTodosCount;
			  },
			  ...Vuex.mapState(['len','name']),
			  ...Vuex.mapState({
				  length: state => state.len,
				  lenAlias: 'len'
			  }),
			  ...Vuex.mapGetters(['doneTodos'])
		  }
		});
	  
	 
	 //console.log(store.getters.doneTodos);
	 //console.log(store.getters.doneTodosCount);
}
</script>
<body>
<div id="app">  
   <p>name={{ name }}</p>
   <p>len={{ len }}</p>    
   <p>count={{ length }}</p>
   <p>countAlias={{ lenAlias }}</p>
   <p>getLocalCount={{ getLocalCount }}</p>  
   <p>doneTodosCount={{ doneTodosCount }}</p>  
   <p>doneTodos={{ doneTodos }}</p>
   <p>doneTodos={{ doneTodos[0].id }}</p>
   <p>doneTodos={{ doneTodos[0].text }}</p>
</div>
</body>
</html>
