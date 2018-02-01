<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>部门</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">
    <div class="my-layout">
        <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
            <i-col span="10">
                <div class="float-left">
                    <label class="my-label">组织机构：</label>
                    <i-Select  style="width:200px" @on-change="selectCorporationChange"
                               v-model="selectCorporation.selectItem"
                               :disabled="selectCorporation.disabled"
                               :placeholder="selectCorporation.placeholder"
                               :not-found-text="selectCorporation.notFoundText"
                               :label-in-value="selectCorporation.labelInValue"
                               :size="selectCorporation.size" :clearable="selectCorporation.clearable"
                               :filterable="selectCorporation.filterable">
                        <i-Option v-for="item in selectCorporation.dataTable" :value="item.id"
                                  :key="item.id">{{ item.label }}</i-Option>
                    </i-Select>
                </div>
            </i-col >
            <i-col span="14">
                <div class="float-right">
                    <%@include file="../rightTemplate.jsp" %>
                </div>
            </i-col>
        </Row>
        <Row class-name="my-layout-body" type="flex">
            <i-col span="24">
                <i-Table :height="departmentTable.height"
                         :width="departmentTable.width"
                         :show-header="departmentTable.showHeader"
                         :loading="departmentTable.pageLoading"
                         :stripe="departmentTable.showStripe"
                         :border="departmentTable.showBorder"
                         :highlight-row="departmentTable.highlightRow"
                         :size="departmentTable.tableSize"
                         :columns="departmentTable.columns"
                         :data="departmentTable.dataTable"
                         @on-row-click="tableDepartmentRowClick"></i-Table>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col  span="6"></i-col >
            <i-col  span="18">
                <div class="float-right">
                    <Page @on-change="pageChangeDepartment" @on-page-size-change="pageSizeChangeDepartment"
                          :page-size="departmentPage.pageSize"
                          :page-size-opts="departmentPage.pageSizeOpts"
                          :placement="departmentPage.placement"
                          :current:="departmentPage.pageNo"
                          :total="departmentPage.totalCount"
                          :show-elevator="departmentPage.showElevator"
                          :show-total="departmentPage.showTotal"
                          :show-sizer="departmentPage.showSizer"></Page>
                </div>
            </i-col >

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
                <Form-Item label="电话" prop="phone">
                    <i-Input v-model="formModal.bindModel.phone" placeholder="请输入电话"></i-Input>
                </Form-Item>
                <Form-Item label="领导" prop="leader">
                    <i-Input v-model="formModal.bindModel.leader" placeholder="请输入领导"></i-Input>
                </Form-Item>
                <Form-Item label="地址" prop="address">
                    <i-Input v-model="formModal.bindModel.address" placeholder="请输入地址"></i-Input>
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
</div>
</body>
<script>
    window.onload=function() {
        var domain="${ctx}";
        var nomanage=${requestScope.nomanage};
        var corporationId="${requestScope.corporationId}";
        var departmentExport_url=domain+"/export/exportDepartment?jwt=${requestScope.jwt}";
        var departmentInsert_url=domain+"/department/insert?jwt=${requestScope.jwt}";
        var departmentUpdate_url=domain+"/department/update?jwt=${requestScope.jwt}";
        var departmentDelete_url=domain+"/department/delete?jwt=${requestScope.jwt}";
        var corporation_Select_url="${ctx}/corporation/vselect/selectCorporation?jwt=${requestScope.jwt}";

        var pageHelperDepartment=new pageHepler("${ctx}/department/pagination?jwt=${requestScope.jwt}",{
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
                    title: '电话',
                    key: 'phone'
                },
                {
                    title: '领导',
                    key: 'leader'
                },
                {
                    title: '地址',
                    key: 'address'
                },
                {
                    title: '备注',
                    key: 'memo'
                }
            ]
        },{orderBy:" id desc "});

        var selectHelperCorporation=new selectHelper(corporation_Select_url,{});

        new Vue({
            el: '#app',
            data: {
                jwt:"${requestScope.jwt}",
                butShow:${requestScope.rightBut},
                formModal:{
                    title:"",
                    modalShow:false,
                    okButShow:true,
                    okButLoading:false,
                    isAddStatus:true,
                    bindModel:{
                        id:null,
                        corporationid:null,
                        name:"",
                        phone:"",
                        leader:"",
                        address:"",
                        memo:""
                    },
                    ruleValidate:{
                        name: [
                            { required: true, message: '名称不能为空', trigger: 'blur' }
                        ],
                        phone: [
                            {required: true, validator:(rule, value, callback)=>{
                                if (value === '') {
                                    callback(new Error('手机号码不能为空'));
                                }
                                else if(!validatePhone(value)){
                                    callback(new Error('手机号码不正确'));
                                }
                                else {
                                    callback();
                                }
                            }, trigger: 'blur' }
                        ]
                    }
                },
                selectCorporation:selectHelperCorporation.ivSelect,
                departmentTable:pageHelperDepartment.ivTable,
                departmentPage:pageHelperDepartment.ivPage
            },
            created:function(){

            },
            mounted:function () {
                //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
                pageHelperDepartment.setHeight($(".my-layout-body").height());
                //权限控制
                if(nomanage) {
                    //加载组织机构
                    selectHelperCorporation.load("id='"+corporationId+"'");
                    selectHelperCorporation.setSelectItem(parseInt(corporationId));
                    selectHelperCorporation.setDisabled(true);
                }
                else{
                    //表格加载数据
                    pageHelperDepartment.load(null);
                    //加载组织机构
                    selectHelperCorporation.load(null);
                }
            },
            methods:{
                pageChangeDepartment(index){
                    pageHelperDepartment.pageIndexChanging(index);
                },
                pageSizeChangeDepartment(pageSize){
                    pageHelperDepartment.pageIndexChanging(1);
                },
                tableDepartmentRowClick(data,index){
                    pageHelperDepartment.setSelectRowIndex(index);
                },
                selectCorporationChange(option){
                    if(isBlank(option)||isBlank(option.value)) {
                        pageHelperDepartment.load(null);
                    }
                    else {
                        pageHelperDepartment.load("corporationId='" + option.value + "'");
                    }
                },
                butAdd(){
                    if(selectHelperCorporation.getSelectItem()) {
                        this.$refs['formModal.bindModel'].resetFields();
                        this.formModal.modalShow = true;
                        this.formModal.isAddStatus = true;
                        this.formModal.okButShow = true;
                        this.formModal.title = "增加部门";
                    }
                    else{
                        valert(this,"请选择组织结构");
                    }
                },
                butEdit(){
                    if(pageHelperDepartment.getSelectRowIndex()>-1){
                        this.$refs['formModal.bindModel'].resetFields();
                        this.formModal.modalShow=true;
                        this.formModal.okButShow=true;
                        this.formModal.isAddStatus=false;
                        this.formModal.title="修改部门";
                        let rowData=pageHelperDepartment.getSelectRowData();
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
                    if(pageHelperDepartment.getSelectRowIndex()>-1){
                        vconfirm(this,"确认删除吗？",()=>{
                            let rowData=pageHelperDepartment.getSelectRowData();
                            vajaxPost(departmentDelete_url,{id:rowData.id},false,(result)=>{
                                if(result&&result.success){
                                    pageHelperDepartment.deleteSelectedRow();
                                    pageHelperDepartment.setSelectRowIndex(-1);
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
                    if(pageHelperDepartment.getSelectRowIndex()>-1){
                        this.$refs['formModal.bindModel'].resetFields();
                        this.formModal.modalShow=true;
                        this.formModal.okButShow=false;
                        this.formModal.title="组织结构";
                        let rowData=pageHelperDepartment.getSelectRowData();
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
                butExport(){
                    pageHelperDepartment.export(departmentExport_url,this);
                },
                butRefresh(){
                    window.location.reload();
                },
                formModalCancel(){
                    this.formModal.modalShow=false;
                    this.formModal.okButLoading=false;
                },
                formModalOk(){
                    this.$refs['formModal.bindModel'].validate((valid) => {
                        if (valid) {
                            let vue=this;
                            let url= this.formModal.isAddStatus?departmentInsert_url:departmentUpdate_url;
                            let data=this.formModal.bindModel;

                            if(this.formModal.isAddStatus){
                                data["id"]=null;
                                data["corporationid"]=selectHelperCorporation.getSelectItem();
                            }

                            vajaxPost(url,data,true,(result)=>{
                                if(result&&result.success){
                                    vtoast(vue,result.tip);
                                    vue.formModal.modalShow=false;
                                    if(vue.formModal.isAddStatus){
                                        pageHelperDepartment.pageIndexChanging(1);
                                    }
                                    else{
                                        let rowData= pageHelperDepartment.getSelectRowData();
                                        $.each(data,function(key,value){
                                            if(typeof rowData[key]!=undefined){
                                                rowData[key]=value;
                                            }
                                        });
                                        pageHelperDepartment.setHighlightRow();
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
