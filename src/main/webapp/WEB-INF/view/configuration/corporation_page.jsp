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
    <link rel="stylesheet" href="../../../css/default.css">
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

        .my-layout {
            width: 100%;
            height: 100%;
            /* 上下间距 60px */
            padding: 60px 0;
            border: 0px solid #d7dde4;

            border-radius: 4px;
            overflow: hidden;
        }

        .my-layout-top{
            width: 100%;
            height:60px;
            /* 向上偏移 60px */
            margin: -60px 0 0;
        }


        .my-layout-body{
            width: 100%;
            /* 占满剩余高度 */
            height: 100%;
            background: #eee;
        }

        .my-layout-bottom{
            width: 100%;
            height:60px;
            /* 向下偏移 60px */
            margin:0 0 -60px;
        }

    </style>
</head>
<body>
<div id="app">
    <div class="my-layout">
        <Row class-name="my-layout-top" justify="end" align="middle" type="flex">
            <i-col  span="12"></i-col >
            <i-col  span="12">
                <div style="float: right;margin: 0 5px;">
                <Button-Group size="large" shape="circle">
                    <i-Button type="primary" icon="ios-search-strong">搜索</i-Button>
                    <i-Button type="primary" icon="plus">增加</i-Button>
                    <i-Button type="primary" icon="edit">修改</i-Button>
                    <i-Button type="primary" icon="close">删除</i-Button>
                    <i-Button type="primary" icon="ios-glasses">查看</i-Button>
                    <i-Button type="primary" icon="arrow-down-c">导出</i-Button>
                    <i-Button type="primary" icon="refresh">刷新</i-Button>
                </Button-Group>
                </div>

            </i-col >
        </Row>
        <Row class-name="my-layout-body" type="flex">
            <i-col span="24">
                <i-Table border="true" highlight-row="true" stripe
                         size="default" :columns="columnsCorpration" :data="dataCorpration"></i-Table>
            </i-col >
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col  span="12"></i-col >
            <i-col  span="12">
                <div style="float: right;margin: 0 5px;">
                   <Page @on-change="pageChange" @on-page-size-change="pageSizeChange" :total="100" placement="top" show-elevator show-total show-sizer></Page>
                </div>
            </i-col >

        </Row>
    </div>
</div>
</body>
<script>
    window.onload=function() {
        new Vue({
            el: '#app',
            data: {
                columnsCorpration:[
                    {
                        title: '姓名',
                        "fixed": "left",
                        key: 'name',
                        width:100
                    },
                    {
                        title: '年龄',
                        key: 'age',
                        width:100
                    },
                    {
                        title: '地址',
                        key: 'address'
                    }
                ],
                dataCorpration:[
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
                    },
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
                    },
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
                    }
                ]
            },
            methods:{
                pageChange(index){
                    alert(index);
                },
                pageSizeChange(pageSize){
                    alert(pageSize);
                }
            }
        });
    }
</script>
</html>
