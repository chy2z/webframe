<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="taglib/taglibs.jsp" %>
<%@ include file="taglib/import_iview.jsp" %>
<%@ include file="taglib/import_jquery.jsp" %>
<%@ include file="taglib/import_common.jsp" %>
<html>
<head>
    <title>首页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">
    <div class="my-layout my-box-left">
        <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
            <i-col span="24"></i-col>
        </Row>
        <Row class-name="my-layout-body" justify="center" align="middle" type="flex">
            <i-col span="6">
                <i-Circle :percent="80">
                    <span class="demo-Circle-inner" style="font-size:24px">80%</span>
                </i-Circle>
            </i-col>
            <i-col span="6">
                <i-Circle :percent="80">
                    <span class="demo-Circle-inner" style="font-size:24px">80%</span>
                </i-Circle>
            </i-col>
            <i-col span="6">
                <i-Circle :percent="80">
                    <span class="demo-Circle-inner" style="font-size:24px">80%</span>
                </i-Circle>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col span="1"></i-col>
            <i-col span="23">
            </i-col>
        </Row>
    </div>
</div>
</body>
<script>
   new Vue({
        el: '#app',
        data: {
            loading: false
        }
    });
</script>
</html>
