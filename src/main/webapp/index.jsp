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
                            <i-Col span="8">
                                <Row class-name="made-child-con-middle" type="flex" align="middle">
                                    <img class="avator-img" src="${ctx}/${requestScope.headImg}"/>
                                </Row>
                            </i-Col>
                            <i-Col span="16" style="padding-left:6px;">
                                <Row class-name="made-child-con-middle" type="flex" align="middle">
                                    <div>
                                        <b class="card-user-infor-name">${requestScope.name}</b>
                                        <p>${requestScope.loginName}</p>
                                    </div>
                                </Row>
                            </i-Col>
                        </Row>
                        <div class="line-gray"></div>
                        <Row class="margin-top-8">
                            <i-Col span="7">
                                <p class="notwrap">上次登录信息:</p>
                            </i-Col>
                            <i-Col span="10" class="padding-left-8">
                                ${requestScope.loginDateLast}
                            </i-Col>
                            <i-Col span="7" class="padding-left-8">
                                ${requestScope.geoLast}
                            </i-Col>
                        </Row>
                        <Row class="margin-top-8">
                            <i-Col span="7">
                                <p class="notwrap">本次登录信息:</p>
                            </i-Col>
                            <i-Col span="10" class="padding-left-8">
                                ${requestScope.loginDate}</i-Col>
                            <i-Col span="7" class="padding-left-8">
                                ${requestScope.geo}</i-Col>
                        </Row>
                    </Card>
                </Row>
                <Row class="margin-top-10">
                    <Card>
                        <p slot="title" class="card-title">
                            <Icon type="android-checkbox-outline"></Icon>
                            系统消息
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
                            地图
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
    var cityData=[
        {name: '海门', value: 45},
        {name: '鄂尔多斯', value: 34},
        {name: '招远', value: 47},
        {name: '舟山', value: 22},
        {name: '齐齐哈尔', value: 74},
        {name: '广州', value: 138},
        {name: '盐城', value: 15},
        {name: '北京', value: 250},
        {name: '深圳', value: 141},
        {name: '赤峰', value: 16},
        {name: '青岛', value: 89},
        {name: '乳山', value: 18},
        {name: '金昌', value: 34},
        {name: '泉州', value: 21},
        {name: '莱西', value: 66},
        {name: '日照', value: 45},
        {name: '胶南', value: 23},
        {name: '南通', value: 54},
        {name: '拉萨', value: 22},
        {name: '云浮', value: 78},
        {name: '梅州', value: 23},
        {name: '文登', value: 78},
        {name: '上海', value: 218},
        {name: '乌鲁木齐', value: 54},
        {name: '枣庄', value: 84},
        {name: '杭州', value: 64},
        {name: '淄博', value: 85},
        {name: '鞍山', value: 186},
        {name: '溧阳', value: 86},
        {name: '库尔勒', value: 200},
        {name: '安阳', value: 90},
        {name: '开封', value: 90},
        {name: '济南', value: 100},
        {name: '德阳', value: 93},
        {name: '温州', value: 195},
        {name: '九江', value: 96}
    ];

    new Vue({
        el: '#app',
        data: {
            tableHeight:281,
            cityData:cityData,
            columns: [
                {
                    title: '城市',
                    key: 'name'
                },
                {
                    title: '流量(k)',
                    key: 'value',
                    sortable: true
                }
            ]
        },
        methods: {},
        mounted() {
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
        var map = echarts.init(document.getElementById('chinaMap'));
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
                data: convertData(cityData),
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