<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../taglib/taglibs.jsp" %>
<%@ include file="../../taglib/import_iview.jsp" %>
<%@ include file="../../taglib/import_jquery.jsp" %>
<%@ include file="../../taglib/import_common.jsp" %>
<%@ include file="../../taglib/import_echarts.jsp" %>
<html>
<head>
    <title>首页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">

</div>
</body>
<script>
    new Vue({
        el: '#app',
        data: {
        },
        methods: {},
        mounted() {

            //var url="http://127.0.0.1:6002/server/keepAlive.htm";

            var url="http://127.0.0.1:8080/my/index";


            $.ajax({
                url: url,
                type: "POST",
                data: {type:"1",name:"你好"},
                success: function(data){
                    log("1----->"+data);
                },
                error: function(res){
                    alert(res.responseText);
                }
            });



            $.ajax({
                url: url,
                type: "POST",
                dataType: "json",
                contentType: 'application/json;charset=utf-8',
                data: $.toJSON({type:"2",name:"你好"}),
                success: function(data){
                    log("2----->"+data);
                    log("2----->"+data.msg.info);
                },
                error: function(res){
                    alert(res.responseText);
                }
            });

        }
    });
    
</script>
</html>
