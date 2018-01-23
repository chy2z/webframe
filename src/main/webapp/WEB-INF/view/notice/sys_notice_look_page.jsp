<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>系统通知</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">
    <div class="my-layout my-layout-clear-top-bottom">
        <Row class-name="my-layout-body" justify="center" :gutter="gutter" type="flex">
            <i-col class="fil-height" span="24">
                    <div class="fil-height">
                       ${requestScope.sysNotice.content}
                    </div>
            </i-col>
        </Row>
        <!--
        <Row class-name="my-layout-bottom" justify="center" align="middle" :gutter="gutter" type="flex">
            <i-col span="24">
                <div class="float-right">
                    <i-Button type="success" v-show="hidden" @click="butRefresh()" icon="refresh">刷新</i-Button>
                </div>
            </i-col>
        </Row>
         -->
    </div>
</div>
</body>
<script>
    var domain="${ctx}";
    new Vue({
        el: '#app',
        data: {
            hidden: true,
            gutter: 0
        },
        mounted:function () {

        },
        methods:{
            butRefresh(){
                vconfirm(this,"确认刷新吗?",()=>{
                    window.location.reload();
                });
            }
        }
    });
</script>
</html>
