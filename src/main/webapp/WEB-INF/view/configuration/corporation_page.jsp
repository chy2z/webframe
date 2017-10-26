<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>组织机构</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <link rel="stylesheet" href="../../../css/default.css">
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

        .my-layout {
            width: 100%;
            height: 100%;
            /* 上下间距 60px */
            padding: 60px 0;
            border: 0px solid #d7dde4;
            border-radius: 4px;
            overflow:hidden;
        }

        .my-layout-top{
            width: 100%;
            height:60px;
            /* 向上偏移 60px */
            margin: -60px 0 0;
        }


        .my-layout-body{
            width: 100%;
            /* 占满剩余高度 */
            height: 100%;
            background: #eee;
        }

        .my-layout-bottom{
            width: 100%;
            height:60px;
            /* 向下偏移 60px */
            margin:0 0 -60px;
        }

    </style>
</head>
<body>
<div id="app">
    <div class="my-layout">
        <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
            <i-col span="6"></i-col >
            <i-col span="18">
                <div style="float: right;margin: 0 5px;">
                    <%@include file="../rightTemplate.jsp" %>
                </div>
            </i-col >
        </Row>
        <Row class-name="my-layout-body" type="flex">
            <i-col span="24">
                <i-Table :height="tableCroporation.height" :show-header="tableCroporation.showHeader" :loading="tableCroporation.pageLoading"
                         :stripe="tableCroporation.showStripe" :border="tableCroporation.showBorder"
                         :highlight-row="tableCroporation.highlightRow" :size="tableCroporation.tableSize"
                         :columns="tableCroporation.columnsCorpration" :data="tableCroporation.dataCorpration"></i-Table>
            </i-col >
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col  span="6"></i-col >
            <i-col  span="18">
                <div style="float: right;margin: 0 5px;">
                   <Page @on-change="pageChange" @on-page-size-change="pageSizeChange"
                         :page-size="pageCroporation.pageSize"
                         :page-size-opts="pageCroporation.pageSizeOpts"
                         :placement="pageCroporation.placement"
                         :current:="pageCroporation.pageNo"
                         :total="pageCroporation.totalCount"
                         :show-elevator="pageCroporation.showElevator" :show-total="pageCroporation.showTotal"
                         :show-sizer="pageCroporation.showSizer"></Page>
                </div>
            </i-col >

        </Row>
    </div>


    <Modal v-model="formModal.modalAdd" :mask-closable="false" :styles="{top: '20px'}" :width="500">
        <p slot="header" style="text-align:center">
            <Icon size="16" type="compose"></Icon>
            <span style="letter-spacing: 1px;font-size:16px;color:#2b85e4;font-weight:700;">增加组织结构</span>
        </p>
        <div style="text-align:center">
            <i-Form ref="formValidateAdd" :model="formValidateAdd" :rules="ruleValidateAdd" label-position="left" label-width="50"  >
                <Form-Item label="名称" prop="name">
                    <i-Input v-model="formValidateAdd.name" placeholder="请输入名称"></i-Input>
                </Form-Item>
                <Form-Item label="编号" prop="code">
                    <i-Input v-model="formValidateAdd.code" placeholder="请输入编号"></i-Input>
                </Form-Item>
            </i-Form>
        </div>
        <div slot="footer">
            <i-Button type="test" size="large" @click="modalAddCancel" >取消</i-Button>
            <i-Button type="primary" size="large"  :loading="formModal.addOkLoading" @click="modalAddOk" >确定</i-Button>
        </div>
    </Modal>

</div>
</body>
<script>
    window.onload=function() {
        var domain="${ctx}";
        var corporationInsert_url=domain+"/corporation/insert?jwt=${requestScope.jwt}";
        var pageHelper=null;

        new Vue({
            el: '#app',
            data: {
                jwt:"${requestScope.jwt}",
                butShow:${requestScope.rightBut},
                formModal:{
                    modalAdd:false,
                    addOkLoading:false
                },
                formValidateAdd:{
                    name:"",
                    code:""
                },
                ruleValidateAdd:{
                    name: [
                        { required: true, message: '名称不能为空', trigger: 'blur' }
                    ],
                    code: [
                        { required: true, message: '编号不能为空', trigger: 'blur' }
                    ]
                },
                pageCroporation:{
                    showElevator:true,
                    showTotal:true,
                    showSizer:true,
                    placement:"top",
                    pageSize:10,
                    pageSizeOpts:[10,20,30,50],
                    pageNo:1,
                    totalCount:2,
                    orderBy:" id desc "
                },
                tableCroporation:{
                    height:200,
                    pageLoading:true,
                    showBorder: true,
                    showStripe: true,
                    showHeader: true,
                    highlightRow:true,
                    showIndex: false,
                    showCheckbox: false,
                    fixedHeader: false,
                    tableSize: 'default',
                    columnsCorpration:[
                        {
                            title: '序号',
                            key: 'id'
                        },
                        {
                            title: '姓名',
                            key: 'name'
                        },
                        {
                            title: '编号',
                            key: 'code'
                        }
                    ],
                    dataCorpration:[]
                }
            },
            created:function(){
                pageHelper=new pageHepler("${ctx}/corporation/pagination?jwt="+this.jwt,this.tableCroporation,this.pageCroporation);
                pageHelper.load(this.pageCroporation.pageNo,this.pageCroporation.pageSize,null,this.pageCroporation.orderBy);
            },
            mounted:function () {
                //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
                this.tableCroporation.height=$(".my-layout-body").height();
            },
            methods:{
                pageChange(index){
                    pageHelper.pageIndexChanging(index);
                },
                pageSizeChange(pageSize){
                    pageHelper.load(1,pageSize,null,this.pageCroporation.orderBy);
                },
                butSearch(){

                },
                butAdd(){
                    this.$refs['formValidateAdd'].resetFields();
                    this.formModal.modalAdd=true;
                },
                butEdit(){

                },
                butDel(){

                },
                butLook(){

                },
                butExport(){

                },
                butRefresh(){
                    window.location.reload();
                },
                modalAddCancel(){
                    this.formModal.modalAdd=false;
                    this.formModal.addOkLoading=false;
                },
                modalAddOk(){
                    this.$refs['formValidateAdd'].validate((valid) => {
                        if (valid) {
                            let vue=this;
                            let data=vue.formValidateAdd;
                            $.ajax({
                                url: corporationInsert_url,
                                type: "POST",
                                dataType:"json",
                                //设置请求头信息
                                contentType : 'application/json;charset=utf-8',
                                //将Json对象序列化成Json字符串，toJSON()需要引用jquery.json.min.js
                                data: $.toJSON(data),
                                beforeSend:function(){
                                    vue.formModal.addOkLoading=true;
                                },
                                complete:function(){
                                    vue.formModal.addOkLoading=false;
                                },
                                success: function(data){
                                    if(data&&data.success){
                                        vtoast(vue,data.tip);
                                        vue.formModal.modalAdd=false;
                                        vue.pageChange(1);
                                    }
                                    else{
                                        valert(vue,data.tip);
                                    }
                                },
                                error: function(res){
                                    alert(res.responseText);
                                }
                            });
                        } else {
                           vtoast(this,'表单验证失败!');
                        }
                    });
                }
            }
        });
    }
</script>
</html>
