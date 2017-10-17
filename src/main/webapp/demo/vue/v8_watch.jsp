<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>vue-watch</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
<!-- Since there is already a rich ecosystem of ajax libraries    -->
<!-- and collections of general-purpose utility methods, Vue core -->
<!-- is able to remain small by not reinventing them. This also   -->
<!-- gives you the freedom to just use what you're familiar with. -->
<script src="../../js/iview/plug/axios.min.js"></script>
<script src="../../js/iview/plug/lodash.min.js"></script>
</head>
<script>
window.onload=function(){
	var watchExampleVM = new Vue({
		  el: '#app1',
		  data: {
		    question: '',
		    answer: 'I cannot give you an answer until you ask a question!'
		  },
		  watch: {
		    // 如果 question 发生改变，这个函数就会运行
		    question: function (newQuestion) {
		      this.answer = 'Waiting for you to stop typing...'
		      this.getAnswer()
		    }
		  },
		  methods: {
		    // _.debounce 是一个通过 lodash 限制操作频率的函数。
		    // 在这个例子中，我们希望限制访问 yesno.wtf/api 的频率
		    // ajax 请求直到用户输入完毕才会发出
		    // 学习更多关于 _.debounce function (and its cousin
		    // _.throttle), 参考: https://lodash.com/docs#debounce
		    getAnswer: _.debounce(
		      function () {
		        if (this.question.indexOf('?') === -1) {
		          this.answer = 'Questions usually contain a question mark. ;-)'
		          return
		        }
		        this.answer = 'Thinking...'
		        var vm = this
		        axios.get('https://yesno.wtf/api')
		          .then(function (response) {
		            vm.answer = _.capitalize(response.data.answer)
		          })
		          .catch(function (error) {
		            vm.answer = 'Error! Could not reach the API. ' + error
		          })
		      },
		      // 这是我们为用户停止输入等待的毫秒数
		      500
		    )
		  }
		})
}
</script>
<body>
<div id="app1">
 <div id="watch-example">
  <p>
    Ask a yes/no question:
    <input v-model="question">
  </p>
  <p>{{ answer }}</p>
</div>
</div>
</body>
</html>