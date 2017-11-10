<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../taglib/taglibs.jsp" %>
<%@ include file="../../taglib/import_iview.jsp" %>
<%@ include file="../../taglib/import_jquery.jsp" %>
<%@ include file="../../taglib/import_common.jsp" %>
<html>
<head>
    <title>文件上传测试</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <link rel="stylesheet" href="${ctx}/css/lock/unlock.css">
    <style>
        .radiusContent {
            border: 1px solid #eee;
            border-radius: 6px;
            margin-bottom: 20px;
            position: relative;
            transition: all .2s ease-in-out;
        }

        .radiusContent:hover {
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.2);
        }


    </style>
</head>
<body>
<div class="my-app" style="width:400px;margin-top: 50px;margin-left: 50px;" id="app">
    <Row class-name="radiusRow">
        <i-Col span="12">
            <div style="height: 400px;">


            </div>
        </i-Col>
        <i-Col span="12">
            <div style="height: 400px;">
                测试页面
            </div>
        </i-Col>
    </Row>
</body>
<script>
    new Vue({
        el: '#app',
        data: {

        },
        methods: {

        },
        mounted() {

        }
    });
</script>
</html>
