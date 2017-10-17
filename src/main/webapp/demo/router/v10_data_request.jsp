<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>数据请求</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<script type="text/javascript" src="../../js/iview/vue-router.js"></script>
</head>
<script type="text/javascript">
window.onload=function(){
	
	new Vue({
		  data: {
		      loading: false,
		      post: null,
		      error: null
		  },
		  created:function(){
			    // 组件创建完后获取数据，
			    // 此时 data 已经被 observed 了
			    this.fetchData();
		},
		watch: {
			    // 如果路由有变化，会再次执行该方法
			    '$route': 'fetchData'
		},
		methods:{
			fetchData:function(){
			     this.error = this.post = null;
			     this.loading = true;
			     setTimeout( ()=> {
			    	    this.post={title:"java",body:"spring"};
			    	    this.loading=false;
			            //console.log(this.type + ' says ' + say)
			        }, 5000);			    	        
			}
		},
		  template: `
		  <div class="post">
		    <div class="loading" v-if="loading">
		      Loading...
		    </div>

		    <div v-if="error" class="error">
		      {{ error }}
		    </div>

		    <div v-if="post" class="content">
		      <h2>{{ post.title }}</h2>
		      <p>{{ post.body }}</p>
		    </div>
		  </div>
		  `
		}).$mount('#app');
}
</script>
<body>
	<div id="app"></div>
</body>
</html>