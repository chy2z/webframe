<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>动态路由</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vue-router.js"></script>
</head>
<script>
window.onload=function(){	  
	
	       //=====================================
	    	   
	        const User = {
			  template: '<div>User:{{ $route.params.name }}</div>'
			};

			const routerUser= new VueRouter({
			  routes: [
			    // 动态路径参数 以冒号开头
			    { path: '/user/:name', component: User }
			  ]
			});
	        
	        const app1 = new Vue({
	        	router:routerUser
	      	}).$mount('#app1')	
	      	
	      	//=====================================
	      	
	      	const Stu={
	        	template: '<div>{{ $route.params.name }},{{ $route.params.id }}</div>',
	        	watch: {
	        		    '$route' (to, from) {	        		        
	        		    	console.log("to"+to);
	        		    	console.log("from"+from);
	        		    }
	        		  }
	        };
	        
	        const routerStu = new VueRouter({
				  routes: [				     
				    { path: '/stu/:name/id/:id', component: Stu }
				  ]
				});
	        
	        const app2 = new Vue({
	        	router:routerStu
		      	}).$mount('#app2')
	        
}
</script>
<body>
  <div id="app1">
     <h1>Hello App!</h1>
		<p>
			<!-- 使用 router-link 组件来导航. -->
			<!-- 通过传入 `to` 属性指定链接. -->
			<!-- <router-link> 默认会被渲染成一个 `<a>` 标签 -->
			<router-link to="/user/foo">Go to Foo</router-link>
			<router-link to="/user/bar">Go to Bar</router-link>
		</p>
		<!-- 路由出口 -->
		<!-- 路由匹配到的组件将渲染在这里 -->
		<router-view></router-view>
  </div>	
  
  <div id="app2">
        <router-link to="/stu/chy/id/1"> Stu chy</router-link>
		<router-link to="/stu/zjj/id/1"> Stu zjj</router-link>
		<router-view></router-view>
  </div>
  
</body>
</html>
