<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="taglib/taglibs.jsp"%>
<%@ include file="taglib/import_iview.jsp"%>
<%@ include file="taglib/import_jquery.jsp"%>
<html>
<head>
    <title>主页</title>
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
            /*padding: 1px 1px 0px;*/
            padding: 33px 1px 0px;
            overflow: hidden;
            background: #eee;
            border-radius: 4px;
        }

        .layout-right-copy {
            height: 50px;
            margin: 0 0 -50px;
            text-align: center;
            padding: 15px 0;
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
            margin-top: -32px;
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

                            <!-- 加载自定义属性 url -->
                            <menu-Item v-for="l in group.childs" :url="l.url" :icon="l.icon" :id="l.name" :name="l.name">
                                <Icon :type="l.icon"></Icon>
                                {{l.title}}
                            </menu-Item>

                        </menu-Group>

                        <menu-Item v-else :id="group.name" :url="group.url" :icon="group.icon" :name="group.name">
                            <Icon :type="group.icon"></Icon>
                            {{group.title}}
                        </menu-Item>

                        </template>

                    </submenu>

                </i-menu>
            </i-col>
            <i-col :span="spanRight">
                <div class="layout-right">
                    <Tabs  @on-tab-remove="tabRemove" class="layout-right-content" type="card" v-model="tabSelected" >
                        <Tab-Pane label="首页" name="mainframe" icon="ios-home">
                            <iframe id="mainframe" frameborder="0" scrolling="yes"
                                    style="border: 0px; height: 100%; width: 100%;"></iframe>
                        </Tab-Pane>
                        <!-- :key 一定要加，否则动态删除和增加tabpanel会有问题 -->
                        <Tab-Pane v-for="item in tabItems" :key="item.id" :name="item.id" :label="item.name" closable="false" :icon="item.icon">
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
                tabSelected:"0",
                jwt:"${requestScope.jwt}",
                spanLeft: 3,
                spanRight: 21,
                menus:${requestScope.menu},
                tabItems:[]
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
                    let title=$("#"+name).text();
                    let url="${ctx}/login/menu/"+this.jwt+"?menu="+$("#"+name).attr("url");
                    let icon=$("#"+name).attr("icon");
                    let id="mainframe"+name;
                    let extis=false;
                    for(let index in this.tabItems){
                         if(this.tabItems[index].id==id){
                             extis=true;
                             // 激活选项卡
                             this.tabSelected=id;
                             break;
                         }
                    }
                    if(!extis){
                       this.tabItems.push({id:id,name:title,src:url,icon:icon});
                       // 激活新增选项卡
                       this.tabSelected=id;
                    }
                },
                tabRemove(name){
                    let del="";
                    for(let index in this.tabItems){
                        if(this.tabItems[index].id==name){
                            del=index;
                            break;
                        }
                    }
                    if(del!="") {
                        Vue.delete(this.tabItems, del);      //删除数组元素
                        //this.tabItems.splice(parseInt(del),1); //删除数组元素
                    }
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