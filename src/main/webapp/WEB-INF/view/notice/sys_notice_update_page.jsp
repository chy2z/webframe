<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<%@ include file="../../../taglib/import_ckeditor.jsp"%>
<%@ include file="../../../taglib/import_audit.jsp"%>
<html>
<head>
    <title>系统通知修改</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">
    <Spin size="large" fix v-if="spinShow"></Spin>
    <div class="my-layout">
        <Row class-name="my-layout-top" justify="center" align="middle" type="flex">
            <i-col  span="23">
                <div class="float-left fil-width">
                    <label class="my-label">通知标题：</label>
                    <i-Input v-model="title" placeholder="请输入通知标题..." maxlength="100" style="width:70%;" ></i-Input>
                </div>
            </i-col>
        </Row>
        <Row class-name="my-layout-body" justify="center"  type="flex">
            <i-col span="23">
                <Card>
                    <p slot="title">通知内容</p>
                    <div class="fil-height">
                       <textarea id="contect_text" name="content" style="width: 100%;height: 100%;padding: 0;border: 0;margin: 0;" class="ckeditor"></textarea>
                    </div>
                </Card>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="center" align="middle" type="flex">
            <i-col  span="23">
                <div class="float-right">
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
    var update_url=domain+"/sysNotice/update?jwt=${requestScope.jwt}&departId=${requestScope.user.departid}&operation="+Audit.operationType.sys_notice;
    new Vue({
        el: '#app',
        data: {
            spinShow:false,
            id:'${requestScope.sysNotice.id}',
            userid:'${requestScope.sysNotice.userid}',
            title:'${requestScope.sysNotice.title}'
        },
        mounted:function () {
            //初始化编辑器
            var cKeditor=CKEDITOR.replace('contect_text',{
                filebrowserImageUploadUrl: "${ctx}/upload/ckEditorImageUpload"
            });

            //赋值内容
            CKEDITOR.instances.contect_text.setData(`${requestScope.sysNotice.content}`);

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
                if(isBlank(this.title)){
                       valert(this,"请输入通知标题");
                       return;
                }
                if(!isBlank(CKEDITOR.instances.contect_text.getData())){
                    //修改日期出现问题
                    let m={id:this.id,userid:this.userid,title:this.title,content:CKEDITOR.instances.contect_text.getData()};
                    vajaxPost(update_url,m,true,(result)=>{
                        vtoast(this, result.tip);
                        //立即关闭增加窗口
                        vPopWindowsColse({title:this.title,createtime:result.data.createtime});
                        //this.title="";
                        //CKEDITOR.instances.contect_text.setData("");
                    },()=>{
                        this.spinShow=true;
                    },()=>{
                        this.spinShow=false;
                    });
                }
                else{
                    valert(this,"请编辑通知内容保存");
                }
            },
            butRefresh(){
                vconfirm(this,"确认刷新吗?",()=>{
                    window.location.reload();
                });
            }
        }
    });
</script>
</html>
