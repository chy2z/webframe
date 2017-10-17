<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>滚动行为</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vue-router.js"></script>
</head>
<script type="text/javascript">
window.onload=function(){
	
	const Home = { template: '<div>home</div>' };
	const Foo = { template: '<div>foo</div>' };
	const Bar = {
	  template: `
	    <div>
	      bar
	      <div style="height:500px"></div>
	      <p id="anchor">Anchor</p>
	    </div>
	  `
	};
	
	// scrollBehavior:
	// - only available in html5 history mode
	// - defaults to no scroll behavior
	// - return false to prevent scroll
	const scrollBehavior = (to, from, savedPosition) => {
	  console.log(to);
	  if (savedPosition) {
	    // savedPosition is only available for popstate navigations.
	    return savedPosition
	  } else {
	    const position = {}
	    // new navigation.
	    // scroll to anchor by returning the selector
	    if (to.hash) {
	      position.selector = to.hash
	    }
	    // check if any matched route config has meta that requires scrolling to top
	    if (to.matched.some(m => m.meta.scrollToTop)) {
	      // cords will be used if no selector is provided,
	      // or if the selector didn't match any element.
	      position.x = 0
	      position.y = 0
	    }
	    // if the returned position is falsy or an empty object,
	    // will retain current scroll position.
	    return position
	  }
	}
	
	const router = new VueRouter({
		  mode: 'history',
		  base: "/",
		  scrollBehavior,
		  routes: [
		    { path: '/', component: Home, meta: { scrollToTop: true }},
		    { path: '/foo', component: Foo },
		    { path: '/bar', component: Bar, meta: { scrollToTop: true }}
		  ]
		});

	new Vue({
		  router,
		  template: `
		    <div id="app">
		      <h1>Scroll Behavior</h1>
		      <ul>
		        <li><router-link to="/">/</router-link></li>
		        <li><router-link to="/foo">/foo</router-link></li>
		        <li><router-link to="/bar">/bar</router-link></li>
		        <li><router-link to="/bar#anchor">/bar#anchor</router-link></li>
		      </ul>
		      <router-view class="view"></router-view>
		    </div>
		  `
		}).$mount('#app')
}
</script>
<body>
<div id="app"></div>
</body>
</html>