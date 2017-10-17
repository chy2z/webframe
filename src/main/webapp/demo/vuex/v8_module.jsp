<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Actions</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vuex.js"></script>
</head>
<script>
window.onload=function(){

	/**
	
	默认情况下，模块内部的 action、mutation 和 getter 是注册在全局命名空间的——这样使得多个模块能够对同一 mutation 或 action 作出响应。
	
	*/
	
	const moduleA = {
			  state: {  
				  counta:20
			  },
			  mutations: { 
				  increment: state => state.counta++
			  }			
			}

	const moduleB = {
			  state: { 
				  countb:50
			  },
			  mutations: { 
				  decrement: state => state.countb--
			  }			 
			}
	
	const store = new Vuex.Store({
		   modules: {
			    a: moduleA,
			    b: moduleB
		   }
	});
	
	const app = new Vue({
		  el: '#app',		 
		  store,	
		  computed: {
			    counta () {
				    return store.state.a.counta
			    },
			    countb () {
				    return store.state.b.countb
			    }
		  },
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
		      <p>{{ counta }}</p>
		      <p>{{ countb }}</p>
		      <p>
		      <button @click="increment">+</button>
		      <button @click="decrement">-</button>
		    </p>
		    </div>
		  `
		});	
}
</script>
<body>
<div id="app">

</div>
</body>
</html>
