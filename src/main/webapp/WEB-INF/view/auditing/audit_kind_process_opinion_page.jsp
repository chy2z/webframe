<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>审核意见</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<style>
    .layout-tabs-right {
        height: 100%;
        padding: 0px 0px 0px;
        box-sizing: border-box;
    }

    /* tab选项卡头部和内容的间距 */
    .layout-tabs-right-content {
        height: 100%;
        min-height: 400px;
        margin: 0px;
        padding: 32px 1px 0px;
        overflow: hidden;
        background: #eee;
        border-radius: 4px;
    }

    /* tab选项卡头部和内容的间距  */
    /* 和父节点高度一样，所以父节点padding32px,同时头部向上偏移32px*/
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
</style>
<body>
<div class="my-app" id="app">
    <Spin size="large" fix v-if="spinShow"></Spin>
    <div class="my-layout my-layout-clear-top-bottom">
        <Row class-name="my-layout-body" type="flex">
            <i-col span="24">
                <div class="layout-tabs-right">
                    <Tabs class="layout-tabs-right-content" type="card" v-model="tabSelected">
                        <Tab-Pane label="送审内容" name="framePage" icon="ios-glasses">
                            <iframe id="framePage" frameborder="0" scrolling="yes"
                                    style="border: 0px; height: 100%; width: 100%;"></iframe>
                        </Tab-Pane>
                        <Tab-Pane label="送审进度" name="frameProcess" icon="android-share-alt">
                            <iframe id="frameProcess" frameborder="0" scrolling="yes"
                                    style="border: 0px; height: 100%; width: 100%;"></iframe>
                        </Tab-Pane>
                        <Tab-Pane label="审核意见" name="frameOpinion" icon="ios-compose">
                            <div class="my-layout my-layout-clear-top-bottom">
                            <Row class-name="my-layout-body" justify="center"  type="flex">
                                <i-col span="5"></i-col>
                                <i-col span="14">
                                    <i-Form :model="auditOpinion" label-position="left" :label-width="80">
                                        <Form-Item label="审核结果">
                                            <i-Switch size="large" v-model="auditOpinion.switchState">
                                                <span slot="open">通过</span>
                                                <span slot="close">打回</span>
                                            </i-Switch>
                                        </Form-Item>
                                        <Form-Item label="审核意见">
                                            <i-Input v-model="auditOpinion.opinion" type="textarea" :autosize="{minRows: 10,maxRows: 20}" placeholder="Enter something..."></i-Input>
                                        </Form-Item>
                                    </i-Form>
                                </i-col>
                                <i-col span="5"></i-col>
                            </Row>
                            </div>
                        </Tab-Pane>
                    </Tabs>
                </div>

            </i-col>
        </Row>
    </div>
</div>
</body>
<script>
    var domain="${ctx}";

    var data=VPopConfig();

    new Vue({
        el: '#app',
        data:{
            jwt:"${requestScope.jwt}",
            spinShow:false,
            tabSelected:"framePage",
            auditOpinion:{
                switchState:false,
                opinion:""
            }
        },
        created:function(){
            vSpin(this,2000);

            // 加载审核内容
            document.querySelector("#framePage").src=domain+data.url+"?jwt="+this.jwt+"&id="+data.tvalue;

            // 加载审核进度
            vDelay(2000,null,()=>{
                let url=domain+"/auditKindProcess/path/flowProcessView?jwt="+this.jwt+"&tName="+data.tname+"&tKey="+data.tkey+"&tValue="+data.tvalue;
                document.querySelector("#frameProcess").src=url;
            },null);
        },
        methods:{

        }
    });
</script>
</html>
