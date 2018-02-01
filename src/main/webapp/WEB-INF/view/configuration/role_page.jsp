<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>角色</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">
    <Row class-name="my-box" type="flex">
        <i-col span="12">
            <div class="my-layout my-box-left">
                <Row class-name="my-layout-top" justify="end" align="middle" type="flex">
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
                    </i-col>
                    <i-col span="14">

                    </i-col>
                </Row>
                <Row class-name="my-layout-body" type="flex">
                    <i-col class-name="col-left" span="24">
                        <i-Table :height="roleTable.height"
                                 :width="roleTable.width"
                                 :show-header="roleTable.showHeader"
                                 :loading="roleTable.pageLoading"
                                 :stripe="roleTable.showStripe"
                                 :border="roleTable.showBorder"
                                 :highlight-row="roleTable.highlightRow"
                                 :size="roleTable.tableSize"
                                 :columns="roleTable.columns"
                                 :data="roleTable.dataTable"
                                 @on-row-click="tableRoleRowClick"></i-Table>
                    </i-col>
                </Row>
                <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                    <i-col span="6"></i-col>
                    <i-col span="18">
                        <div class="float-right">
                            <Page @on-change="pageChangeRole" @on-page-size-change="pageSizeChangeRole"
                                  :page-size="rolePage.pageSize"
                                  :page-size-opts="rolePage.pageSizeOpts"
                                  :placement="rolePage.placement"
                                  :current:="rolePage.pageNo"
                                  :total="rolePage.totalCount"
                                  :show-elevator="rolePage.showElevator"
                                  :show-total="rolePage.showTotal"
                                  :show-sizer="rolePage.showSizer"></Page>
                        </div>
                    </i-col>

                </Row>
            </div>
        </i-col>
        <i-col span="12">
            <div class="my-layout my-box-right">
                <Row class-name="my-layout-top" justify="end" align="middle" type="flex">
                    <i-col span="10">
                    </i-col>
                    <i-col span="14">
                        <div class="float-right">
                            <%@include file="../rightTemplate.jsp" %>
                        </div>
                    </i-col>
                </Row>
                <Row class-name="my-layout-body" type="flex">
                    <i-col class-name="col-right" span="24">
                        <i-Table :height="userTable.height"
                                 :width="userTable.width"
                                 :show-header="userTable.showHeader"
                                 :loading="userTable.pageLoading"
                                 :stripe="userTable.showStripe"
                                 :border="userTable.showBorder"
                                 :highlight-row="userTable.highlightRow"
                                 :size="userTable.tableSize"
                                 :columns="userTable.columns"
                                 :data="userTable.dataTable"
                                 >
                        </i-Table>
                    </i-col>
                </Row>
                <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                    <i-col span="6"></i-col>
                    <i-col span="18">
                        <div class="float-right">
                            <Page
                                  :page-size="userPage.pageSize"
                                  :page-size-opts="userPage.pageSizeOpts"
                                  :placement="userPage.placement"
                                  :current:="userPage.pageNo"
                                  :total="userPage.totalCount"
                                  :show-elevator="userPage.showElevator"
                                  :show-total="userPage.showTotal"
                                  :show-sizer="userPage.showSizer"></Page>
                        </div>
                    </i-col>

                </Row>
            </div>
        </i-col>
    </Row>

    <Modal v-model="formModal.modalShow" :mask-closable="false" :styles="{top: '20px'}" :width="500">
        <p slot="header" class="my-modal-title">
            <Icon type="compose"></Icon>
            <span>{{formModal.title}}</span>
        </p>
        <div>
            <i-Form ref="formModal.bindModel" :model="formModal.bindModel" :rules="formModal.ruleValidate"
                    label-position="right" label-width="80">
                <Form-Item label="角色名称" prop="name">
                    <i-Input v-model="formModal.bindModel.name" placeholder="请输入角色名称"></i-Input>
                </Form-Item>
                <Form-Item label="角色备注" prop="memo">
                    <i-Input v-model="formModal.bindModel.memo" placeholder="请输入角色备注"></i-Input>
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
        var domain="${ctx}";
        var nomanage=${requestScope.nomanage};
        var corporationId="${requestScope.corporationId}";
        var roleInsert_url=domain+"/role/insert?jwt=${requestScope.jwt}";
        var roleUpdate_url=domain+"/role/update?jwt=${requestScope.jwt}";
        var roleDelete_url=domain+"/role/delete?jwt=${requestScope.jwt}";
        var corporation_Select_url="${ctx}/corporation/vselect/selectCorporation?jwt=${requestScope.jwt}";

        var pageHelperRole=new pageHepler("${ctx}/role/pagination?jwt=${requestScope.jwt}",{
            columns: [
                {
                    title: '序号',
                    key: 'id'
                },
                {
                    title: '角色名称',
                    key: 'name'
                },
                {
                    title: '角色备注',
                    key: 'memo'
                }
            ]
        },{orderBy:" id desc "});

        var pageHelperUser=new pageHepler("${ctx}/users/pagination?jwt=${requestScope.jwt}",{
            columns: [
                {
                    title: '用户姓名',
                    key: 'name'
                },
                {
                    title: '职位',
                    key: 'office'
                },
                {
                    title: '状态',
                    key: 'state'
                }
            ]
        },{pageSize:50,orderBy:" u.id desc "});

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
                        memo:""
                    },
                    ruleValidate:{
                        name: [
                            { required: true, message: '名称不能为空', trigger: 'blur' }
                        ]
                    }
                },
                selectCorporation:selectHelperCorporation.ivSelect,
                roleTable:pageHelperRole.ivTable,
                rolePage:pageHelperRole.ivPage,
                userTable:pageHelperUser.ivTable,
                userPage:pageHelperUser.ivPage
            },
            created:function(){

            },
            mounted:function () {
                //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
                pageHelperRole.setHeight($(".my-box-left .my-layout-body").height());
                //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
                pageHelperUser.setHeight($(".my-box-right .my-layout-body").height());
                //权限控制
                if(nomanage){
                    //加载组织机构
                    selectHelperCorporation.load("id='"+corporationId+"'");
                    selectHelperCorporation.setSelectItem(parseInt(corporationId));
                    selectHelperCorporation.setDisabled(true);
                }
                else{
                    //加载角色表格数据
                    pageHelperRole.load(null);
                    //加载组织机构
                    selectHelperCorporation.load(null);
                }
            },
            methods:{
                pageChangeRole(index){
                    pageHelperRole.pageIndexChanging(index);
                },
                pageSizeChangeRole(pageSize){
                    pageHelperRole.pageIndexChanging(1,pageSize);
                },
                tableRoleRowClick(data,index){
                    pageHelperRole.setSelectRowIndex(index);
                    pageHelperUser.load(" roleid='" + data.id + "' ");
                },
                selectCorporationChange(option){
                    if(isBlank(option)||isBlank(option.value)){
                        pageHelperRole.load(null);
                    }
                    else {
                        pageHelperRole.load("corporationId='" + option.value + "'");
                    }
                },
                butSearch(){
                    this.queryModal.modalShow=true;
                },
                butAdd(){
                    if(selectHelperCorporation.getSelectItem()) {
                        this.$refs['formModal.bindModel'].resetFields();
                        this.formModal.modalShow = true;
                        this.formModal.isAddStatus = true;
                        this.formModal.okButShow = true;
                        this.formModal.title = "增加角色";
                    }
                    else{
                        valert(this,"请先选择组织机构");
                    }
                },
                butEdit(){
                    if(pageHelperRole.getSelectRowIndex()>-1){
                        this.$refs['formModal.bindModel'].resetFields();
                        this.formModal.modalShow=true;
                        this.formModal.okButShow=true;
                        this.formModal.isAddStatus=false;
                        this.formModal.title="修改角色";
                        let rowData=pageHelperRole.getSelectRowData();
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
                    if(pageHelperRole.getSelectRowIndex()>-1){
                        vconfirm(this,"确认删除吗？",()=>{
                            let rowData=pageHelperRole.getSelectRowData();
                            vajaxPost(roleDelete_url,{id:rowData.id},false,(result)=>{
                                if(result&&result.success){
                                    pageHelperRole.deleteSelectedRow();
                                    pageHelperRole.setSelectRowIndex(-1);
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
                            let url= this.formModal.isAddStatus?roleInsert_url:roleUpdate_url;
                            let data=this.formModal.bindModel;
                            if(this.formModal.isAddStatus){
                                if(typeof(data["id"])!=undefined){
                                    data["id"]=null;
                                }
                                data["corporationid"]=selectHelperCorporation.getSelectItem();
                            }
                            vajaxPost(url,data,true,(result)=>{
                                if(result&&result.success){
                                    vtoast(vue,result.tip);
                                    vue.formModal.modalShow=false;
                                    if(vue.formModal.isAddStatus){
                                        pageHelperRole.pageIndexChanging(1);
                                    }
                                    else{
                                        let rowData= pageHelperRole.getSelectRowData();
                                        $.each(data,function(key,value){
                                            if(typeof rowData[key]!=undefined){
                                                rowData[key]=value;
                                            }
                                        });
                                        pageHelperRole.setHighlightRow();
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

</script>
</html>
