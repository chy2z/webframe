<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>vue-method</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
</head>
<script>
window.onload=function(){
	var vu=new Vue({
		el:"#app1",
		data:{
			message:'计算属性的缓存-vs-method-方法',
			nowstring:Date.now()
		},
		computed: {  //计算属性是基于它们的依赖进行缓存的
		    nowc: function () {
			    return Date.now();
			}
		},
		methods:{ //methods作为属性使用 只要UI有更新都会触发
			nowm: function () {
				return Date.now();
			},
			click: function () {
				this.nowstring=Date.now();
			}
		}
	});
}
</script>
<body>
<div id="app1">
  <p>Original message: "{{ message }}"</p>
  <p>Computed reversed message: "{{ nowc }}"</p>
  <p>Computed reversed message: "{{ nowm() }}"</p>  
  <p>Computed reversed message: "{{ nowstring }}"</p>  
  <button v-on:click="click()">method</button>
</div>
</body>
</html>