<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>别名</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vue-router.js"></script>
</head>
<body>
<script type="text/javascript">
window.onload=function(){
	const Home = { template: '<div><h1>Home</h1><router-view></router-view></div>' }
	const Foo = { template: '<div>foo</div>' }
	const Bar = { template: '<div>bar</div>' }
	const Baz = { template: '<div>baz</div>' }
	
	const router = new VueRouter({
		  mode: 'history',
		  base: "/",
		  routes: [
		    { 		      
		      path: '/home', component: Home,
		      children: [
		        // absolute alias
		        { path: 'foo', component: Foo, alias: '/foo' },   // /home/foo 的别名叫  /foo ，所以访问 /foo 等于访问  /home/foo
		        // relative alias (alias to /home/bar-alias)
		        { path: 'bar', component: Bar, alias: 'bar-alias' },
		        // multiple aliases
		        { path: 'baz', component: Baz, alias: ['/baz', 'baz-alias'] }
		      ]
		    }
		  ]
	});
	
	new Vue({
		  router,
		  template: `
		    <div id="app">
		      <h1>Route Alias</h1>
		      <ul>
		        <li><router-link to="/foo">
		          /foo (renders /home/foo)
		        </router-link></li>
		        <li><router-link to="/home/bar-alias">
		          /home/bar-alias (renders /home/bar)
		        </router-link></li>
		        <li><router-link to="/baz">
		          /baz (renders /home/baz)</router-link>
		        </li>
		        <li><router-link to="/home/baz-alias">
		          /home/baz-alias (renders /home/baz)
		        </router-link></li>
		      </ul>
		      <router-view class="view"></router-view>
		    </div>
		  `
		}).$mount('#app');
}
</script>
<div id="app">
</div>
</body>
</html>