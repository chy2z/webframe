<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>命名路由</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vue-router.js"></script>
</head>
<script type="text/javascript">
window.onload=function(){
	const Home = { template: '<div>This is Home</div>' }
	const Foo = { template: '<div>This is Foo</div>' }
	const Bar = { template: '<div>This is Bar {{ $route.params.id }}</div>' }
	
	const router = new VueRouter({		 
		  routes: [
		    { path: '/', name: 'home', component: Home },
		    { path: '/foo', name: 'foo', component: Foo },
		    { path: '/bar/:id', name: 'bar', component: Bar }
		  ]
		});
	
	 new Vue({
		  router,
		  template: `
		    <div id="app1">
		      <h1>Named Routes</h1>
		      <p>Current route name: {{ $route.name }}</p>
		      <ul>
		        <li><router-link :to="{ name: 'home' }">home</router-link></li>
		        <li><router-link :to="{ name: 'foo' }">foo</router-link></li>
		        <li><router-link :to="{ name: 'bar', params: { id: 123 }}">bar</router-link></li>
		      </ul>
		      <router-view class="view"></router-view>
		    </div>
		  `
		}).$mount('#app');
}


</script>
<body>
<div id="app">
</div>
</body>
</html>