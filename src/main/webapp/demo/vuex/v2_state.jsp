<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>State</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vuex.js"></script>
</head>
<script>

  //State 状态数据

  window.onload=function(){
	  
	  const store = new Vuex.Store({
		  state: {
		    count: 10
		  },
		  mutations: {
			  	increment: state => state.count++,
			    decrement: state => state.count--
			  }
		});
	  
	  const Counter = {
			  template: `
			  <div>{{ counted }}</div>			  
			  `,
			  computed: {
			    counted () {
			      return this.$store.state.count
			    }
			  }
			}  	 
	 
	  const app = new Vue({
		  el: '#app',
		  // 把 store 对象提供给 “store” 选项，这可以把 store 的实例注入所有的子组件
		  store,
		  components: { Counter },
		  methods: {
			    increment () {
			        store.commit('increment')
			    },
			    decrement () {
			    	store.commit('decrement')
			    }
		  },
		  template: `
		    <div class="app">
		      <counter></counter>
		      <p>
		      <button @click="increment">+</button>
		      <button @click="decrement">-</button>
		    </p>
		    </div>
		  `
		})
}
</script>
<body>
<div id="app">  
</div>
</body>
</html>
