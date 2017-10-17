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
	const Home = {
			  template: `
			    <div class="home">
			      <h2>Home</h2>
			      <p>hello</p>
			    </div>
			  `
			};
	
	const Parent = {
			  data () {
			    return {
			      transitionName: 'slide-left'
			    }
			  },
			  // dynamically set transition based on route change
			  watch: {
			    '$route' (to, from) {
			      const toDepth = to.path.split('/').length
			      const fromDepth = from.path.split('/').length
			      this.transitionName = toDepth < fromDepth ? 'slide-right' : 'slide-left'
			    }
			  },
			  template: `
			    <div class="parent">
			      <h2>Parent</h2>
			      <transition :name="transitionName">
			        <router-view class="child-view"></router-view>
			      </transition>
			    </div>
			  `
			}
	
	const Default = { template: '<div class="default">default</div>' }
	const Foo = { template: '<div class="foo">foo</div>' }
	const Bar = { template: '<div class="bar">bar</div>' }
	
	const router = new VueRouter({
		  mode: 'history',
		  base: '/',
		  routes: [
		    { path: '/', component: Home },
		    { path: '/parent', component: Parent,
		      children: [
		        { path: '', component: Default },
		        { path: 'foo', component: Foo },
		        { path: 'bar', component: Bar }
		      ]
		    }
		  ]
		});
	
	new Vue({
		  router,
		  template: `
		    <div id="app">
		      <h1>Transitions</h1>
		      <ul>
		        <li><router-link to="/">/</router-link></li>
		        <li><router-link to="/parent">/parent</router-link></li>
		        <li><router-link to="/parent/foo">/parent/foo</router-link></li>
		        <li><router-link to="/parent/bar">/parent/bar</router-link></li>
		      </ul>
		      <transition name="fade" mode="out-in">
		        <router-view class="view"></router-view>
		      </transition>
		    </div>
		  `
		}).$mount('#app')

}
</script>
<body>
<div id="app">
</div>
</body>
</html>