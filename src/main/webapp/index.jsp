<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="taglib/taglibs.jsp"%>
<%@ include file="taglib/import_iview.jsp"%>
<%@ include file="taglib/import_jquery.jsp"%>
<%@ include file="taglib/import_common.jsp"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />   
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <link rel="stylesheet" href="css/default.css">
</head>
<style>
    .my-box{
        height: 100%;
    }
</style>
<body>
<div class="myapp" id="app">
    <Row  class-name="my-box" type="flex">
        <i-col span="10">
            <div class="my-layout my-box-left">
                <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
                    <i-col span="1"></i-col >
                    <i-col span="23"></i-col >
                </Row>
                <Row class-name="my-layout-body" type="flex">

                </Row>
                <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                    <i-col  span="1"></i-col >
                    <i-col  span="23">
                        <div style="float: right;margin: 0 5px;">
                            <Page :total="100"></Page>
                        </div>
                    </i-col>
                </Row>
            </div>
        </i-col >
        <i-col span="14">
            <div class="my-layout my-box-right">
                <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
                    <i-col span="10"></i-col >
                    <i-col span="14">
                        <div style="float: right;margin: 0 5px;">
                        </div>
                    </i-col >
                </Row>
                <Row class-name="my-layout-body" type="flex">

                </Row>
                <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                    <i-col  span="1"></i-col >
                    <i-col  span="23">
                        <div style="float: right;margin: 0 5px;">
                            <Page :total="100"></Page>
                        </div>
                    </i-col>
                </Row>
            </div>
        </i-col >
    </Row>


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
