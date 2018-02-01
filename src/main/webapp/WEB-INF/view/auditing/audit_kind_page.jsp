<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>审核类型</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">
    <div class="my-layout">
        <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
            <i-col span="6"></i-col >
            <i-col span="18">
                <div class="float-right">
                    <%@include file="../rightTemplate.jsp" %>
                </div>
            </i-col >
        </Row>
        <Row class-name="my-layout-body" type="flex">
            <i-col span="24">
                <i-Table :height="dataTable.height"
                         :width="dataTable.width"
                         :show-header="dataTable.showHeader"
                         :loading="dataTable.pageLoading"
                         :stripe="dataTable.showStripe"
                         :border="dataTable.showBorder"
                         :highlight-row="dataTable.highlightRow"
                         :size="dataTable.tableSize"
                         :columns="dataTable.columns"
                         :data="dataTable.dataTable"
                         @on-row-click="tableRowClick"></i-Table>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col span="6"></i-col>
            <i-col span="18">
                <div class="float-right">
                    <Page @on-change="pageChange" @on-page-size-change="pageSizeChange"
                          :page-size="dataPage.pageSize"
                          :page-size-opts="dataPage.pageSizeOpts"
                          :placement="dataPage.placement"
                          :current:="dataPage.pageNo"
                          :total="dataPage.totalCount"
                          :show-elevator="dataPage.showElevator"
                          :show-total="dataPage.showTotal"
                          :show-sizer="dataPage.showSizer"></Page>
                </div>
            </i-col>
        </Row>
    </div>

    <Modal v-model="formModal.modalShow" :mask-closable="false" :styles="{top: '20px'}" :width="500">
        <p slot="header" class="my-modal-title">
            <Icon type="compose"></Icon>
            <span>{{formModal.title}}</span>
        </p>
        <div>
            <i-Form ref="formModal.bindModel" :model="formModal.bindModel" :rules="formModal.ruleValidate"
                    label-position="right" label-width="50">
                <Form-Item label="名称" prop="name">
                    <i-Input v-model="formModal.bindModel.name" placeholder="请输入名称"></i-Input>
                </Form-Item>
                <Form-Item label="业务" prop="operation">
                    <i-Input v-model="formModal.bindModel.operation" placeholder="请输入业务名称"></i-Input>
                </Form-Item>
                <Form-Item label="备注" prop="memo">
                    <i-Input v-model="formModal.bindModel.memo" placeholder="请输入备注"></i-Input>
                </Form-Item>
            </i-Form>
        </div>
        <div slot="footer">
            <i-Button type="text" size="large" @click="formModalCancel" >取消</i-Button>
            <i-Button type="primary" size="large"  @click="formModalOk"
                      v-show="formModal.okButShow"
                      :loading="formModal.okButLoading" >确定</i-Button>
        </div>
    </Modal>

    <Modal v-model="queryModal.modalShow" :mask-closable="false" :styles="{top: '20px'}" :width="500">
        <p slot="header" class="my-modal-title">
            <Icon type="search"></Icon>
            <span>{{queryModal.title}}</span>
        </p>
        <div>
            <i-Form ref="queryModal.bindModel" :model="queryModal.bindModel" :rules="queryModal.ruleValidate"
                    label-position="right" label-width="40"  >
                <Form-Item label="名称" prop="name">
                    <i-Input element-id="qname" v-model="queryModal.bindModel.name" placeholder="请输入名称"></i-Input>
                </Form-Item>
                <Form-Item label="业务" prop="operation">
                    <i-Input element-id="qoperation" v-model="queryModal.bindModel.operation" placeholder="请输入业务标识"></i-Input>
                </Form-Item>
                <Form-Item label="备注" prop="memo">
                    <i-Input element-id="qmemo" v-model="queryModal.bindModel.memo" placeholder="请输入备注"></i-Input>
                </Form-Item>
            </i-Form>
        </div>
        <div slot="footer">
            <i-Button type="text" size="large" @click="queryModalCancel" >取消</i-Button>
            <i-Button type="error" size="large" @click="queryModalReset" >重置</i-Button>
            <i-Button type="primary" size="large"  @click="queryModalOk"
                      v-show="queryModal.okButShow"
                      :loading="queryModal.okButLoading" >确定</i-Button>
        </div>
    </Modal>
</div>
</body>
<script>
    window.onload=function() {
        var domain="${ctx}";
        var nomanage=${requestScope.nomanage};
        var corporationId="${requestScope.corporationId}";
        var insert_url=domain+"/auditKind/insert?jwt=${requestScope.jwt}";
        var update_url=domain+"/auditKind/update?jwt=${requestScope.jwt}";
        var delete_url=domain+"/auditKind/delete?jwt=${requestScope.jwt}";
        var pagingHelper=new pageHepler("${ctx}/auditKind/pagination?jwt=${requestScope.jwt}",{
            columns: [
                {
                    title: '序号',
                    key: 'id'
                },
                {
                    title: '名称',
                    key: 'name'
                },
                {
                    title: '业务',
                    key: 'operation'
                },
                {
                    title: '备注',
                    key: 'memo'
                }
            ]
        },{orderBy:" id desc "});

        new Vue({
            el: '#app',
            data: {
                jwt:"${requestScope.jwt}",
                butShow:${requestScope.rightBut},
                queryModal:{
                    title:"条件查询",
                    modalShow:false,
                    okButShow:true,
                    okButLoading:false,
                    bindModel:{
                        id:null,
                        name:"",
                        memo:"",
                        operation:""
                    },
                    ruleValidate:{}
                },
                formModal:{
                    title:"",
                    modalShow:false,
                    okButShow:true,
                    okButLoading:false,
                    isAddStatus:true,
                    bindModel:{
                        id:null,
                        name:"",
                        memo:"",
                        operation:""
                    },
                    ruleValidate:{
                        name: [
                            { required: true, message: '名称不能为空', trigger: 'blur' }
                        ],
                        operation: [
                            { required: true, message: '业务名称不能为空', trigger: 'blur' }
                        ]
                    }
                },
                dataTable:pagingHelper.ivTable,
                dataPage:pagingHelper.ivPage
            },
            created:function(){
            },
            mounted:function () {
                //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
                pagingHelper.setHeight($(".my-layout-body").height());
                pagingHelper.load(null);
            },
            methods:{
                pageChange(index){
                    pagingHelper.pageIndexChanging(index);
                },
                pageSizeChange(pageSize){
                    pagingHelper.pageIndexChanging(1,pageSize);
                },
                tableRowClick(data,index){
                    pagingHelper.setSelectRowIndex(index);
                },
                butSearch(){
                    this.queryModal.modalShow=true;
                },
                butAdd(){
                    this.$refs['formModal.bindModel'].resetFields();
                    this.formModal.modalShow=true;
                    this.formModal.isAddStatus=true;
                    this.formModal.okButShow=true;
                    this.formModal.title="增加审核类型";
                },
                butEdit(){
                    if(pagingHelper.getSelectRowIndex()>-1){
                        this.$refs['formModal.bindModel'].resetFields();
                        this.formModal.modalShow=true;
                        this.formModal.okButShow=true;
                        this.formModal.isAddStatus=false;
                        this.formModal.title="修改审核类型";
                        let rowData=pagingHelper.getSelectRowData();
                        let vue=this;
                        $.each(rowData,function(key,value){
                            if(typeof vue.formModal.bindModel[key]!=undefined){
                                vue.formModal.bindModel[key]=value;
                            }
                        });
                    }
                    else{
                        valert(this,"请选择一行记录修改");
                    }
                },
                butDel(){
                    if(pagingHelper.getSelectRowIndex()>-1){
                        vconfirm(this,"确认删除吗？",()=>{
                            let rowData=pagingHelper.getSelectRowData();
                            vajaxPost(delete_url,{id:rowData.id},false,(result)=>{
                                if(result&&result.success){
                                    pagingHelper.deleteSelectedRow();
                                    pagingHelper.setSelectRowIndex(-1);
                                    vtoast(this,result.tip);
                                }
                                else{
                                    valert(this,result.tip);
                                }
                            });
                        });
                    }
                    else{
                        valert(this,"请选择一行记录删除");
                    }
                },
                butLook(){
                    if(pagingHelper.getSelectRowIndex()>-1){
                        this.$refs['formModal.bindModel'].resetFields();
                        this.formModal.modalShow=true;
                        this.formModal.okButShow=false;
                        this.formModal.title="组织结构";
                        let rowData=pagingHelper.getSelectRowData();
                        let vue=this;
                        $.each(rowData,function(key,value){
                            if(vue.formModal.bindModel[key]!=undefined){
                                vue.formModal.bindModel[key]=value;
                            }
                        });
                    }
                    else{
                        valert(this,"请选择一行记录修改");
                    }
                },
                butRefresh(){
                    window.location.reload();
                },
                queryModalCancel(){
                    this.queryModal.modalShow=false;
                },
                queryModalReset(){
                    this.$refs['queryModal.bindModel'].resetFields();
                },
                queryModalOk(){
                    this.$refs['queryModal.bindModel'].validate((valid) => {
                        if (valid) {
                            let WR = [];
                            WR[WR.length] = new whereRelation("name", $("#qname").val(), "string", null, null, true);
                            WR[WR.length] = new whereRelation("memo", $("#qcode").val(), "string", null, null, true);
                            pagingHelper.load(new pageHelperWhere(WR).getWhere());
                            this.queryModal.modalShow=false;
                        }
                        else{
                            valert(this,'表单验证失败!');
                        }
                    });
                },
                formModalCancel(){
                    this.formModal.modalShow=false;
                    this.formModal.okButLoading=false;
                },
                formModalOk(){
                    this.$refs['formModal.bindModel'].validate((valid) => {
                        if (valid) {
                            let vue=this;
                            let url= this.formModal.isAddStatus?insert_url:update_url;
                            let data=this.formModal.bindModel;
                            if(this.formModal.isAddStatus){
                                data["id"]=null;
                            }
                            vajaxPost(url,data,true,(result)=>{
                                if(result&&result.success){
                                    vtoast(vue,result.tip);
                                    vue.formModal.modalShow=false;
                                    if(vue.formModal.isAddStatus){
                                        pagingHelper.pageIndexChanging(1);
                                    }
                                    else{
                                        let rowData= pagingHelper.getSelectRowData();
                                        $.each(data,function(key,value){
                                            if(typeof rowData[key]!=undefined){
                                                rowData[key]=value;
                                            }
                                        });
                                        pagingHelper.setHighlightRow();
                                    }
                                }
                                else{
                                    valert(vue,result.tip);
                                }
                            },()=>{
                                vue.formModal.okButLoading=true;
                            },()=>{
                                vue.formModal.okButLoading=false;
                            });

                        } else {
                            valert(this,'表单验证失败!');
                        }
                    });
                }
            }
        });
    }
</script>
</html>