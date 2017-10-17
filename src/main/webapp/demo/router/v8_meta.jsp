<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>路由元信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vue-router.js"></script>
</head>
<script type="text/javascript">
window.onload=function(){
	
	const Foo = { template: '<div>foo<router-view></router-view></div>' }
	const Bar = { template: '<div>bar</div>' }
	const Login = { template: '<div>login</div>' }
	
	const router = new VueRouter({
		  routes: [
		    {
		      path: '/foo',
		      component: Foo,
		      children: [
		        {
		          path: 'bar',
		          component: Bar,
		          // a meta field
		          meta: { requiresAuth: true }
		        }
		      ]
		    },
		    {
		    	path: '/login',
		    	component: Login
		    }
		  ]
		});
	
	
	 router.beforeEach((to, from, next) => {
		  if (to.matched.some(record => record.meta.requiresAuth)) {
		    // this route requires auth, check if logged in
		    // if not, redirect to login page.
		    if (true) {
		      next({
		        path: '/login',
		        query: { redirect: to.fullPath }		        
		      })
		    } else {
		      next()
		    }
		  } else {
		    next() // 确保一定要调用 next()
		  }
	   });
	
	   const app = new Vue({
		  router
		}).$mount('#app');
	
}
</script>
<body>
<div id="app">		
		<p>			
			<router-link to="/foo">Go to Foo</router-link>
			<router-link to="/foo/bar">Go to Bar</router-link>
		</p>		
		<router-view></router-view>
</div>
</body>
</html>