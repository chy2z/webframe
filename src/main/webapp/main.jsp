<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="taglib/taglibs.jsp"%>
<%@ include file="taglib/import_iview.jsp"%>
<%@ include file="taglib/import_jquery.jsp"%>
<%@ include file="taglib/import_common.jsp"%>
<html>
<head>
    <title>主页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <link rel="stylesheet" href="${ctx}/css/lock/unlock.css">
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
            background-color:#2d8cf0;
        }

        .head-content{
            height:100%;
            width: 95%;
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
            line-height: 30px;
            margin: 25px 0;
            border-radius: 3px;
            text-align: center;
            color:#fff;
        }

        .head-right-avatar {
            float: right;
            height:100%;
            margin: 20px 0;
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

        /* 兼容获取浏览器，下拉菜单宽度不够 */
        .head-right-menu .ivu-menu-horizontal .ivu-menu-submenu .ivu-select-dropdown{
            width: auto;
            max-height: none;
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

        /*
        .ivu-col {
            transition: width .2s ease-in-out;
        }
        */

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

        /*左侧菜单选中白色
        .ivu-menu-dark.ivu-menu-vertical .ivu-menu-item-active:not(.ivu-menu-submenu), .ivu-menu-dark.ivu-menu-vertical .ivu-menu-submenu-title-active:not(.ivu-menu-submenu) {
            color: #fff;
            border-right: 2px solid #fff;
        }
        */



    </style>
</head>
<body>
<div id="app">
    <!-- lock动画 -->
    <div class="lock-screen-back" id="lock_screen_back"></div>
    <!-- lock组件 -->
    <div class="lockmain" :class="{'lockmain-hide': hideText}">
        <div style="width: 100%;height: 100%;background: #667aa6">
            <div class="unlock-con">
                <!-- camelCase (驼峰式命名) prop 需要转换为相对应的 kebab-case  -->
                <unlock :show-unlock="showUnlock" :tip-lock="tipLock" @on-unlock="unlockScreen"></unlock>
            </div>
        </div>
    </div>
    <!-- top -->
    <div class="head">
        <div class="head-content">
            <div class="head-logo-left-logo">
                <img src="../../images/logo.png" >
            </div>
            <div class="head-logo-left-title">后台管理系统</div>
            <div class="head-right-avatar">
                <Avatar icon="person" size="large" src="https://i.loli.net/2017/08/21/599a521472424.jpg" />
            </div>
            <div class="head-right-menu">
                <i-Menu @on-select="headMenuItemClick" width="auto" mode="horizontal" theme="primary" active-name="userinfo">
                     <Submenu name="menuOperate">
                        <template slot="title">
                            <Icon type="android-menu"></Icon>
                            菜单管理
                        </template>
                         <Menu-Item name="toggleMenu">
                             <Icon type="arrow-swap"></Icon>
                             折叠菜单
                         </Menu-Item>
                         <Menu-Item name="closeMenu">
                             <Icon type="close"></Icon>
                             关闭菜单
                         </Menu-Item>
                         <Menu-Item name="refreshHome">
                             <Icon type="refresh"></Icon>
                             刷新首页
                         </Menu-Item>
                    </Submenu>
                    <Menu-Item name="fullscreen">
                        <Icon type="arrow-expand"></Icon>
                        系统全屏
                    </Menu-Item>
                    <Menu-Item name="editPwd">
                        <Icon type="key"></Icon>
                        修改密码
                    </Menu-Item>
                    <Menu-Item name="lockSystem">
                        <Icon type="locked"></Icon>
                        系统锁屏
                    </Menu-Item>
                    <Menu-Item name="logOut">
                        <Icon type="power"></Icon>
                        退出系统
                    </Menu-Item>
                    <Submenu name="userinfo">
                        <template slot="title">
                            <Icon type="person"></Icon>
                            用户信息
                        </template>
                        <Menu-Group title="个人信息">
                            <Menu-Item name="3-1"><Icon type="card"></Icon><Tooltip placement="top" content="姓名">${requestScope.user.name}</Tooltip></Menu-Item>
                            <Menu-Item name="3-2"><Icon type="ios-flag"></Icon><Tooltip placement="top" content="部门">${requestScope.depart}</Tooltip></Menu-Item>
                            <Menu-Item name="3-3"><Icon type="trophy"></Icon><Tooltip placement="top" content="职位">${requestScope.user.office}</Tooltip></Menu-Item>
                            <Menu-Item name="3-4"><Icon type="ios-telephone"></Icon><Tooltip placement="top" content="电话">${requestScope.user.phone}</Tooltip></Menu-Item>
                            <Menu-Item name="3-5"><Icon type="email"></Icon><Tooltip placement="top" content="邮件">${requestScope.user.email}</Tooltip></Menu-Item>
                            <Menu-Item name="3-6"><Icon type="ribbon-b"></Icon><Tooltip placement="top" content="角色">${requestScope.role}</Tooltip></Menu-Item>
                        </Menu-Group>
                    </Submenu>
                </i-Menu>
                <Modal v-model="formModal.modalShow" :closable="false" :mask-closable="false" :styles="{top: '250px'}" width="400">
                    <p slot="header" style="color:#f60;text-align:center">
                        <Icon type="information-circled"></Icon>
                        <span>修改密码</span>
                    </p>
                    <div style="text-align:center">
                        <i-Form ref="formModal.bindModel" :model="formModal.bindModel" :rules="formModal.ruleValidate" label-position="left" label-width="70"  >
                            <Form-Item label="旧的密码" prop="oldPwd">
                                <i-Input v-model="formModal.bindModel.oldPwd" type="password" autocomplete="off" maxlength="25" placeholder="请输入原密码">
                                    <Icon type="ios-locked" slot="prepend"></Icon>
                                </i-Input>
                            </Form-Item>
                            <Form-Item label="新的密码" prop="newPwd">
                                <i-Input v-model="formModal.bindModel.newPwd" type="password" autocomplete="off" maxlength="25" placeholder="请输入新密码">
                                    <Icon type="ios-locked-outline" slot="prepend"></Icon>
                                </i-Input>
                            </Form-Item>
                            <Form-Item label="确认密码" prop="newPwdSecond">
                                <i-Input v-model="formModal.bindModel.newPwdSecond" type="password" autocomplete="off" maxlength="25" placeholder="请输入确认密码">
                                    <Icon type="ios-locked-outline" slot="prepend"></Icon>
                                </i-Input>
                            </Form-Item>
                        </i-Form>
                    </div>
                    <div slot="footer">
                        <i-Button type="text" size="large"   @click="modalEditPwdCancel">取消</i-Button>
                        <i-Button type="error" size="large"   @click="modalEditPwdOk">确定</i-Button>
                    </div>
                </Modal>
            </div>
        </div>
    </div>
    <!-- body -->
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
        var domain="${ctx}";
        var unLock_url=domain+"/login/unLock/${requestScope.jwt}";
        var editPwd_url=domain+"/login/editPwd/${requestScope.jwt}";

        // 注册锁屏组件
        Vue.component('unlock', {
            name: 'Unlock',
            template: `
             <transition name="show-unlock">
             <div class="unlock-body-con" v-if="showUnlock" @keydown.enter="handleUnlock">
                <div @click="handleClickAvator" class="unlock-avator-con" :style="{marginLeft: avatorLeft}">
                    <img class="unlock-avator-img" :src="avatorPath">
                    <div  class="unlock-avator-cover">
                        <span><Icon type="unlocked" :size="30"></Icon></span>
                        <p>解锁</p>
                    </div>
                </div>
                <div class="unlock-avator-under-back" :style="{marginLeft: avatorLeft}"></div>
                <div class="unlock-input-con">
                    <div class="unlock-input-overflow-con">
                        <div class="unlock-overflow-body" :style="{right: inputLeft}">
                            <input ref="inputEle"  @on-keyup="unlockKeyup" autocomplete="off" maxlength="25" v-model="password" class="unlock-input" type="password" placeholder="密码同登录密码" />
                            <button ref="unlockBtn" @mousedown="unlockMousedown" @mouseup="unlockMouseup" @click="handleUnlock" class="unlock-btn"><Icon color="white" type="key"></Icon></button>
                        </div>
                    </div>
                </div>
                <div class="unlock-locking-tip-con">{{ tipLock }} 已锁定</div>
            </div>
        </transition>
         `,
            data () {
                return {
                    avatorLeft: '0px',
                    inputLeft: '400px',
                    password: ''
                };
            },
            props: {
                showUnlock: {
                    type: Boolean,
                    default: false
                },
                tipLock: {
                    type: String,
                    default: ""
                }
            },
            computed: {
                avatorPath () {
                    return localStorage.avatorImgPath;
                }
            },
            methods: {
                handleClickAvator () {
                    this.avatorLeft = '-180px';
                    this.inputLeft = '0px';
                    this.$refs.inputEle.focus();
                },
                unlockKeyup(){
                  this.handleUnlock();
                },
                handleUnlock () {
                    if(this.password==""){
                        this.$Message.error('请输入密码');
                        return;
                    }
                    if(this.password.length<6){
                        this.$Message.error('密码长度不够6位');
                        return;
                    }
                    let data = {pwd:this.password};
                    vajaxPost(unLock_url,data,false,(result)=>{
                        if(result&&result.success){
                            this.avatorLeft = '0px';
                            this.inputLeft = '400px';
                            this.password = '';
                            this.$emit('on-unlock');
                            this.$Message.info(result.tip);
                        }
                        else{
                            this.$Message.error(result.tip);
                        }
                    });
                },
                unlockMousedown () {
                    this.$refs.unlockBtn.className = 'unlock-btn click-unlock-btn';
                },
                unlockMouseup () {
                    this.$refs.unlockBtn.className = 'unlock-btn';
                }
            }
        });

        new Vue({
            el: '#app',
            data:{
                jwt:"${requestScope.jwt}",
                menus:${requestScope.menu},
                showUnlock: false,
                tipLock:"系统",
                lockScreenSize: 0,
                hideText:true,
                isFullScreen:false,
                tabSelected:"mainframe",
                spanLeft: 3,
                spanRight: 21,
                tabItems:[],
                formModal:{
                    modalShow:false,
                    bindModel:{
                        oldPwd:"",
                        newPwd:"",
                        newPwdSecond:""
                    },
                    ruleValidate:{
                        oldPwd: [
                            { required: true, message: '旧密码不能为空', trigger: 'blur' },
                            {type: 'string', min: 6, message: '密码不能少于6字', trigger: 'blur'}
                        ],
                        newPwd: [
                            { required: true, message: '新密码不能为空', trigger: 'blur' },
                            {type: 'string', min: 6, message: '密码不能少于6字', trigger: 'blur'}
                        ],
                        newPwdSecond: [
                            { required: true, message: '确认密码不能为空', trigger: 'blur' },
                            {type: 'string', min: 6, message: '密码不能少于6字', trigger: 'blur'}
                        ]
                    }
                }
            },
            created:function(){
                vSpin(this);
                document.querySelector("#mainframe").src="${ctx}/login/index/${requestScope.jwt}";
                localStorage.avatorImgPath="${ctx}/images/lock.jpg";
            },
            mounted () {
                // 锁屏相关
                let lockScreenBack = document.getElementById('lock_screen_back');
                let x = document.body.clientWidth;
                let y = document.body.clientHeight;
                let r = Math.sqrt(x * x + y * y);
                let size = parseInt(r);
                this.lockScreenSize = size;
                window.addEventListener('resize', () => {
                    let x = document.body.clientWidth;
                    let y = document.body.clientHeight;
                    let r = Math.sqrt(x * x + y * y);
                    let size = parseInt(r);
                    this.lockScreenSize = size;
                    lockScreenBack.style.transition = 'all 0s';
                    lockScreenBack.style.width = lockScreenBack.style.height = size + 'px';
                });
                lockScreenBack.style.width = lockScreenBack.style.height = size + 'px';

                //解决浏览器刷新锁屏消失
                if(localStorage.islock==1){
                    this.lockScreen();
                }
            },
            computed: {
                iconSize () {
                    return this.spanLeft === 3 ? 10 : 24;
                }
            },
            methods: {
                unlockScreen () {

                    localStorage.islock=0;

                    let lockScreenBack = document.getElementById('lock_screen_back');
                    this.showUnlock = false;
                    this.hideText=true;
                    lockScreenBack.style.zIndex = -1;
                    lockScreenBack.style.boxShadow = '0 0 0 0 #667aa6 inset';
                },
                lockScreen () {

                    localStorage.islock=1;

                    let lockScreenBack = document.getElementById('lock_screen_back');
                    lockScreenBack.style.transition = 'all 3s';
                    lockScreenBack.style.zIndex = 10000;
                    lockScreenBack.style.boxShadow = '0 0 0 ' + this.lockScreenSize + 'px #667aa6 inset';
                    this.showUnlock = true;
                    setTimeout(() => {
                        this.hideText=false;
                        lockScreenBack.style.transition = 'all 0s';
                        lockScreenBack.style.zIndex = -1;
                    }, 800);
                },
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
                    //关闭菜单
                    else if(name=="closeMenu"){
                        this.tabItems=[];
                    }
                    //刷新首页
                    else if(name=="refreshHome"){
                        vSpin(this);
                        document.querySelector("#mainframe").contentWindow.location.reload(true);
                    }
                    //锁屏
                    else if(name=="lockSystem"){
                        this.lockScreen();
                    }
                    //退出登录
                    else if(name=="logOut"){
                        window.location.href="${ctx}/login.jsp";
                    }
                    //编辑密码
                    else if(name=="editPwd"){
                        this.formModal.modalShow=true;
                        this.$refs['formModal.bindModel'].resetFields();
                    }
                    else if(name=="fullscreen"){
                        let main = document.body;
                        if (this.isFullScreen) {
                            if (document.exitFullscreen) {
                                document.exitFullscreen();
                            } else if (document.mozCancelFullScreen) {
                                document.mozCancelFullScreen();
                            } else if (document.webkitCancelFullScreen) {
                                document.webkitCancelFullScreen();
                            } else if (document.msExitFullscreen) {
                                document.msExitFullscreen();
                            }
                        } else {
                            if (main.requestFullscreen) {
                                main.requestFullscreen();
                            } else if (main.mozRequestFullScreen) {
                                main.mozRequestFullScreen();
                            } else if (main.webkitRequestFullScreen) {
                                main.webkitRequestFullScreen();
                            } else if (main.msRequestFullscreen) {
                                main.msRequestFullscreen();
                            }
                        }
                        this.isFullScreen = !this.isFullScreen;
                    }
                    else{

                    }
                },
                modalEditPwdCancel(){
                    this.formModal.modalShow=false;
                },
                modalEditPwdOk(){
                    this.$refs['formModal.bindModel'].validate((valid) => {
                        if (valid) {
                            if(this.formModal.bindModel.newPwd!=this.formModal.bindModel.newPwdSecond){
                                valert(this,"新的密码和确认密码不一样");
                                return;
                            }
                            let data = this.formModal.bindModel;
                            vajaxPost(editPwd_url,data,false,(result)=>{
                                if(result&&result.success){
                                    this.formModal.modalShow=false;
                                    vtoast(this,result.tip);
                                }
                                else{
                                    valert(this,result.tip);
                                }
                            });
                        }
                        else{
                            valert(this,'表单验证失败!');
                        }
                    });
                }
            }
        });

</script>
</html>