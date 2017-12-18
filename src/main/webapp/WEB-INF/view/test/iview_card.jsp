<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<%@ include file="../../../taglib/import_ckeditor.jsp"%>
<html>
<head>
    <title>系统通知新增</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <style>
        /* 实现card body 高度100% */
        .my-layout-body .ivu-card{
            height: 100%;
            padding: 51px 0 0;
        }

        /* 实现card body 高度100% */
        .my-layout-body .ivu-card .ivu-card-head{
            margin: -51px 0 0;
        }

        /* 实现card body 高度100% */
        .my-layout-body .ivu-card .ivu-card-body{
            height: 100%;
            overflow: auto;
        }

        .my-layout-body .ivu-card .ivu-card-head {
            border-bottom: 1px solid #e9eaec;
            padding: 14px 16px;
            line-height: 1;
            background-color: #eaf4fe;
        }
    </style>
</head>
<body>
<div class="my-app" id="app">
    <Spin size="large" fix v-if="spinLeftShow"></Spin>
    <div class="my-layout">
        <Row class-name="my-layout-top" justify="center" align="middle" type="flex">
            <i-col  span="23">
                <div class="float-left">
                    <label class="my-label">通知标题：</label>
                    <i-Input v-model="title" placeholder="请输入通知标题..."  style="width: 300px"></i-Input>
                </div>
            </i-col>
        </Row>
        <Row class-name="my-layout-body" justify="center"  type="flex">
            <i-col span="23">
                <Card>
                    <p slot="title">系 统 通 知 新 增</p>
                    <div class="fil-height">
                    <textarea id="contect_text" name="content" style="width: 100%;height: 100%;padding: 0;border: 0;margin: 0;" class="ckeditor"></textarea>
                    </div>
                </Card>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="center" align="middle" type="flex">
            <i-col  span="23">
                <div class="float-right">
                    <i-Button type="ghost" @click="butBack()" icon="arrow-left-c">返回</i-Button>
                    <i-Button type="success" @click="butRefresh()" icon="refresh">刷新</i-Button>
                    <i-Button type="primary" @click="butSave()" icon="checkmark">保存</i-Button>
                </div>
            </i-col>
        </Row>
    </div>
</div>
</body>
<script>
    var domain="${ctx}";
    var add_url=domain+"/sysNotice/insert?jwt=${requestScope.jwt}";
    new Vue({
        el: '#app',
        data: {
            spinLeftShow:false,
            userid:${requestScope.user.id},
            title:""
        },
        mounted:function () {
            //初始化编辑器
            var cKeditor=CKEDITOR.replace('contect_text',{
                filebrowserImageUploadUrl: "${ctx}/upload/ckEditorImageUpload"
            });

            //cKeditor实例准备
            cKeditor.on('instanceReady',function(event)
            {
                var editor=event.editor;
                //延时加载
                setTimeout(function(){
                    if(!editor.element)
                    {
                        setTimeout(arguments.callee,1);
                        return;
                    }
                    event.removeListener('instanceReady',this.callee);

                    if(editor.name=='contect_text')
                    {
                        //重载高度计算高度
                        editor.resize(editor.container.getStyle('width'),CKEDITOR.document.getById('cke_'+'contect_text').getParent().$.offsetHeight);
                    }
                },0);
            },null,null,9999);
        },
        methods:{
            butSave(){
                if(this.title==""){
                       valert(this,"请输入通知标题");
                       return;
                }
                if(CKEDITOR.instances.contect_text.getData()!=""){
                    vajaxPost(add_url,{userid:this.userid,title:this.title,content:CKEDITOR.instances.contect_text.getData()},true,(result)=>{
                        vtoast(this, result.tip);
                        this.title="";
                        CKEDITOR.instances.contect_text.setData("");
                        this.butBack();
                    },()=>{
                        this.spinLeftShow=true;
                    },()=>{
                        this.spinLeftShow=false;
                    });
                }
                else{
                    valert(this,"请编辑通知内容保存");
                }
            },
            butBack(){
                window.history.back();
            },
            butRefresh(){
                window.location.reload();
            }
        }
    });
</script>
</html>
