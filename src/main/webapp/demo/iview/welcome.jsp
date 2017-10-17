<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />   
<title>Welcome use iview</title>
<%@ include file="importIview.jsp"%>
</head>
<body>
<div id="app">
    <Modal v-model="visible" title="Welcome">欢迎使用 iView</Modal>
    <i-button @click="show">Click me!</i-button>    
</div>
<script>
    new Vue({
        el: '#app',
        data: {
            visible: false
        },
        methods: {
            show: function () {
                this.visible = true;
            }
        }
    })
  </script>
</body>
</html>