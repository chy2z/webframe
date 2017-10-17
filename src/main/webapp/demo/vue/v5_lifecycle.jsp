<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>vue-lifecycle</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
</head>
<script>
window.onload=function(){
	var ve = new Vue({
		    el:"#app1",
			data : {
				a : 'hello word'
			},
			created : function() {
				// `this` 指向 vm 实例
				console.log('a is: ' + this.a)
			}
		});
}
</script>
<body>
<div id="app1">{{ a }}</div>
</body>
</html>