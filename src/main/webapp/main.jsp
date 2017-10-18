<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="taglib/taglibs.jsp"%>
<%@ include file="taglib/import_iview.jsp"%>
<html>
<head>
    <title>主页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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

        .head {
            height: 80px;
            box-shadow: 0 1px 1px rgba(0,0,0,0.2);
        }

        .head-content{
            height:100%;
            width: 90%;
            margin: 0 auto;
        }

        .head-logo-left-logo{
            height:100%;
            float:left;
        }

        .head-logo-left-logo img{
            height: 50px;
            margin: 15px 0;
        }

        .head-logo-left-title {
            float:left;
            width: 180px;
            height: 30px;
            font-size: 25px;
            line-height: 25px;
            margin: 25px 0;
            border-radius: 3px;
            text-align: center;
            color: #57a3f3;
        }

        .layout {
            position: absolute;
            width: 100%;
            top: 81px;
            bottom: 0px;
            border: 0px solid #d7dde4;
            background: #f5f7f9;
            border-radius: 4px;
            overflow: hidden;
        }

        /*使菜单高度沾满屏幕*/
        .layout-menu {
            height: 100%;
        }

        .layout-right {
            height: 100%;
            padding: 0px 0px 50px;
            box-sizing: border-box;
        }

        .layout-right-content {
            height: 100%;
            min-height: 400px;
            margin: 0px;
            padding: 1px 1px 0px;
            overflow: hidden;
            background: #eee;
            border-radius: 4px;
        }

        .layout-right-copy {
            height: 100px;
            margin: 0 0 -50px;
            text-align: center;
            padding: 15px 0 15px;
            color: #9ea7b4;
        }

        .layout-menu-left {
            background: #222d32;
        }

        .layout-ceiling-main a {
            color: #9ba7b5;
        }

        .layout-hide-text .layout-text {
            display: none;
        }

        .ivu-col {
            transition: width .2s ease-in-out;
        }

        /* tab选项卡头部和内容的间距  */
        .ivu-tabs-bar {
            border-bottom: 1px solid #dddee1;
            margin-bottom: 2px;
        }

        /* tab选项卡内容的高度  */
        .ivu-tabs .ivu-tabs-content{
            height:100%;
        }

        /* tab选项卡内容的高度  */
        .ivu-tabs .ivu-tabs-tabpane {
            -ms-flex-negative: 0;
            flex-shrink: 0;
            width: 100%;
            height:100%;
            transition: opacity .3s;
            opacity: 1;
        }

        /*左侧菜单选中白色*/
        .ivu-menu-dark.ivu-menu-vertical .ivu-menu-item-active:not(.ivu-menu-submenu), .ivu-menu-dark.ivu-menu-vertical .ivu-menu-submenu-title-active:not(.ivu-menu-submenu) {
            color: #fff;
            border-right: 2px solid #fff;
        }

    </style>
</head>
<body>
<div id="app">
    <div class="head">
        <div class="head-content">
            <div class="head-logo-left-logo">
                <img src="../../images/logo.png" >
            </div>
            <div class="head-logo-left-title">后台管理系统</div>
        </div>
    </div>

    <div class="layout" :class="{'layout-hide-text': spanLeft < 3}">
        <Row class-name="layout-menu" type="flex">
            <i-col :span="spanLeft" class="layout-menu-left">
                <i-menu @on-select="menuItemClick" accordion theme="dark" width="auto">
                    <!--
                    <submenu name="1">
                        <template slot="title">
                            <Icon type="ios-paper"></Icon>
                            内容管理
                        </template>
                        <menu-Item id="m1-1" name="m1-1">文章管理</menu-Item>
                        <menu-Item id="m1-2" name="m1-2">评论管理</menu-Item>
                        <menu-Item id="m1-3" name="m1-3">举报管理</menu-Item>
                    </submenu>
                    <submenu name="2">
                        <template slot="title">
                            <Icon type="ios-people"></Icon>
                            用户管理
                        </template>
                        <menu-Item id="m2-1" name="m2-1">新增用户</menu-Item>
                        <menu-Item id="m2-2" name="m2-2">活跃用户</menu-Item>
                    </submenu>
                    <submenu name="3">
                        <template slot="title">
                            <Icon type="stats-bars"></Icon>
                            统计分析
                        </template>
                        <menu-Group title="使用">
                            <menu-Item id="m3-1" name="m3-1">新增和启动</menu-Item>
                            <menu-Item id="m3-2" name="m3-2">活跃分析</menu-Item>
                            <menu-Item id="m3-3" name="m3-3">时段分析</menu-Item>
                        </menu-Group>
                        <menu-Group title="留存">
                            <menu-Item id="m3-4" name="m3-4">用户留存</menu-Item>
                            <menu-Item id="m3-5" name="m3-5">流失用户</menu-Item>
                        </menu-Group>
                        <menu-Item id="m3-6" name="m6-6">其他统计</menu-Item>
                    </submenu>
                     -->

                    <submenu v-for="menu in menus" name="1">
                        <template slot="title">
                            <Icon :type="menu.icon"></Icon>
                            {{ menu.title }}
                        </template>

                        <template v-for = "group in menu.childs">

                        <menu-Group v-if="group.leaf" :title="group.title">

                            <menu-Item v-for="l in group.childs" :id="l.name" :name="l.name">{{l.title}}</menu-Item>

                        </menu-Group>

                        <menu-Item v-else :id="group.name" :name="group.name">{{group.title}}</menu-Item>

                        </template>

                    </submenu>

                </i-menu>
            </i-col>
            <i-col :span="spanRight">
                <div class="layout-right">
                    <Tabs class="layout-right-content" type="card" >
                        <Tab-Pane label="首页"  icon="social-apple">
                            <iframe id="mainframe"  frameborder="0" scrolling="yes" style="border: 0px; height: 100%; width: 100%;"></iframe>
                        </Tab-Pane>
                        <Tab-Pane v-for="item in tabItems" :label="item.name" closable="false" :icon="item.icon">
                            <iframe :id="item.id" :src="item.src" frameborder="0" scrolling="yes" style="border: 0px; height: 100%; width: 100%;"></iframe>
                        </Tab-Pane>
                    </Tabs>

                    <div class="layout-right-copy">2011-2017 &copy; chy</div>
                </div>
            </i-col>
        </Row>
    </div>
</div>
</body>
<script>
    window.onload=function(){
        new Vue({
            el: '#app',
            data:{
                spanLeft: 3,
                spanRight: 21,
                menus:[
                    {name:"1",icon:"ios-paper",title:"内容管理",childs:[
                        {leaf:false,name:"m1-1",title:"文章管理"  },
                        {leaf:false,name:"m1-2",title:"评论管理"  }
                    ]},
                    {name:"2",icon:"ios-people",title:"用户管理",childs:[
                        {leaf:false,name:"m2-1",title:"新增用户"  },
                        {leaf:false,name:"m2-2",title:"活跃用户"  }
                    ]},
                    {name:"3",icon:"stats-bars",title:"统计分析",childs:[
                        {leaf:true,title:"使用",childs:[
                            {leaf:false,name:"m3-1",title:"活跃分析"  },
                            {leaf:false,name:"m3-2",title:"时段分析"  }
                        ]},
                        {leaf:true,title:"留存",childs:[
                            {leaf:false,name:"m3-3",title:"用户留存"  },
                            {leaf:false,name:"m3-4",title:"流失用户"  }
                        ]},
                        {leaf:false,name:"m3-6",title:"其他统计"  }
                    ]}
                ],
                tabItems:[
                    {id:"mainframe0",name:"其他",src:"${ctx}/index.jsp",icon:"social-apple"},
                    {id:"mainframe1",name:"图表",src:"${ctx}/index.jsp",icon:"social-apple"}
                ]
            },
            created:function(){
                document.querySelector("#mainframe").src="${ctx}/index.jsp";
            },
            computed: {
                iconSize () {
                    return this.spanLeft === 3 ? 10 : 24;
                }
            },
            methods: {
                menuItemClick(name){
                    var str= document.querySelector("#"+name).innerText;
                    this.tabItems.push({id:"mainframe"+this.tabItems.length,name:str,src:"${ctx}/index.jsp",icon:"social-apple"});
                },
                toggleClick () {
                    if (this.spanLeft === 3) {
                        this.spanLeft = 1;
                        this.spanRight = 23;
                    } else {
                        this.spanLeft = 3;
                        this.spanRight = 21;
                    }
                }
            }
        });
    }
</script>
</html>