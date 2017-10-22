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
    <i-Table stripe :loading="loading" :columns="columns1" :data="data1"></i-Table>
</div>
</body>
<script>
    new Vue({
        el: '#app',
        data:{
            loading: false,
            columns1: [
                {
                    title: '姓名',
                    key: 'name'
                },
                {
                    title: '年龄',
                    key: 'age'
                },
                {
                    title: '地址',
                    key: 'address'
                }
            ],
            data1: [
                {
                    name: '王小明',
                    age: 18,
                    address: '北京市朝阳区芍药居'
                },
                {
                    name: '张小刚',
                    age: 25,
                    address: '北京市海淀区西二旗'
                },
                {
                    name: '李小红',
                    age: 30,
                    address: '上海市浦东新区世纪大道'
                },
                {
                    name: '周小伟',
                    age: 26,
                    address: '深圳市南山区深南大道'
                }
            ]
        }
    });
</script>
</html>
