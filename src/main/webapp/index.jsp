<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="taglib/taglibs.jsp" %>
<%@ include file="taglib/import_iview.jsp" %>
<%@ include file="taglib/import_jquery.jsp" %>
<%@ include file="taglib/import_common.jsp" %>
<%@ include file="taglib/import_echarts.jsp" %>
<html>
<head>
    <title>首页</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <script type="text/javascript" src="${ctx}/js/echarts/geoMap.js?v=${requestScope.jwt}"></script>
    <script type="text/javascript" src="${ctx}/js/echarts/china.js?v=${requestScope.jwt}"></script>
    <link rel="stylesheet" href="${ctx}/css/index/index.css?v=${requestScope.jwt}">
</head>
<body>
<div class="my-app" id="app">
    <div class="home-main">
        <Row>
            <i-Col span="8">
                <Row>
                    <Card>
                        <Row type="flex" class="user-infor">
                            <i-Col span="6">
                                <Row class-name="made-child-con-middle" type="flex" align="middle">
                                    <img class="avator-img" src="${ctx}/${requestScope.user.img}"/>
                                </Row>
                            </i-Col>
                            <i-Col span="18" style="padding-left:6px;">
                                <Row class-name="made-child-con-middle" type="flex" align="middle">
                                    <i-Col span="24">
                                        <Tooltip placement="left" :transfer="true" content="姓名">
                                        <b class="card-user-infor-name">${requestScope.user.name}</b>
                                       </Tooltip>
                                    </i-Col>
                                </Row>
                                <Row class-name="made-child-con-middle" type="flex" align="middle">
                                    <i-Col span="12">
                                        <div>
                                            <p>
                                                <Tooltip placement="left" :transfer="true" content="登录名">
                                                    <Icon type="person"></Icon>
                                                    <span>${requestScope.user.loginname}</span>
                                                </Tooltip>
                                            </p>
                                            <p>
                                                <Tooltip placement="left" :transfer="true" content="部门">
                                                    <Icon type="ios-people"></Icon>
                                                    <span>${requestScope.user.departName}</span>
                                                </Tooltip>
                                            </p>
                                            <p>
                                                <Tooltip placement="left" :transfer="true" content="电话">
                                                    <Icon type="ios-telephone"></Icon>
                                                    <span>${requestScope.user.phone}</span>
                                                </Tooltip>
                                            </p>
                                        </div>
                                    </i-Col>
                                    <i-Col span="12">
                                        <div>
                                            <p>
                                                <Tooltip placement="left" :transfer="true" content="角色">
                                                    <Icon type="ribbon-b"></Icon>
                                                    <span>${requestScope.user.roleName}</span></Tooltip>
                                            </p>
                                            <p>
                                                <Tooltip placement="left" :transfer="true" content="职务">
                                                    <Icon type="trophy"></Icon>
                                                    <span>${requestScope.user.office}</span>
                                                </Tooltip>
                                            </p>
                                            <p>
                                                <Tooltip placement="left" :transfer="true" content="邮箱">
                                                    <Icon type="email"></Icon>
                                                    <span>${requestScope.user.email}</span>
                                                </Tooltip>
                                            </p>
                                        </div>
                                    </i-Col>
                                </Row>

                            </i-Col>
                        </Row>
                        <div class="line-gray"></div>
                        <Row class="margin-top-8">
                            <i-Col span="6">
                                <p class="notwrap">上次登录信息</p>
                            </i-Col>
                            <i-Col span="9" class="padding-left-8">
                                ${requestScope.loginDateLast}
                            </i-Col>
                            <i-Col span="9" class="padding-left-8">
                                ${requestScope.geoLast}
                            </i-Col>
                        </Row>
                        <Row class="margin-top-8">
                            <i-Col span="6">
                                <p class="notwrap">本次登录信息</p>
                            </i-Col>
                            <i-Col span="9" class="padding-left-8">
                                ${requestScope.loginDate}</i-Col>
                            <i-Col span="9" class="padding-left-8">
                                ${requestScope.geo}</i-Col>
                        </Row>
                    </Card>
                </Row>
                <Row class="margin-top-10">
                    <Card>
                        <p slot="title" class="card-title">
                            <Icon type="android-checkbox-outline"></Icon>
                            系统通知
                        </p>
                        <a type="text" slot="extra">
                            <Tooltip placement="top" content="刷新">
                            <Icon @click.native="refreshNotices" type="refresh"></Icon>
                            </Tooltip>
                        </a>
                        <div  class="to-do-list-con">
                            <div v-for="(item, index) in notices" :key="index" class="to-do-item">
                            <template>
                                <Row type="flex" justify="start" align="middle" class="to-do-list-item">
                                    <i-Col span="1" class="height-100">
                                        <Row type="flex" justify="start" align="middle" class="height-100">
                                            <Icon type="android-notifications"></Icon>
                                        </Row>
                                    </i-Col>
                                    <i-Col span="18" class="height-100">
                                        <Row type="flex" justify="start" align="middle" class="height-100">
                                            <p @click="handleNotice(item.id)" class="to-do-list-item-text">
                                                <%--<Tooltip placement="top-start" :transfer="tipTransfer" :content="item.title"></Tooltip>--%>
                                                <a href="#">{{ item.title }}</a>
                                            </p>
                                        </Row>
                                    </i-Col>
                                    <i-Col span="5" class="height-100">
                                        <Row type="flex" justify="start" align="middle" class="height-100">
                                            <p class="to-do-list-item-text">{{ item.createtime }}</p>
                                        </Row>
                                    </i-Col>
                                </Row>
                            </template>
                            </div>
                        </div>
                    </Card>
                    <Spin size="large" fix v-if="spinShowNotices"></Spin>
                </Row>
            </i-Col>
            <i-Col span="16" class-name="padding-left-10">
                <Row>
                    <template v-for = "infor in infoBoard">
                        <i-Col :span="infor.colspan" :class-name="infor.className">
                            <Card :padding="0">
                                <div class="infor-card-con">
                                    <i-Col class="infor-card-icon-con" :style="{backgroundColor:infor.color,color:'white'}" span="8">
                                        <Row class="height-100" type="flex" align="middle" justify="center">
                                            <Icon :type="infor.icon" :size="infor.iconSize"></Icon>
                                        </Row>
                                    </i-Col>
                                    <i-Col span="16" class="height-100">
                                        <Row type="flex" align="middle" justify="center" class="height-100">
                                            <div class="infor-card-count user-created-count">
                                                <p :style="{textAlign: 'center', color:infor.color, fontSize: '30px', fontWeight: '700'}">
                                                    <span>{{infor.content}}</span><span></span>
                                                </p>
                                                <p class="infor-intro-text" slot="intro">{{infor.title}}</p>
                                            </div>
                                        </Row>
                                    </i-Col>
                                </div>
                            </Card>
                        </i-Col>
                    </template>
                </Row>
                <Row class="margin-top-10">
                    <Card :padding="0">
                        <p slot="title" class="card-title">
                            <Icon type="map"></Icon>
                            用户登录地图
                        </p>
                        <div class="map-con">
                            <i-Col span="10" class="map-incon">
                                <div class="map-incon-left" id="mapdata">
                                    <i-Table :height="tableHeight" :columns="columns" :data="cityData"></i-Table>
                                </div>
                            </i-Col>
                            <i-Col span="14" class="map-incon">
                                <div class="map-incon-right" id="chinaMap">

                                </div>
                            </i-Col>
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
                        水平柱状图
                    </p>
                    <div id="chart1" class="bar-chart-con">

                    </div>
                </Card>
            </i-Col>
            <i-Col span="8" class="padding-left-10">
                <Card>
                    <p slot="title" class="card-title">
                        <Icon type="ios-pulse-strong"></Icon>
                        垂直柱状图
                    </p>
                    <div id="chart2" class="bar-chart-con">

                    </div>
                </Card>
            </i-Col>
            <i-Col span="8" class="padding-left-10">
                <Card>
                    <p slot="title" class="card-title">
                        <Icon type="android-wifi"></Icon>
                        堆叠条形图
                    </p>
                    <div id="chart3" class="bar-chart-con">

                    </div>
                </Card>
            </i-Col>
        </Row>
        <Row class="margin-top-10">
            <Card>
                <p slot="title" class="card-title">
                    <Icon type="ios-shuffle-strong"></Icon>
                    堆叠区域图
                </p>
                <div id="chart5" class="line-chart-con">

                </div>
            </Card>
        </Row>
        <Row class="margin-top-10">
            <i-Col span="8">
                <Card>
                    <p slot="title" class="card-title">
                        <Icon type="android-map"></Icon>
                        饼形图
                    </p>
                    <div id="chart6" class="bar-chart-con">

                    </div>
                </Card>
            </i-Col>
            <i-Col span="8" class="padding-left-10">
                <Card>
                    <p slot="title" class="card-title">
                        <Icon type="ios-pulse-strong"></Icon>
                        仪表盘
                    </p>
                    <div id="chart7" class="bar-chart-con">

                    </div>
                </Card>
            </i-Col>
            <i-Col span="8" class="padding-left-10">
                <Card>
                    <p slot="title" class="card-title">
                        <Icon type="android-wifi"></Icon>
                        折线图
                    </p>
                    <div id="chart8" class="bar-chart-con">

                    </div>
                </Card>
            </i-Col>
        </Row>
    </div>
</div>
</body>
<script>
    var domain="${ctx}";

    var app=new Vue({
        el: '#app',
        data: {
            tipTransfer:true,
            spinShowNotices:false,
            tableHeight:281,
            columns: [
                {
                    title: '城市',
                    key: 'name'
                },
                {
                    title: '次数',
                    key: 'value',
                    sortable: true
                }
            ],
            cityData:[],
            notices:[],
            infoBoard:[
                {colspan:6,className:"padding-left-0",title:"今日用户新增",content:"496",icon:"android-person-add",iconSize:40,color:"#2d8cf0"},
                {colspan:6,className:"padding-left-10",title:"今日浏览量",content:"50",icon:"ios-eye",iconSize:40,color:"#64d572"},
                {colspan:6,className:"padding-left-10",title:"今日数据采集量",content:"24M+",icon:"upload",iconSize:40,color:"#ffd572"},
                {colspan:6,className:"padding-left-10",title:"今日服务调用量",content:"2000",icon:"shuffle",iconSize:40,color:"#f25e43"}
            ]
        },
        methods: {
            handleNotice(id){
                var noticeLook_url=domain+"/sysNotice/path/look?jwt=${requestScope.jwt}";
                vPopWindowShow("action_look",noticeLook_url+"&id="+id,"系统通知查看");
            },
            refreshNotices(){
                let url = domain + "/sysNotice/topNewest?jwt=${requestScope.jwt}";
                vajaxPost(url,{top:5},false,(result)=>{
                    if(result.success) {
                        this.notices = result.data;
                    }
                    else{
                        vtoast(this,"网络不给力～，最新消息努力加载中..");
                    }
                },()=>{
                     this.spinShowNotices=true;
                },()=>{
                    vDelay(1000,null,()=>{
                        this.spinShowNotices=false;
                    },null);
                });
            }
        },
        mounted() {
            this.refreshNotices();
            CreateCityMap();
            CreateChart1();
            CreateChart2();
            CreateChart3();
            CreateChart5();
            CreateChart6();
            CreateChart7();
            CreateChart8();
        }
    });

    function CreateCityMap() {

        let url="${ctx}/chart/getLoginAllUserLastNYears/Geo?jwt=${requestScope.jwt}";

        var map = echarts.init(document.getElementById('chinaMap'));

        vajaxPost(url,{},false,(result)=>{
            /**
             [
               {name: '芜湖', value: 20},
               {name: '马鞍山', value: 200}
             ]
             */
            let cityData=eval("("+result+")");

            app.cityData=cityData;

            map.setOption({
                backgroundColor: '#FFF',
                visualMap: {
                    min: 0,
                    max: 200,
                    calculable: true,
                    left: 'right',
                    top: 'bottom',
                    text: ['高','低'],
                    inRange: {
                        color: ['#50a3ba', '#eac736', '#d94e5d']
                    },
                    textStyle: {
                        color: '#606461'
                    }
                },
                geo: {
                    map: 'china',
                    label: {
                        emphasis: {
                            show: false
                        }
                    },
                    itemStyle: {
                        normal: {
                            areaColor: '#EFEFEF',
                            borderColor: '#CCC'
                        },
                        emphasis: {
                            areaColor: '#E5E5E5'
                        }
                    }
                },
                grid: {
                    top: 0,
                    left: '2%',
                    right: '2%',
                    bottom: '0',
                    containLabel: true
                },
                series: [{
                    type: 'scatter',
                    coordinateSystem: 'geo',
                    data: convertMapData(cityData),
                    symbolSize: function (val) {
                        return val[2] / 10;
                    },
                    label: {
                        normal: {
                            formatter: '{b}',
                            position: 'right',
                            show: false
                        },
                        emphasis: {
                            show: true
                        }
                    },
                    itemStyle: {
                        normal: {
                            color: '#0099CC'
                        }
                    }
                }]
            });
        });

        window.addEventListener('resize', function () {
            map.resize();
        });
    }

    function CreateChart1(){
        let url="${ctx}/chart/getLoginLogLastNYears/bar/horizontal?jwt=${requestScope.jwt}";
        var chart1 = echarts.init(document.getElementById('chart1'), 'shine');
        let option={
            title: {
                text: '',
                subtext: ''
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            //替换
            legend: {
                data: ['2011年（万）'],
                top: 2
            },
            grid: {
                top:'15%',
                left: '3%',
                right: '3%',
                bottom: '1%',
                containLabel: true
            },
            xAxis: {
                type: 'value',
                boundaryGap: [0, 0.01]
            },
            //替换
            yAxis: {
                type: 'category',
                data: ['项目1','项目2']
            },
            //替换
            series: [
                {
                    name: '2011年（万）',
                    type: 'bar',
                    data: [{value:0,label: {
                        normal: {
                            show: false,
                            position: 'insideRight'
                        }
                    }},{value:23489,label: {
                        normal: {
                            show: true,
                            position: 'insideRight'
                        }
                    }}]
                }
            ]
        };

        vajaxPost(url,{num:2},false,(result)=>{
            let opt=eval("("+result+")");
            option.legend=opt.legend;
            option.yAxis=opt.yAxis;
            option.series=opt.series;
            chart1.setOption(option);
        });

        window.addEventListener('resize', function () {
            chart1.resize();
        });
    }

    function CreateChart2(){
        let url="${ctx}/chart/getLoginLogLastNYears/bar/vertical?jwt=${requestScope.jwt}";
        var chart2 = echarts.init(document.getElementById('chart2'), 'shine');
        let option={
            tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            //替换
            legend: {
                data: ['直接访问', '间接访问'],
                top: 2
            },
            grid: {
                top:'15%',
                left: '3%',
                right: '3%',
                bottom: '1%',
                containLabel: true
            },
            //替换
            xAxis : [
                {
                    type : 'category',
                    data : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            //替换
            series : [
                {
                    name:'直接访问',
                    type:'bar',
                    data:[10, 52, 200, 334, 390, 330, 220]
                },
                {
                    name:'间接访问',
                    type:'bar',
                    data:[20, 62, 150, 300, 360, 300, 160]
                }
            ]
        };

        vajaxPost(url,{num:2},false,(result)=>{
            let opt=eval("("+result+")");
            option.legend=opt.legend;
            option.xAxis=opt.xAxis;
            option.series=opt.series;
            chart2.setOption(option);
        });

        window.addEventListener('resize', function () {
            chart2.resize();
        });
    }

    function CreateChart3(){
        var chart3 = echarts.init(document.getElementById('chart3'), 'shine');
        let url="${ctx}/chart/getLoginLogLastNYears/bar/stack?jwt=${requestScope.jwt}";
        let option= {
            tooltip : {
                trigger: 'axis',
                axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                    type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            //替换
            legend: {
                data: ['直接访问']
            },
            grid: {
                top:'15%',
                left: '3%',
                right: '3%',
                bottom: '1%',
                containLabel: true
            },
            xAxis:  {
                type: 'value'
            },
            //替换
            yAxis: {
                type: 'category',
                data: ['周一','周二','周三','周四','周五','周六','周日']
            },
            //替换
            series: [
                {
                    name: '直接访问',
                    type: 'bar',
                    stack: '总量',
                    label: {
                        normal: {
                            show: true,
                            position: 'insideRight'
                        }
                    },
                    data: [320, 302, 301, 334, 390, 330, 320]
                }
            ]
        };

        vajaxPost(url,{num:2},false,(result)=>{
            let opt=eval("("+result+")");
            option.legend=opt.legend;
            option.yAxis=opt.yAxis;
            option.series=opt.series;
            chart3.setOption(option);
        });

        window.addEventListener('resize', function () {
            chart3.resize();
        });
    }

    function CreateChart5(){
        var chart5 = echarts.init(document.getElementById('chart5'), 'shine');
        let url="${ctx}/chart/getLoginLogLastNYears/line/stack?jwt=${requestScope.jwt}";
        let option={
            title: {
                text: ''
            },
            tooltip : {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross',
                    label: {
                        backgroundColor: '#6a7985'
                    }
                }
            },
            legend: {
                data:['邮件营销','联盟广告']
            },
            toolbox: {
                feature: {
                    saveAsImage: {}
                }
            },
            grid: {
                top:'15%',
                left: '3%',
                right: '3%',
                bottom: '1%',
                containLabel: true
            },
            xAxis : [
                {
                    type : 'category',
                    boundaryGap : false,
                    data : ['周一','周二','周三','周四','周五','周六','周日']
                }
            ],
            yAxis : [
                {
                    type : 'value'
                }
            ],
            series : [
                {
                    name:'邮件营销',
                    type:'line',
                    stack: '总量',
                    areaStyle: {normal: {}},
                    data:[120, 132, 101, 134, 90, 230, 210]
                },
                {
                    name:'联盟广告',
                    type:'line',
                    stack: '总量',
                    areaStyle: {normal: {}},
                    data:[220, 182, 191, 234, 290, 330, 310]
                }
            ]
        };
        vajaxPost(url,{num:2},false,(result)=>{
            let opt=eval("("+result+")");
            option.legend=opt.legend;
            option.xAxis=opt.xAxis;
            option.series=opt.series;
            chart5.setOption(option);
        });
        window.addEventListener('resize', function () {
            chart5.resize();
        });
    }

    function CreateChart6(){
        var chart6 = echarts.init(document.getElementById('chart6'), 'shine');
        let url="${ctx}/chart/getLoginLogLastNYears/pie?jwt=${requestScope.jwt}";
        var option={
            title : {
                text: '',
                subtext: '',
                x:'center'
            },
            tooltip : {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                show:false,
                data: ['直接访问','邮件营销']
            },
            series : [
                {
                    name: '访问来源',
                    type: 'pie',
                    radius : '90%',
                    center: ['50%', '50%'],
                    data:[
                        {value:335, name:'直接访问'},
                        {value:310, name:'邮件营销'},
                    ],
                    itemStyle: {
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };
        vajaxPost(url,{num:2},false,(result)=>{
            let opt=eval("("+result+")");
            option.legend=opt.legend;
            option.xAxis=opt.xAxis;
            option.series=opt.series;
            chart6.setOption(option);
        });
        window.addEventListener('resize', function () {
            chart6.resize();
        });
    }

    function CreateChart7(){
        var chart7 = echarts.init(document.getElementById('chart7'), 'shine');
        let url="${ctx}/chart/getLoginLogLastNYears/gauge?jwt=${requestScope.jwt}";
        var option={
            tooltip : {
                formatter: "{a} <br/>{b} : {c}%"
            },
            series: [
                {
                    name: '业务指标',
                    type: 'gauge',
                    radius : '90%',
                    detail: {formatter:'{value}%'},
                    data: [{value: 80, name: '完成率'}]
                }
            ]
        };

        vajaxPost(url,{num:2},false,(result)=>{
            let opt=eval("("+result+")");
            option.series=opt.series;
            chart7.setOption(option);
        });

        window.addEventListener('resize', function () {
            chart7.resize();
        });
    }

    function CreateChart8() {
        var chart8 = echarts.init(document.getElementById('chart8'), 'shine');
        let url="${ctx}/chart/getLoginLogLastNYears/line?jwt=${requestScope.jwt}";
        let option={
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'cross'
                }
            },
            legend: {
                data:['2016年']
            },
            grid: {
                top:'15%',
                left: '3%',
                right: '3%',
                bottom: '1%',
                containLabel: true
            },
            xAxis: [
                {
                    type: 'category',
                    data: ["1", "2", "3", "4"]
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name:'2016年',
                    type:'line',
                    smooth: true,
                    data: [3.9, 5.9, 11.1, 18.7]
                }
            ]
        };

        vajaxPost(url,{num:2},false,(result)=>{
            let opt=eval("("+result+")");
            option.legend=opt.legend;
            option.xAxis=opt.xAxis;
            option.series=opt.series;
            chart8.setOption(option);
        });

        window.addEventListener('resize', function () {
            chart8.resize();
        });
    }

</script>
</html>