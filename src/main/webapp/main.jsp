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
            /*background-color: #2b85e4;*/
            background-color:#2d8cf0;
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
            color:#fff;
        }

        /* 头部右侧菜单的高度 */
        .head-right-menu{
            height: 80px;
            float: right;
        }

        /* 头部右侧菜单垂直剧中 */
        .head-right-menu .ivu-menu-horizontal {
            height: 80px;
            line-height: 80px;
        }

        /* 头部右侧菜单项选中颜色和背景色一致 */
        .head-right-menu .ivu-menu-horizontal .ivu-menu-item-active {
            background: #2d8cf0;
        }

        .layout {
            position: absolute;
            width: 100%;
            top: 80px;
            bottom: 0px;
            border: 0px solid #d7dde4;
            background: #f5f7f9;
            border-radius: 0px;
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

        /* 当左侧菜单折叠时，隐藏文字和菜单子项 */
        .layout-hide-text .layout-item-hidden {
            display: none;
        }

        /* 当左侧菜单折叠时，隐藏图标 */
        .layout-hide-text .ivu-menu-submenu-title-icon{
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
            <div class="head-right-menu">
                <i-Menu @on-select="headMenuItemClick" mode="horizontal" theme="primary" active-name="userinfo">
                    <Menu-Item name="toggleMenu">
                        <Icon type="arrow-swap"></Icon>
                        折叠菜单
                    </Menu-Item>
                    <Submenu name="userinfo">
                        <template slot="title">
                            <Icon type="person"></Icon>
                            用户信息
                        </template>
                        <Menu-Group title="基本信息">
                            <Menu-Item name="3-1">姓名:程鸿雁</Menu-Item>
                            <Menu-Item name="3-2">部门:技术部</Menu-Item>
                            <Menu-Item name="3-3">电话:18955545431</Menu-Item>
                            <Menu-Item name="3-4">邮件:chy2z@163.com</Menu-Item>
                            <Menu-Item name="3-5">角色:管理员</Menu-Item>
                        </Menu-Group>
                        <Menu-Group title="其他信息">
                            <Menu-Item name="3-6">登录:2017-10-10 11:23</Menu-Item>
                        </Menu-Group>
                    </Submenu>
                    <Menu-Item name="editPwd">
                        <Icon type="key"></Icon>
                        修改密码
                    </Menu-Item>
                    <Menu-Item name="lockSystem">
                        <Icon type="locked"></Icon>
                        系统锁屏
                    </Menu-Item>
                    <Menu-Item name="logOut">
                        <Icon type="log-out"></Icon>
                        退出系统
                    </Menu-Item>
                </i-Menu>
                <Modal v-model="modalLock" :closable="false" :mask-closable="false" :styles="{top: '250px'}" width="360">
                    <p slot="header" style="color:#f60;text-align:center">
                        <Icon type="information-circled"></Icon>
                        <span>系统锁定</span>
                    </p>
                    <div style="text-align:center">
                        <p><i-Input size="large" icon="unlocked" placeholder="请输入密码解锁......" style="width: 300px"></i-Input></p>
                    </div>
                    <div slot="footer">
                        <i-Button type="error" size="large" long  @click="unLock">确定</i-Button>
                    </div>
                </Modal>
            </div>
        </div>
    </div>

    <div class="layout" :class="{'layout-hide-text': spanLeft < 3}">
        <Row class-name="layout-menu" type="flex">
            <i-col :span="spanLeft" class="layout-menu-left">
                <i-menu @on-select="menuItemClick" accordion theme="dark" width="auto">
                    <submenu v-for="menu in menus" name="1">
                        <template slot="title">
                            <Icon :size="iconSize" :type="menu.icon"></Icon>
                            <span class="layout-item-hidden">{{ menu.title }}</span>
                        </template>

                        <template v-for = "group in menu.childs">

                        <menu-Group class="layout-item-hidden" v-if="group.leaf" :title="group.title">

                            <!-- 加载自定义属性 url -->
                            <menu-Item v-for="l in group.childs" :url="l.url" :icon="l.icon" :id="l.name" :name="l.name">
                                <Icon :type="l.icon"></Icon>
                                <span >{{l.title}}</span>
                            </menu-Item>

                        </menu-Group>

                        <menu-Item class="layout-item-hidden" v-else :id="group.name" :url="group.url" :icon="group.icon" :name="group.name">
                            <Icon :type="group.icon"></Icon>
                            <span >{{group.title}}</span>
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
                jwt:"${requestScope.jwt}",
                menus:${requestScope.menu},
                tabSelected:"mainframe",
                modalLock:false,
                spanLeft: 3,
                spanRight: 21,
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
                    let url="${ctx}/login/menu/"+this.jwt+"?menu="+$("#"+name).attr("url")+"&mid="+name;
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
                headMenuItemClick(name){
                    //切换菜单隐藏显示
                    if(name=="toggleMenu"){
                        if (this.spanLeft === 3) {
                            this.spanLeft = 1;
                            this.spanRight = 23;
                        } else {
                            this.spanLeft = 3;
                            this.spanRight = 21;
                        }
                    }
                    //锁屏
                    else if(name=="lockSystem"){
                        this.modalLock=true;
                    }
                    //提出登录
                    else if(name=="logOut"){
                        window.location.href="${ctx}/login.jsp";
                    }
                    else{
                        alert(name)
                    }
                },
                unLock(){
                    this.modalLock=false;
                }
            }
        });
    }
</script>
</html>