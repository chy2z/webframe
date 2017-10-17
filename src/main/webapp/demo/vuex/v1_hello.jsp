<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>最简单的 Store</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vuex.js"></script>
</head>
<script>
  window.onload=function(){	    
	 
	  const store = new Vuex.Store({
		  state: {
		    count: 0
		  },
		  mutations: {
		  	increment: state => state.count++,
		    decrement: state => state.count--
		  }
		});
	 
	  var app = new Vue({
		  el: '#app',
		  computed: {
		    count () {
			    return store.state.count
		    }
		  },
		  methods: {
		    increment () {
		        store.commit('increment')
		    },
		    decrement () {
		    	store.commit('decrement')
		    }
		  }
		});
}
</script>
<body>
<div id="app">
  <p>{{ count }}</p>
  <p>
    <button @click="increment">+</button>
    <button @click="decrement">-</button>
  </p>
</div>
</body>
</html>
