<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>card布局</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">
    <div class="my-layout my-layout-clear-top-10">
        <Row class-name="my-layout-body" justify="center" type="flex">
            <i-col span="10">
                <div class="ivu-card-padding ivu-card-body-padding">
                    <Card>
                        <p slot="title">审核类型-选择</p>
                        <div class="my-layout">
                            <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
                                <i-col span="24">
                                    <div class="float-left">

                                    </div>
                                </i-col >
                            </Row>
                            <Row class-name="my-layout-body my-layout-body-ak"  type="flex">
                                <i-col span="9">

                                </i-col>
                            </Row>
                            <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                                <i-col span="6"></i-col>
                                <i-col span="18">
                                    <div class="float-right">

                                    </div>
                                </i-col>
                            </Row>
                        </div>
                    </Card>
                </div>
            </i-col>
            <i-col span="10">
                <div class="ivu-card-padding ivu-card-body-padding">
                    <Card>
                        <p slot="title">审核人-选择</p>
                        <div class="my-layout">
                            <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
                                <i-col span="24">
                                    <div class="float-left">

                                    </div>
                                </i-col >
                            </Row>
                            <Row class-name="my-layout-body my-layout-body-u"  type="flex">
                                <i-col span="9">

                                </i-col>
                            </Row>
                            <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                                <i-col span="6"></i-col>
                                <i-col span="18">
                                    <div class="float-right">

                                    </div>
                                </i-col>
                            </Row>
                        </div>
                    </Card>
                </div>
            </i-col>
            <i-col span="3">
                <div class="ivu-card-padding ivu-card-body-padding">
                    <Card>
                        <p slot="title">审核步骤</p>
                        <div class="fil-height">
                            <Steps :current="0"  direction="vertical">
                                <Step title="待进行" content="这里是该步骤的描述信息">
                                    <Tag color="red" closable >删除</Tag>
                                </Step>
                                <Step title="待进行" content="这里是该步骤的描述信息">
                                    <Tag color="red" closable >删除</Tag>
                                </Step>
                                <Step title="待进行" content="这里是该步骤的描述信息">
                                    <Tag color="red" closable >删除</Tag>
                                </Step>
                                <Step title="待进行" content="这里是该步骤的描述信息">
                                    <Tag color="red" closable >删除</Tag>
                                </Step>
                            </Steps>
                        </div>
                    </Card>
                </div>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col span="6"></i-col>
            <i-col span="18">
                <div class="float-right">
                    <i-Button type="success" @click="butRefresh()" icon="refresh">刷新</i-Button>
                </div>
            </i-col>
        </Row>
    </div>
</div>
</div>
</body>
<script>
    new Vue({
        el: '#app',
        data: {
        },
        mounted:function () {
        },
        methods:{
            butRefresh(){
                vconfirm(this,"确认刷新吗?",()=>{
                    window.location.reload();
                });
            }
        }
    });
</script>
</html>
