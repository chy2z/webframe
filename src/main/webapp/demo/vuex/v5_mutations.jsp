<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Mutations</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vuex.js"></script>
</head>
<script>
window.onload=function(){
	  
	//Mutations对状态数据进行改变
	//定义的mutation必须是同步函数
	
	const store = new Vuex.Store({
		  state: {
		    count: 10,
		    len:20
		  },
		  mutations: {
			  	increment: state => state.count++,
			    decrement: (state,n) => state.count=state.count-n,
			    len:(state,payload)=>state.len=state.len+payload.l+payload.n
		  }
    });
	
	const app1 = new Vue({
		  el: '#app1',
		  // 把 store 对象提供给 “store” 选项，这可以把 store 的实例注入所有的子组件
		  store,
		  computed:{
			 result(){
				 return this.$store.state.count;
			 },		
			 length(){
				 return this.$store.state.len;
			 }
		  },
		  methods: {
			    incrementCount () {
			        store.commit('increment')
			    },
			    decrementCount () {
			    	store.commit('decrement',2)			    	
			    },
			    incrementLength () {
			        store.commit('len',{l:5,n:-10})
			    },
			    decrementLength () {
			    	//store.commit('len',{l:5,n:-10})
			    	//和上面等价
			    	store.commit({type:'len',l:-5,n:-10})
			    }
		  },
		  template: `
		    <div>
		    <div>result={{result}}</div>
		    <div>length={{length}}</div>
		    <p>
		      <button @click="incrementCount">+</button>
		      <button @click="decrementCount">-</button>
		    </p>
		    <p>
		      <button @click="incrementLength">+</button>
		      <button @click="decrementLength">-</button>
		    </p>
		    </div>
		  `
		});
	
	
	
	const app2 = new Vue({
		  el: '#app2',		  
		  store,
		  computed:{
			 result(){
				 return this.$store.state.count;
			 }	
		  },
		  methods: {
			// 映射 this.increment() 为 this.$store.commit('increment')
			...Vuex.mapMutations(['increment']),
			// 映射 this.add() 为 this.$store.commit('increment')
			...Vuex.mapMutations({add: 'increment'})
		  },
		  template: `
		    <div>
		    <div>result={{result}}</div>		    
		    <p>
		      <button @click="add">+</button>
		    </p>		   
		    </div>
		  `
		})
	
}
</script>
<body>
<div id="app1">
</div>
<br>
<br>
<div id="app2">
</div>
</body>
</html>
