<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>嵌套路由</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vue-router.js"></script>
</head>
<script type="text/javascript">
window.onload=function(){
	      const User = {
			  template: `
			    <div class="user">
			      <h2>User {{ $route.params.id }}</h2>
			      <router-view></router-view>
			    </div>
			  `
			}
	      
	      const UserHome = {
	    		template: '<div>User is home</div>'	    		  
	      };
	      
	      const UserProfile = {
	    		  template: '<div>type is {{ $route.params.type }}</div>'	   
	      };
	      
	      const UserPosts = {
	    		  template: '<div>type is {{ $route.params.type }}</div>'	   
	      };
	      
	      const router = new VueRouter({
	    	  routes: [
	    	    { path: '/user/:id', component: User,
	    	      children: [
	    	        {
	    	          // 当 /user/:id 匹配成功，
	    	          // UserHome 会被渲染在 User 的 <router-view> 中
	    	    	  path: '', component: UserHome
	    	        },	    	                 
	    	        {
	    	          // 当 /user/:id/profile 匹配成功，
	    	          // UserProfile 会被渲染在 User 的 <router-view> 中
	    	          path: 'profile/:type',
	    	          component: UserProfile
	    	        },
	    	        {
	    	          // 当 /user/:id/posts 匹配成功
	    	          // UserPosts 会被渲染在 User 的 <router-view> 中
	    	          path: 'posts/:type',
	    	          component: UserPosts
	    	        }
	    	      ]
	    	    }
	    	  ]
	    	});
	      
	      const app = new Vue({
	    	  router
	    	}).$mount('#app')

}
</script>
<body>
<div id="app">
        <h1>Hello App!</h1>
		<p>	
			<router-link to="/user/home/">Go to Home</router-link>
			<router-link to="/user/foo/profile/foo">Go to Foo</router-link>
			<router-link to="/user/bar/posts/bar">Go to Bar</router-link>
		</p>
        <router-view></router-view>
</div>
</body>
</html>