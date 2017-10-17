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
	  
	//Actions对状态数据进行改变
	//Action 类似于 mutation，不同在于：
    //Action 提交的是 mutation，而不是直接变更状态。
    //Action 可以包含任意异步操作。	
	
    const store = new Vuex.Store({
		  state: {
		    count: 0
		  },
		  mutations: {
			    inc (state) {
			      state.count++
			    },
			    add (state,payload) {
			    	state.count=state.count+payload.num;
				}
		  },
		  actions: {
			    increment (context) {
			       context.commit('inc')
			    },
			    adding ({ commit },payload) {
				   commit('add',payload)
				},
				incrementAsync ({ commit }) {
				    setTimeout(() => {
				      commit('inc')
				    }, 3000);
				}
		  }		  
    });
    
	const app1 = new Vue({
		  el: '#app1',		 
		  store,
		  computed:{
			 result(){
				 return this.$store.state.count;
			 }	
		  },
		  methods: {
			    ...Vuex.mapActions([
			        'increment' // 映射 this.increment() 为 this.$store.dispatch('increment')
			    ]),
			    ...Vuex.mapActions({
			    	add: 'increment' // 映射 this.add() 为 this.$store.dispatch('increment')	 
			    }),
			    incrementCount () {
			        store.commit('inc')
			    },
			    addCount(){
			    	this.$store.dispatch("adding",{num:5});
			    },
			    asyncCount(){
			    	this.$store.dispatch("incrementAsync");
			    }
		  },
		  template: `
		    <div>
		    <div>result={{result}}</div>		    
		    <p>
		      <button @click="increment">+</button>	
		      <button @click="add">+</button>	
		      <button @click="incrementCount">+</button>	
		      <button @click="addCount">+</button>	
		      <button @click="asyncCount">+</button>	
		    </p>		   
		    </div>
		  `
		});	
	
}
</script>
<body>
<div id="app1">
</div>
</body>
</html>
