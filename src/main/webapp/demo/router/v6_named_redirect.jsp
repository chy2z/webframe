<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>重定向 </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vue-router.js"></script>
</head>
<body>
<script type="text/javascript">
window.onload=function(){
	const Home = { template: '<router-view></router-view>' }
	const Default = { template: '<div>default</div>' }
	const Foo = { template: '<div>foo</div>' }
	const Bar = { template: '<div>bar</div>' }
	const Baz = { template: '<div>baz</div>' }
	const WithParams = { template: '<div>{{ $route.params.id }}</div>' }
	
	const router = new VueRouter({
		  mode: 'history',
		  base: "/",
		  routes: [
		    { path: '/', component: Home,
		      children: [
		        { path: '', component: Default },
		        { path: 'foo', component: Foo },
		        { path: 'bar', component: Bar },
		        { path: 'baz', name: 'baz', component: Baz },
		        { path: 'with-params/:id', component: WithParams },
		        // relative redirect to a sibling route
		        { path: 'relative-redirect', redirect: 'foo' }
		      ]
		    },
		    // absolute redirect
		    { path: '/absolute-redirect', redirect: '/bar' },
		    // dynamic redirect, note that the target route `to` is available for the redirect function
		    { path: '/dynamic-redirect/:id?',
		      redirect: to => {
		        const { hash, params, query } = to
		        console.log(to);
		        if (query.to === 'foo') {
		          return { path: '/foo', query: null }
		        }
		        if (hash === '#baz') {
		          return { name: 'baz', hash: '' }
		        }
		        if (params.id) {
		          return '/with-params/:id'
		        } else {
		          return '/bar'
		        }
		      }
		    },
		    // named redirect
		    { path: '/named-redirect', redirect: { name: 'baz' }},

		    // redirect with params
		    { path: '/redirect-with-params/:id', redirect: '/with-params/:id' },

		    // catch all redirect
		    { path: '*', redirect: '/' }  
		  ]
		});
	
	new Vue({
		  router		  
		}).$mount('#app')
		
		/*
		
		$route.params

		类型: Object
		一个 key/value 对象，包含了 动态片段 和 全匹配片段，如果没有路由参数，就是一个空对象。
		
		$route.query
		
		类型: Object
		
		一个 key/value 对象，表示 URL 查询参数。例如，对于路径 /foo?user=1，则有 $route.query.user == 1，如果没有查询参数，则是个空对象。
		
		$route.hash
		
		类型: string
		
		当前路由的 hash 值 (带 #) ，如果没有 hash 值，则为空字符串。
		
		*/
		
}
</script>
	<div id="app">
		<h1>Redirect</h1>
		<ul>
			<li><router-link to="/relative-redirect"> /relative-redirect (redirects to /foo) </router-link></li>
			<li><router-link to="/relative-redirect?foo=bar"> /relative-redirect?foo=bar (redirects to /foo?foo=bar) </router-link></li>
			<li><router-link to="/absolute-redirect"> /absolute-redirect (redirects to /bar) </router-link></li>
			<li><router-link to="/dynamic-redirect"> /dynamic-redirect (redirects to /bar) </router-link></li>
			<li><router-link to="/dynamic-redirect/123"> /dynamic-redirect/123 (redirects to /with-params/123) </router-link></li>
			<li><router-link to="/dynamic-redirect?to=foo"> /dynamic-redirect?to=foo (redirects to /foo) </router-link></li>
			<li><router-link to="/dynamic-redirect#baz"> /dynamic-redirect#baz (redirects to /baz) </router-link></li>
			<li><router-link to="/named-redirect"> /named-redirect (redirects to /baz) </router-link></li>
			<li><router-link to="/redirect-with-params/123"> /redirect-with-params/123 (redirects to /with-params/123) </router-link></li>
			<li><router-link to="/not-found"> /not-found (redirects to /) </router-link></li>
		</ul>
		<router-view class="view"></router-view>
	</div>
</body>
</html>