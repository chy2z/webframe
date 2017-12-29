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
    <style>
        /* 实现card body 高度100% */
        .my-layout-body .ivu-card{
            height: 100%;
            padding: 51px 0 0;
        }

        /* 实现card body 高度100% */
        .my-layout-body .ivu-card .ivu-card-head{
            margin: -51px 0 0;
        }

        /* 实现card body 高度100% */
        .my-layout-body .ivu-card .ivu-card-body{
            height: 100%;
            overflow: auto;
        }

        .my-layout-body .ivu-card .ivu-card-head {
            border-bottom: 1px solid #e9eaec;
            padding: 14px 16px;
            line-height: 1;
            background-color: #eaf4fe;
        }
    </style>
</head>
<body>
<div class="my-app" id="app">
    <div class="my-layout my-layout-clear-top-10">
        <Row class-name="my-layout-body" justify="center"  type="flex">
            <i-col span="23">
                    <div class="fil-height">
                       ${requestScope.sysNotice.content}
                    </div>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="center" align="middle" type="flex">
            <i-col  span="23">
                <div class="float-right">
                    <i-Button type="success" @click="butRefresh()" icon="refresh">刷新</i-Button>
                </div>
            </i-col>
        </Row>
    </div>
</div>
</body>
<script>
    var domain="${ctx}";
    new Vue({
        el: '#app',
        data: {

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