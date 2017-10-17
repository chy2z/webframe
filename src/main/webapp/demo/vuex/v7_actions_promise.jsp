<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Actions-Promise</title>
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
    
    var getNum=function(){
       return	new Promise((resolve, reject) => {
	    	 setTimeout(function () {   
	    		console.log("=======getDate=======");
	         	resolve({num:10});      //await等待可以得到返回值
	         }, 2000);
    	});
	} 
	
    var getOtherNum=function(){
        return	new Promise((resolve, reject) => {
 	    	 setTimeout(function () {   
 	    		console.log("=======getOtherNum=======");
 	         	resolve({num:-10});      //await等待可以得到返回值
 	         }, 2000);
     	});
 	} 
	
    const store = new Vuex.Store({
		  state: {
		    count: 0
		  },
		  mutations: {			   
			    add (state,payload) {
			    	console.log("=======add=======");
			    	state.count=state.count+payload.num;
				},
				dec (state) {
					  console.log("=======dec=======");
				      state.count--;
				}
		  },
		  actions: {
			  actionA ({ commit }) {
				    return new Promise((resolve, reject) => {
				      setTimeout(() => {
				        commit('add',{num:5});
				        resolve('dec');  //回调
				      }, 1000)
				    })
			  },
			  actionB ({ dispatch, commit }) {
				    return dispatch('actionA').then((a) => {
				        commit(a);
				      })
			  },
			  async actionC ({ commit }) {
				    commit('add', await getNum());
			  },
			  async actionD ({ dispatch, commit }) {  //await只能在 async用
				    await dispatch('actionC') // 等待 actionC 完成
				    console.log("=======end actionC=======");
				    commit('add', await getOtherNum());
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
			        'actionB','actionD' // 映射 this.actionB() 为 this.$store.dispatch('actionB')
			    ])	    
		  },
		  template: `
		    <div>
		    <div>result={{result}}</div>		    
		    <p>		      
		      <button @click="actionB">Promise</button>	
		      <button @click="actionD">async</button>	
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
