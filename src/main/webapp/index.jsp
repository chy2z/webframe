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
    <style>
        body{
            background-color: #f0f0f0;
        }

        .home-main{
            width: 100%;
            height: 100%;
            padding: 10px 10px;
        }

        .user-infor {
            height: 120px;
        }

        .avator-img {
            display: block;
            width: 80%;
            max-width: 100px;
            height: auto;
        }

        .card-user-infor-name {
            font-size: 2em;
            color: #2d8cf0;
        }

        .card-title {
            color: #abafbd;
        }

        .to-do-list-con {
            height: 160px;
            overflow: auto;
        }

        .infor-card-con {
            height: 100px;
        }

        .infor-card-icon-con {
            height: 100%;
            color: white;
            border-radius: 3px 0 0 3px;
        }

        .map-con {
            height: 305px;
        }

        .map-incon {
            height: 100%;
        }

        .data-source-row {
            height: 200px;
        }

        .line-chart-con {
            height: 150px;
        }

        .infor-card-icon-con {
            height: 100%;
        }

        .height-100 {
            height: 100%;
        }

        .infor-card-con {
            height: 100px;
        }

        .infor-intro-text {
            font-size: 12px;
            font-weight: 500;
            color: #C8C8C8;
        }

    </style>
</head>
<body>
<div class="my-app" id="app">
    <div class="home-main">
        <Row>
            <i-Col span="8">
                <Row>
                    <Card>
                        <Row type="flex" class="user-infor">
                            <i-Col span="8">
                                <Row class-name="made-child-con-middle" type="flex" align="middle">
                                    <img class="avator-img" src="../../images/lock.jpg"/>
                                </Row>
                            </i-Col>
                            <i-Col span="16" style="padding-left:6px;">
                                <Row class-name="made-child-con-middle" type="flex" align="middle">
                                    <div>
                                        <b class="card-user-infor-name">Admin</b>
                                        <p>super admin</p>
                                    </div>
                                </Row>
                            </i-Col>
                        </Row>
                        <div class="line-gray"></div>
                        <Row class="margin-top-8">
                            <i-Col span="8">
                                <p class="notwrap">上次登录时间:</p>
                            </i-Col>
                            <i-Col span="16" class="padding-left-8">
                                2017.09.12-13:32:20
                            </i-Col>
                        </Row>
                        <Row class="margin-top-8">
                            <i-Col span="8">
                                <p class="notwrap">上次登录地点:</p>
                            </i-Col>
                            <i-Col span="16" class="padding-left-8">
                                北京</i-Col>
                        </Row>
                    </Card>
                </Row>
                <Row class="margin-top-10">
                    <Card>
                        <p slot="title" class="card-title">
                            <Icon type="android-checkbox-outline"></Icon>
                            待办事项
                        </p>
                        <a type="text" slot="extra">
                            <Icon type="plus-round"></Icon>
                        </a>
                        <div class="to-do-list-con">

                        </div>
                    </Card>
                </Row>
            </i-Col>
            <i-Col span="16" class-name="padding-left-10">
                <Row>
                    <i-Col span="6">
                        <Card :padding="0">
                            <div class="infor-card-con">
                                <i-Col class="infor-card-icon-con" style="background-color: #2d8cf0;color:white;" span="8">
                                    <Row class="height-100" type="flex" align="middle" justify="center">
                                        <Icon type="android-person-add" :size="40"></Icon>
                                    </Row>
                                </i-Col>
                                <i-Col span="16" class="height-100">
                                    <Row type="flex" align="middle" justify="center" class="height-100">
                                        <div class="infor-card-count user-created-count">
                                            <p style="text-align: center; color:#2d8cf0; font-size: 30px; font-weight: 700;">
                                                <span>496</span><span></span>
                                            </p>
                                            <p class="infor-intro-text" slot="intro">今日新增</p>
                                        </div>
                                    </Row>
                                </i-Col>
                            </div>
                        </Card>
                    </i-Col>
                    <i-Col span="6" class-name="padding-left-10">
                        <Card :padding="0">
                            <div class="infor-card-con">
                                <i-Col class="infor-card-icon-con" style="background-color: #64d572;color:white;" span="8">
                                    <Row class="height-100" type="flex" align="middle" justify="center">
                                        <Icon type="ios-eye" size="50"></Icon>
                                    </Row>
                                </i-Col>
                                <i-Col span="16" class="height-100">
                                    <Row type="flex" align="middle" justify="center" class="height-100">
                                        <div class="infor-card-count user-created-count">
                                            <p style="text-align: center; color:#64d572; font-size: 30px; font-weight: 700;">
                                                <span>50</span><span></span>
                                            </p>
                                            <p class="infor-intro-text" slot="intro">今日浏览量</p>
                                        </div>
                                    </Row>
                                </i-Col>
                            </div>
                        </Card>
                    </i-Col>
                    <i-Col span="6" class-name="padding-left-10">
                        <Card :padding="0">
                            <div class="infor-card-con">
                                <i-Col class="infor-card-icon-con" style="background-color: #ffd572; color: white;" span="8">
                                    <Row class="height-100" type="flex" align="middle" justify="center">
                                        <Icon type="upload" size="40"></Icon>
                                    </Row>
                                </i-Col>
                                <i-Col span="16" class="height-100">
                                    <Row type="flex" align="middle" justify="center" class="height-100">
                                        <div class="infor-card-count user-created-count">
                                            <p style="text-align: center; color:#ffd572; font-size: 30px; font-weight: 700;">
                                                <span>24M+</span><span></span>
                                            </p>
                                            <p class="infor-intro-text" slot="intro">今日数据采集量</p>
                                        </div>
                                    </Row>
                                </i-Col>
                            </div>
                        </Card>
                    </i-Col>
                    <i-Col span="6" class-name="padding-left-10">
                        <Card :padding="0">
                            <div class="infor-card-con">
                                <i-Col class="infor-card-icon-con" style="background-color: #f25e43;color: white;" span="8">
                                    <Row class="height-100" type="flex" align="middle" justify="center">
                                        <Icon type="shuffle" size="40"></Icon>
                                    </Row>
                                </i-Col>
                                <i-Col span="16" class="height-100">
                                    <Row type="flex" align="middle" justify="center" class="height-100">
                                        <div class="infor-card-count user-created-count">
                                            <p style="text-align: center; color:#f25e43; font-size: 30px; font-weight: 700;">
                                                <span >50</span><span></span>
                                            </p>
                                            <p class="infor-intro-text" slot="intro">今日服务调用量</p>
                                        </div>
                                    </Row>
                                </i-Col>
                            </div>
                        </Card>
                    </i-Col>
                </Row>
                <Row class="margin-top-10">
                    <Card :padding="0">
                        <p slot="title" class="card-title">
                            <Icon type="map"></Icon>
                            今日服务调用地理分布
                        </p>
                        <div class="map-con">
                            <Col span="10">
                            </Col>
                            <Col span="14" class="map-incon">
                            <Row type="flex" justify="center" align="middle">

                            </Row>
                            </Col>
                        </div>
                    </Card>
                </Row>
            </i-Col>
        </Row>
        <Row class="margin-top-10">
            <i-Col span="8">
                <Card>
                    <p slot="title" class="card-title">
                        <Icon type="android-map"></Icon>
                        上周每日来访量统计
                    </p>
                    <div class="data-source-row">

                    </div>
                </Card>
            </i-Col>
            <i-Col span="8" class="padding-left-10">
                <Card>
                    <p slot="title" class="card-title">
                        <Icon type="ios-pulse-strong"></Icon>
                        数据来源统计
                    </p>
                    <div class="data-source-row">

                    </div>
                </Card>
            </i-Col>
            <i-Col span="8" class="padding-left-10">
                <Card>
                    <p slot="title" class="card-title">
                        <Icon type="android-wifi"></Icon>
                        各类用户服务调用变化统计
                    </p>
                    <div class="data-source-row">

                    </div>
                </Card>
            </i-Col>
        </Row>
        <Row class="margin-top-10">
            <Card>
                <p slot="title" class="card-title">
                    <Icon type="ios-shuffle-strong"></Icon>
                    上周每日服务调用量(万)
                </p>
                <div class="line-chart-con">

                </div>
            </Card>
        </Row>
    </div>
</div>
</body>
<script>
    new Vue({
        el: '#app',
        data: {},
        methods: {},
        mounted() {

        }
    });
</script>
</html>