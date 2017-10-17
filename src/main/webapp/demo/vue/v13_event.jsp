<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>vue-event</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<script type="text/javascript" src="../../js/iview/vue.js"></script>
</head>
<script type="text/javascript">
window.onload=function(){
	var app1 = new Vue({
		  el: '#app1',
		  data: {
		    counter: 0
		  }
	});
	
  var app2 = new Vue({
		  el: '#app2',
		  data: {
		    name: 'Vue.js'
		  },
		  // 在 `methods` 对象中定义方法
		  methods: {
		    greet: function (event) {
		      // `this` 在方法里指当前 Vue 实例
		      alert('Hello ' + this.name + '!')
		      // `event` 是原生 DOM 事件
		      if (event) {
		        alert(event.target.tagName)
		      }
		    }
		  }
	});	
	// 也可以用 JavaScript 直接调用方法
	//app2.greet()
	
	var app3=new Vue({
		el:"#app3",
		methods: {
			  warn: function (message, event) {
			    // 现在我们可以访问原生事件对象
			    if (event) event.preventDefault();
			    alert(message);
			  }
			}	
	});	
	
	var app4=new Vue({
		el:"#app4",
		methods:{
			doThis:function(){
				alert("dothis");
			},
			doThat:function(){
				alert("dothat");
			}
		}
	});
	
	var app5=new Vue({
		el:"#app5",
		methods:{
			doSomething:function(){
				alert("doSomething");
			}
		}
	});
	
	var app6=new Vue({
		el:"#app6",
		data:{
			message:''
		}
	});
	
	var app7=new Vue({
		  el: '#app7',
		  data: {
		    checkedNames: [],
		    checked:true
		  }
		});
	
	var app8=new Vue({
		  el: '#app8',
		  data: {
			  picked:'One'
		  }
		});
	
	var app9=new Vue({
		  el: '#app9',
		  data: {
			  selected:'B'
		  }
		});
	
	var app10=new Vue({
		  el: '#app10',
		  data: {
			  selected:[]
		  }
		});
	
	var app11=new Vue({
		  el: '#app11',
		  data: {
			    selected: 'A',
			    options: [
			      { text: 'One', value: 'A' },
			      { text: 'Two', value: 'B' },
			      { text: 'Three', value: 'C' }
			    ]
			  }
		});
	
	var app12=new Vue({
		el: '#app12',
		data:{
			picked:'',
			toggle:true,
			selected:"efg"
		}
	});
	
	var app13=new Vue({
		el: '#app13',
		data:{
			a:{msg:'aa'},
			b:{msg:'bb'},
			pick:{},
			toggle:{},
			selected:{number:''}
		}
	});
};   
</script>
<body>
<div id="app1">
  <button v-on:click="counter += 1">增加 1</button>
  <p>这个按钮被点击了 {{ counter }} 次。</p>
</div>

<div id="app2">
  <!-- `greet` 是在下面定义的方法名 -->
  <button v-on:click="greet">Greet</button>
</div>

<br>

<div id="app3">
<button v-on:click="warn('Form cannot be submitted yet.', $event)">
  Submit
</button>
</div>

<div id="app4">

<!-- 阻止单击事件冒泡 -->
<a v-on:click.stop="doThis"></a>
<!-- 提交事件不再重载页面 -->
<form v-on:submit.prevent="onSubmit"></form>
<!-- 修饰符可以串联  -->
<a v-on:click.stop.prevent="doThat"></a>
<!-- 只有修饰符 -->
<form v-on:submit.prevent></form>
<!-- 添加事件侦听器时使用事件捕获模式 -->
<div v-on:click.capture="doThis">doThis...</div>
<!-- 只当事件在该元素本身（比如不是子元素）触发时触发回调 -->
<div v-on:click.self="doThat">doThat...</div>
<!-- 点击事件将只会触发一次 -->
<a v-on:click.once="doThis">doThis...</a>

<!-- 

使用修饰符时，顺序很重要；相应的代码会以同样的顺序产生。因此，用 @click.prevent.self 会阻止所有的点击，而 @click.self.prevent 只会阻止元素上的点击。

 -->

</div>

<div id="app5">

<!-- 只有在 keyCode 是 13 时调用 vm.submit() -->
<input v-on:keyup.13="submit">
<!-- 同上 -->
<input v-on:keyup.enter="submit">
<!-- 缩写语法 -->
<input @keyup.enter="submit">
<!-- Alt + C -->
<input @keyup.alt.67="clear">
<!-- Ctrl + Click -->
<div @click.ctrl="doSomething">Do something</div>

</div>

<!-- 文本框 -->
<div id="app6">

<input v-model="message" placeholder="edit me">
<p>Message is: {{ message }}</p>

<span>Multiline message is:</span>
<p style="white-space: pre-line">{{ message }}</p>
<br>
<textarea v-model="message" placeholder="add multiple lines"></textarea>

</div>

<!-- 复选按钮 -->
<div id="app7">
 
<input type="checkbox" id="checkbox" v-model="checked">
<label for="checkbox">{{ checked }}</label>

<br>

 <input type="checkbox" id="jack" value="Jack" v-model="checkedNames">
  <label for="jack">Jack</label>
  <input type="checkbox" id="john" value="John" v-model="checkedNames">
  <label for="john">John</label>
  <input type="checkbox" id="mike" value="Mike" v-model="checkedNames">
  <label for="mike">Mike</label>
  <br>
  <span>Checked names: {{ checkedNames }}</span>
  
</div>

<!-- 单选按钮 -->

<div id="app8">
  <input type="radio" id="one" value="One" v-model="picked">
  <label for="one">One</label>
  <br>
  <input type="radio" id="two" value="Two" v-model="picked">
  <label for="two">Two</label>
  <br>
  <span>Picked: {{ picked }}</span>
</div>

<!-- 选择列表  单选列表-->
<div id="app9">
  <select v-model="selected">
    <option disabled value="">请选择</option>
    <option>A</option>
    <option>B</option>
    <option>C</option>
  </select>
  <span>Selected: {{ selected }}</span>
</div>

<!-- 选择列表  多选列表-->
<div id="app10">
  <select v-model="selected" multiple style="width: 50px">
    <option>A</option>
    <option>B</option>
    <option>C</option>
  </select>  
  <br>  
  <span>Selected: {{ selected }}</span>
</div>

<!-- 选择列表 -->
<div id="app11">
<select v-model="selected">
  <option v-for="option in options" v-bind:value="option.value">
    {{ option.text }}
  </option>
</select>
<span>Selected: {{ selected }}</span>
</div>

<!-- 绑定value 静态属性 -->

<div id="app12">

<!-- 当选中时，`picked` 为字符串 "a" -->
<input type="radio" v-model="picked" value="a">

<!-- `toggle` 为 true 或 false -->
<input type="checkbox" v-model="toggle">

<!-- 当选中时，`selected` 为字符串 "abc" -->
<select v-model="selected">
  <option value="abc">ABC</option>
  <option value="efg">EFG</option>
</select>

<input type="text" v-model="picked"  >
<input type="text" v-model="selected" >
<input type="text" v-model="toggle" >
</div>


<!-- 绑定value 对象 -->
<div id="app13">

<input
  type="checkbox"
  v-model="toggle"
  v-bind:true-value="a"
  v-bind:false-value="b"
>

<input type="radio" v-model="pick" v-bind:value="a">

<select v-model="selected">
    <!-- 内联对象字面量 -->
  <option v-bind:value="{ number: 123 }">123</option>
  <option v-bind:value="{ number: 234 }">234</option>
</select>

<input type="text" v-model="toggle.msg"  >
<input type="text" v-model="pick.msg" >
<input type="text" v-model="selected.number" >

</div>

</body>
</html>