<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="taglib/taglibs.jsp"%>
<%@ include file="taglib/import_iview.jsp"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />   
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <!--[if lt IE 9]>   
    <![endif]-->
</head>
<style>
    body{ background: #fff;}
</style>
<body>
<div id="app">

</div>
</body>
<script>
    new Vue({
        el: '#app',
        data:{
            loading: false
        }
    });
</script>
</html>
