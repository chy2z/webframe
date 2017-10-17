<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />   
<title>主页</title>
<%@ include file="importIview.jsp"%>
<style>
    html,body{
       width:100%;
       height:100%;
       margin:0;padding:0;
    }
    #app{
        height:100%;
    }
    .layout{
        height:100%;
        border: 1px solid #d7dde4;
        background: #f5f7f9;
        position: relative;
        border-radius: 4px;
        overflow: hidden;
    }
    .layoutRow{
        height:100%;
    }    
    .layout-breadcrumb{
        padding: 10px 15px 10px;
    }
    .layout-content{
        min-height: 400px;
        margin: 0px;
        padding: 10px;
        overflow: hidden;
        background: #fff;
        border-radius: 4px;       
    }
    .layout-content-main{
        padding: 10px;
    }
    .layout-copy{       
        text-align: center;
        padding: 15px 0 15px;
        color: #9ea7b4;
    }
    .layout-menu-left{       
        background: #464c5b;
    }
    .layout-header{
        height: 60px;
        background: #fff;
        box-shadow: 0 1px 1px rgba(0,0,0,.1);
    }
    .layout-logo-left{
        width: 90%;
        height: 30px;
        font-size:32px;
        line-height:30px;
        background: #464c5b;
        border-radius: 3px;
        margin: 15px auto;
        text-align: center;
        color: white;   
    }
    .layout-ceiling-main a{
        color: #9ba7b5;
    }
    .layout-hide-text .layout-text{
        display: none;
    }
    .ivu-col{
        transition: width .2s ease-in-out;
    }
</style>
</head>
<body>
<div id="app">
   <div class="layout" :class="{'layout-hide-text': spanLeft < 3}">
        <Row class-name="layoutRow" type="flex">
            <i-col :span="spanLeft" class="layout-menu-left">
                <i-menu active-name="1" theme="dark" width="auto">
                    <div class="layout-logo-left">运营平台</div>
                    <menu-Item name="1">
                        <Icon type="ios-navigate" :size="iconSize"></Icon>
                        <span class="layout-text">选项 1</span>
                    </menu-Item>
                    <menu-Item name="2">
                        <Icon type="ios-keypad" :size="iconSize"></Icon>
                        <span class="layout-text">选项 2</span>
                    </menu-Item>
                    <menu-Item name="3">
                        <Icon type="ios-analytics" :size="iconSize"></Icon>
                        <span class="layout-text">选项 3</span>
                    </menu-Item>
                </i-menu>
            </i-col>
            <i-col :span="spanRight">
                <div class="layout-header">
                    <i-Button type="text" @click="toggleClick">
                        <Icon type="navicon" size="32"></Icon>
                    </i-Button>
                </div>
                <div class="layout-breadcrumb">
                    <Breadcrumb>
                        <BreadcrumbItem href="#">首页 / </BreadcrumbItem>
                        <BreadcrumbItem href="#">应用中心 / </BreadcrumbItem>
                        <BreadcrumbItem>某应用</BreadcrumbItem>
                    </Breadcrumb>
                </div>
                <div class="layout-content">
                    <div class="layout-content-main">内容区域</div>
                </div>
                <div class="layout-copy">
                    2011-2016 &copy; TalkingData
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
             spanRight: 20
        },
        created:function(){             	
        	//计算剩余高度
        	var h=document.body.clientHeight-60-41-48; 
        	document.querySelector(".layout-content").style.height=h+"px"; 
        },
        computed: {
            iconSize () {
                return this.spanLeft === 3 ? 10 : 24;
            }
        },
        methods: {
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