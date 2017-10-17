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
  window.onload=function(){
	  
	  //mapState 用于属性映射
	  //mapState辅助函数将state映射到计算属性中去
	  
	  const store = new Vuex.Store({
		  state: {
		    count: 10,
		    len:99
		  },
		  mutations: {
			  	increment: state => state.count++,
			    decrement: state => state.count--
			  }
		});
	  
	  const Counter = {
			  template: `
			  <div>
			  <div>count={{ countAlias }}</div>
			  <div>count+localCount={{ countPlusLocalState }}</div>	
			  <div>len={{ len }}</div>
			  </div>
			  `,
			  computed:Vuex.mapState({
				    // 箭头函数可使代码更简练
				    count: state => state.count,

				    // 传字符串参数 'count' 等同于 `state => state.count`
				    countAlias: 'count',

				    // 为了能够使用 `this` 获取局部状态，必须使用常规函数
				    countPlusLocalState (state) {
				      return state.count + this.localCount
				    },
				    len: state => state.len
				  }),
				  data:function(){
					  return { localCount: 50 };
				  }
			}  	 
	 
	  
	  const app = new Vue({
		  el: '#app',
		  data:{
			  localCount:100
		  },
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
		      <div>{{ localCount }}</div>	
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
