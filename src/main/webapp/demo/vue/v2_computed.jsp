<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>vue-computed</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <script type="text/javascript" src="../../js/iview/vue.js"></script>
  </head>
  <script>
  window.onload=function(){	  
	  //计算属性默认只有 getter
	  var vmE = new Vue({
		    el: '#example',
		    data: {
		      message: 'Hello',
		      message2:'World'
		    },
		    computed: {
		      //get
		      reversedMessage: function () {
		        return this.message.split('').reverse().join('')
		      },
		      //get
		      reversedMessage2: function () {
			        return this.message2.split('').reverse().join('')
			  }
		    }		    
		  });	  
	  
	  vmE.message2='google';
	  
	  //计算属性默认只有 getter ，不过在需要时你也可以提供一个 setter 
	  var vmD = new Vue({
		  el: '#demo',
		  data: {
		    firstName: 'Foo',
		    lastName: 'Bar'
		  },
		  computed: {
		    fullName: {
		    	get: function () {
		    	      return this.firstName + ' ' + this.lastName
		    	    },		    	
		    	set: function (newValue) {
		    	      var names = newValue.split(' ')
		    	      this.firstName = names[0]
		    	      this.lastName = names[names.length - 1]
		    	    }
		    }
		  }
		});	  
	  
	    vmD.fullName="F B";
  }  
  </script>
  <body>
  <div id="example">
    <p>Original message: "{{ message }}"</p>
    <p>Computed reversed message: "{{ reversedMessage }}"</p>
    <p>Computed reversed message: "{{ reversedMessage2 }}"</p>   
  </div>
  <br>
   <div id=demo>
    <p>firstName: "{{ firstName }}"</p>
    <p>lastName: "{{ lastName }}"</p>  
    <p>fullName: "{{ fullName }}"</p>  
  </div>
  </body>
</html>
