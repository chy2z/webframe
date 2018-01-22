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
<body>
<div class="my-app" id="app">
    <Spin size="large" fix v-if="spinShow"></Spin>
    <div class="my-layout my-layout-clear-top-bottom">
        <Row class-name="my-layout-body" type="flex">
            <i-col span="24">
                <div class="layout-tabs">
                    <Tabs class="layout-tabs-content" type="card" v-model="tabSelected">
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
                            <Row class-name="my-layout-body padding-20" justify="center"  type="flex">
                                <i-col span="5"></i-col>
                                <i-col span="14">
                                    <i-Form ref="auditOpinion" :model="auditOpinion" :rules="ruleValidate" label-position="right" :label-width="80">
                                        <Form-Item prop="switchState" label="审核结果">
                                            <i-Switch size="large" v-model="auditOpinion.switchState">
                                                <span slot="open">通过</span>
                                                <span slot="close">打回</span>
                                            </i-Switch>
                                        </Form-Item>
                                        <Form-Item prop="opinion" label="审核意见">
                                            <i-Input v-model="auditOpinion.opinion" type="textarea" :autosize="{minRows: 10,maxRows: 20}" placeholder="请输入审核意见..."></i-Input>
                                        </Form-Item>
                                        <Form-Item>
                                            <i-Button type="ghost" @click="handleReset('auditOpinion')" >重置</i-Button>
                                            <i-Button type="primary" @click="handleSubmit('auditOpinion')" style="margin-left: 8px">保存</i-Button>
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
    var opinion_url=domain+"/auditWait/setAuditOpinion?jwt=${requestScope.jwt}";
    var data=VPopConfig();

    new Vue({
        el: '#app',
        data:{
            jwt:"${requestScope.jwt}",
            spinShow:false,
            tabSelected:"framePage",
            auditOpinion:{
                switchState:true,
                opinion:"无意见"
            },
            ruleValidate: {
                switchState: [
                    {required: true, message: '审核结果必须选择', trigger: 'blur',type:'boolean'}
                ],
                opinion: [
                    {required: true, message: '审核意见不能为空', trigger: 'blur'}
                ]
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
            handleSubmit (name) {
                this.$refs[name].validate((valid) => {
                    if (valid) {
                        vajaxPost(opinion_url,{
                            awid:data.id,
                            uid:${requestScope.user.id},
                            auditState:this.auditOpinion.switchState?vLang.audit.pass:vLang.audit.return,
                            opinion:this.auditOpinion.opinion
                        },false,(result)=>{
                            vtoast(this,result.tip);
                            if(result.success) { alert("111");
                                vPopWindowsColse(null);
                            }
                        },()=>{
                            this.spinShow=true;
                        },()=>{
                            this.spinShow=false;
                        },()=>{
                            this.spinShow=false;
                        });
                    } else {
                        vtoast(this,"数据验证失败!");
                    }
                })
            },
            handleReset (name) {
                this.$refs[name].resetFields();
            }
        }
    });
</script>
</html>
