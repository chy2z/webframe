<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>命名视图</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vue-router.js"></script>
</head>
<script type="text/javascript">
window.onload=function(){
	const Foo = { template: '<div>foo</div>' }
	const Bar = { template: '<div>bar</div>' }
	const Baz = { template: '<div>baz</div>' }
	
	const router = new VueRouter({		 
		  mode: 'history',
		  routes: [
		    { path: '/',
		      // a single route can define multiple named components
		      // which will be rendered into <router-view>s with corresponding names.
		      components: {
		        default: Foo,
		        a: Bar,
		        b: Baz
		      }
		    },
		    {
		      path: '/other',
		      components: {
		        default: Baz,
		        a: Bar,
		        b: Foo
		      }
		    }
		  ]
	});
	
	 new Vue({
		  router		  
	  }).$mount('#app');
}


</script>
<body>
<div id="app">
  <h1>Named Views</h1>
  <ul>
    <li>
      <router-link to="/">/</router-link>
    </li>
    <li>
      <router-link to="/other">/other</router-link>
    </li>
  </ul>
  <router-view class="view one"></router-view>
  <router-view class="view two" name="a"></router-view>
  <router-view class="view three" name="b"></router-view>
</div>
</body>
</html>