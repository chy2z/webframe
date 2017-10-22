<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<html>
<head>
    <title>组织机构</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <style>
        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
        }

        #app {
            height: 100%;
        }

        .layout {
            box-sizing: border-box ;
            width: 100%;
            height: 100%;
            /* 上下间距 60px */
            padding: 60px 0;
            border: 0px solid #d7dde4;
            background: #f5f7f9;
            border-radius: 4px;
            overflow: hidden;
        }

        .layout-top{
            width: 100%;
            height:60px;
            /* 向上偏移 60px */
            margin: -60px 0 0;
            background: #00ff00;
        }


        .layout-body{
            width: 100%;

            /* 占满剩余高度 */
            height: 100%;
            background: #19be6b;
        }

        .layout-bottom{
            width: 100%;
            height:60px;
            /* 向下偏移 60px */
            margin:0 0 -60px;
            background: #f5a623;
        }

    </style>
</head>
<body>
<div id="app">
    <div class="layout">
        <Row class-name="layout-top" type="flex">
            <i-col  span="12">col-12</i-col >
            <i-col  span="12">col-12</i-col >
        </Row>
        <Row class-name="layout-body" type="flex">
            <i-col  span="24">col-body</i-col >
        </Row>
        <Row class-name="layout-bottom" type="flex">
            <i-col  span="24">col-bottom</i-col >
        </Row>
    </div>
</div>
</body>
<script>
    window.onload=function() {
        new Vue({
            el: '#app',
            data: {}
        });
    }
</script>
</html>
