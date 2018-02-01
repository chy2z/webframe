<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<%@ include file="../../../taglib/import_corpper.jsp"%>
<html>
<head>
    <title>用户管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <style>
        .outer { width: 100%; height: 70px;padding: 5px 0 0;
            box-sizing: border-box ;
         }

        .outer img { height: 60px;  width: 100%; }

    </style>
</head>
<body>
<div class="my-app" id="app">
    <div class="my-layout">
        <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
            <i-col span="6">
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
            <i-col span="6">
                <div class="float-left">
                    <label class="my-label">部门：</label>
                    <i-Select  style="width:200px" @on-change="selectQueryDepartChange"
                               v-model="selectQueryDepart.selectItem"
                               :disabled="selectQueryDepart.disabled"
                               :placeholder="selectQueryDepart.placeholder"
                               :not-found-text="selectQueryDepart.notFoundText"
                               :label-in-value="selectQueryDepart.labelInValue"
                               :size="selectQueryDepart.size" :clearable="selectQueryDepart.clearable"
                               :filterable="selectQueryDepart.filterable">
                        <i-Option v-for="item in selectQueryDepart.dataTable" :value="item.id"
                                  :key="item.id">{{ item.label }}</i-Option>
                    </i-Select>
                </div>
            </i-col>
            <i-col span="12">
                <div class="float-right">
                    <%@include file="../rightTemplate.jsp" %>
                </div>
            </i-col>
        </Row>
        <Row class-name="my-layout-body" type="flex">
            <i-col span="24">
                <i-Table id="usersTable" :height="usersTable.height"
                         :width="usersTable.width"
                         :show-header="usersTable.showHeader"
                         :loading="usersTable.pageLoading"
                         :stripe="usersTable.showStripe"
                         :border="usersTable.showBorder"
                         :highlight-row="usersTable.highlightRow"
                         :size="usersTable.tableSize"
                         :columns="usersTable.columns"
                         :data="usersTable.dataTable"
                         @on-row-click="tableUsersRowClick"></i-Table>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col  span="6"></i-col>
            <i-col  span="18">
                <div class="float-right">
                    <Page @on-change="pageChangeUsers" @on-page-size-change="pageSizeChangeUsers"
                          :page-size="usersPage.pageSize"
                          :page-size-opts="usersPage.pageSizeOpts"
                          :placement="usersPage.placement"
                          :current:="usersPage.pageNo"
                          :total="usersPage.totalCount"
                          :show-elevator="usersPage.showElevator"
                          :show-total="usersPage.showTotal"
                          :show-sizer="usersPage.showSizer"></Page>
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
                    label-position="right" label-width="80">
                <Form-Item label="登录名称" prop="loginname">
                    <i-Input v-model="formModal.bindModel.loginname" placeholder="请输入登录名称"></i-Input>
                </Form-Item>
                <Form-Item label="登录密码" prop="password">
                    <i-Input v-model="formModal.bindModel.password" placeholder="请输入登录密码"></i-Input>
                </Form-Item>
                <Form-Item label="姓名" prop="name">
                    <i-Input v-model="formModal.bindModel.name" placeholder="请输入名称"></i-Input>
                </Form-Item>
                <Form-Item label="电话" prop="phone">
                    <i-Input v-model="formModal.bindModel.phone" placeholder="请输入电话"></i-Input>
                </Form-Item>
                <Form-Item label="邮箱" prop="email">
                    <i-Input v-model="formModal.bindModel.email" placeholder="请输入邮箱"></i-Input>
                </Form-Item>
                <Form-Item label="角色" prop="roleid">
                    <i-Select @on-change="selectRoleChange"
                            v-model="formModal.bindModel.roleid"
                            :disabled="selectRole.disabled"
                            :placeholder="selectRole.placeholder"
                            :not-found-text="selectRole.notFoundText"
                            :label-in-value="selectRole.labelInValue"
                            :size="selectRole.size"
                            :clearable="selectRole.clearable"
                            :filterable="selectRole.filterable">
                        <i-Option v-for="item in selectRole.dataTable" :value="item.id"
                                  :key="item.id">{{ item.label }}</i-Option>
                    </i-Select>
                </Form-Item>
                <Form-Item label="部门" prop="departid">
                    <i-Select  @on-change="selectDepartChange"
                            v-model="formModal.bindModel.departid"
                            :disabled="selectDepart.disabled"
                            :placeholder="selectDepart.placeholder"
                            :not-found-text="selectDepart.notFoundText"
                            :label-in-value="selectDepart.labelInValue"
                            :size="selectDepart.size"
                            :clearable="selectDepart.clearable"
                            :filterable="selectDepart.filterable">
                        <i-Option v-for="item in selectDepart.dataTable" :value="item.id"
                                  :key="item.id">{{ item.label }}</i-Option>
                    </i-Select>
                </Form-Item>
                <Form-Item label="职位" prop="office">
                    <i-Select
                               v-model="formModal.bindModel.office"
                               :disabled="selectOffice.disabled"
                               :placeholder="selectOffice.placeholder"
                               :not-found-text="selectOffice.notFoundText"
                               :label-in-value="selectOffice.labelInValue"
                               :size="selectOffice.size" :clearable="selectOffice.clearable"
                               :filterable="selectOffice.filterable">
                        <i-Option v-for="item in selectOffice.dataTable" :value="item.value"
                                  :key="item.value">{{ item.value }}</i-Option>
                    </i-Select>
                </Form-Item>
                <Form-Item label="状态" prop="state">
                    <i-Select
                               v-model="formModal.bindModel.state"
                               :disabled="selectState.disabled"
                               :placeholder="selectState.placeholder"
                               :not-found-text="selectState.notFoundText"
                               :label-in-value="selectState.labelInValue"
                               :size="selectState.size" :clearable="selectState.clearable"
                               :filterable="selectState.filterable">
                        <i-Option v-for="item in selectState.dataTable" :value="item.value"
                                  :key="item.value">{{ item.value }}</i-Option>
                    </i-Select>
                </Form-Item>
            </i-Form>
            <Spin size="large" fix v-if="formModal.spinShow"></Spin>
        </div>
        <div slot="footer">
            <Dropdown placement="top" @on-click="formModalDropdownClick">
                <i-Button type="text" size="large" @click="formModalCancel">
                    取消
                    <Icon type="arrow-down-b"></Icon>
                </i-Button>
                <Dropdown-Menu slot="list">
                    <Dropdown-Item name="reset">重置</Dropdown-Item>
                    <Dropdown-Item name="refresh" divided>刷新</Dropdown-Item>
                </Dropdown-Menu>
            </Dropdown>
            <i-Button type="primary" size="large"  @click="formModalOk"
                      v-show="formModal.okButShow"
                      :loading="formModal.okButLoading" >确定</i-Button>
        </div>
    </Modal>

    <Modal v-model="headImg.showHeadImage">
        <p slot="header" class="my-modal-title">
            <Icon type="image"></Icon>
            <span>头像查看</span>
        </p>
        <img :src="headImg.url" alt="" v-if="headImg.showHeadImage" style="width: 100%;">
    </Modal>

    <Modal v-model="headImg.showUpload"  :mask-closable="false" :styles="{top: '20px'}" :width="800">
        <p slot="header" class="my-modal-title">
            <Icon  type="image"></Icon>
            <span>头像上传</span>
        </p>
        <Row class="margin-top-10 image-editor" type="flex" justify="center" align="middle">
            <i-Col span="23">
                    <Row>
                        <i-Col span="12" class="image-editor-con cropper-left">
                            <div class="cropper">
                                <img id="cropimg1" src="../../images/lock.jpg" alt="">
                            </div>
                        </i-Col>
                        <div class="center-split"></div>
                        <i-Col span="12" class="image-editor-con preview-right">
                            <div class="image-editor-con-preview-con">
                                <div id="preview1"></div>
                            </div>
                        </i-Col>
                    </Row>
                    <Row type="flex" justify="center" align="middle">
                        <i-Col span="12">
                            <div class="image-editor-con-btn-con">
                                <input type="file" accept="image/png, image/jpeg, image/gif, image/jpg" @change="handleFileChange" id="fileinput1" class="fileinput" />
                                <label class="filelabel" for="fileinput1"><Icon type="image"></Icon>&nbsp;选择图片</label>
                                <span><i-Button @click="handleUpload" type="primary" icon="upload">上传</i-Button></span>
                            </div>
                        </i-Col>
                    </Row>
            </i-Col>
        </Row>
        <div slot="footer">
            <i-Button  @click="headImg.showUpload=false" type="text" size="large">取消</i-Button>
        </div>
    </Modal>
</div>
</body>
<script>
    window.onload=function() {
        var domain="${ctx}";
        var nomanage=${requestScope.nomanage};
        var corporationId="${requestScope.corporationId}";
        var usersExport_url=domain+"/export/exportUsers?jwt=${requestScope.jwt}";
        var usersInsert_url=domain+"/users/insert?jwt=${requestScope.jwt}";
        var usersUpdate_url=domain+"/users/update?jwt=${requestScope.jwt}";
        var usersDelete_url=domain+"/users/delete?jwt=${requestScope.jwt}";
        var corporation_Select_url="${ctx}/corporation/vselect/selectCorporation?jwt=${requestScope.jwt}";
        var dataDictionary_Select_url="${ctx}/dataDictionary/vselect/selectDataDictionaryValue?jwt=${requestScope.jwt}";
        var department_Select_url="${ctx}/department/vselect/selectDepartment?jwt=${requestScope.jwt}";
        var role_Select_url="${ctx}/role/vselect/selectRole?jwt=${requestScope.jwt}";

        var pageHelperUsers=new pageHepler("${ctx}/users/pagination?jwt=${requestScope.jwt}",{
            elementid:"usersTable",
            columns: [
                {
                    title: '序号',
                    key: 'id',
                    width:100
                },
                {
                    title: '登录名称',
                    key: 'loginname'
                },
                {
                    title: '姓名',
                    key: 'name'
                },
                {
                    title: '电话',
                    key: 'phone',
                    width:200
                },
                {
                    title: '邮件',
                    key: 'email',
                    width:200
                },
                {
                    title: '职位',
                    key: 'office'
                },
                {
                    title: '状态',
                    key: 'state'
                },
                {
                    title: '部门',
                    key: 'departName'
                },
                {
                    title: '角色',
                    key: 'roleName'
                },
                {
                    title: '组织',
                    key: 'corporationName'
                },
                {
                    title: '头像',
                    key: 'img',
                    width:100,
                    render: (h, params) => {
                        return h("div",{
                            attrs:{
                                class:'outer'
                            },
                            on: {
                                click: () => {
                                    vueUser.showHeadImg(domain+"/"+(!params.row.img?'images/lock.jpg':params.row.img));
                                }
                            }
                        },[
                            h('img',{
                                attrs:{
                                    src:domain+"/"+(!params.row.img?'images/lock.jpg':params.row.img)
                                }
                            })
                        ]);
                    }
                }
            ]
        },{orderBy:" u.id desc "});

        var selectHelperCorporation=new selectHelper(corporation_Select_url,{});

        var selectHelperQueryDepartment= new selectHelper(department_Select_url,{});

        var selectHelperDictOffice=new selectHelper(dataDictionary_Select_url,{selectItem:"未绑定",clearable:false});

        var selectHelperDictState=new selectHelper(dataDictionary_Select_url,{selectItem:"未绑定",clearable:false});

        var selectHelperDepartment= new selectHelper(department_Select_url,{selectItem:"未绑定",clearable:false});

        var selectHelperRole=new selectHelper(role_Select_url,{selectItem:"未绑定"});

        var vueUser=new Vue({
            el: '#app',
            data: {
                jwt:"${requestScope.jwt}",
                butShow:${requestScope.rightBut},
                headImg:{
                    showHeadImage:false,
                    showUpload:false,
                    url:""
                },
                cropper1: null,
                formModal:{
                    title:"",
                    spinShow:false,
                    modalShow:false,
                    okButShow:true,
                    okButLoading:false,
                    isAddStatus:true,
                    bindModel:{
                        id:undefined,
                        corporationid:undefined,
                        departid:undefined,
                        roleid:undefined,
                        loginname:"",
                        password:"",
                        name:"",
                        phone:"",
                        email:"",
                        state:"",
                        office:"",
                        roleName:"",
                        departName:""
                    },
                    ruleValidate:{
                        name: [
                            { required: true, message: '名称不能为空', trigger: 'blur' }
                        ],
                        loginname: [
                            { required: true, message: '登录名称不能为空', trigger: 'blur' }
                        ],
                        password: [
                            { required: true, message: '密码名称不能为空', trigger: 'blur' },
                            { type: 'string', min: 6, message: '密码长度不能少于6', trigger: 'blur' }
                        ],
                        state: [
                            { required: true, message: '状态不能为空', trigger: 'blur' }
                        ],
                        office: [
                            { required: true, message: '职位不能为空', trigger: 'blur' }
                        ],
                        departid: [
                            { type:'number', required: true, message: '部门不能为空', trigger: 'blur' }
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
                selectRole:selectHelperRole.ivSelect,
                selectDepart:selectHelperDepartment.ivSelect,
                selectOffice:selectHelperDictOffice.ivSelect,
                selectState:selectHelperDictState.ivSelect,
                selectQueryDepart:selectHelperQueryDepartment.ivSelect,
                selectCorporation:selectHelperCorporation.ivSelect,
                usersTable:pageHelperUsers.ivTable,
                usersPage:pageHelperUsers.ivPage
            },
            created:function(){

            },
            mounted:function () {
                //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
                pageHelperUsers.setHeight($(".my-layout-body").height());
                //权限控制
                if(nomanage) {
                    //加载选择框
                    selectHelperDepartment.load("corporationId='" + corporationId + "'");
                    selectHelperRole.load("corporationId='" + corporationId + "'");
                    selectHelperQueryDepartment.load("corporationId='" + corporationId + "'");

                    //加载组织机构
                    selectHelperCorporation.load("id="+corporationId+"");
                    selectHelperCorporation.setSelectItem(parseInt(corporationId));
                    selectHelperCorporation.setDisabled(true);
                }
                else{
                    //表格加载数据
                    pageHelperUsers.load(null);
                    //加载组织机构
                    selectHelperCorporation.load(null);
                }
                //加载字典数据
                selectHelperDictOffice.load("dkey='用户职位'");
                selectHelperDictState.load("dkey='用户状态'");
            },
            methods:{
                handleFileChange (e) {
                    let file = e.target.files[0];
                    let reader = new FileReader();
                    reader.onload = () => {
                        this.cropper1.replace(reader.result);
                        reader.onload = null;
                    };
                    reader.readAsDataURL(file);
                },
                handleUpload(){
                    var vue=this;
                    // Upload cropped image to server if the browser supports `HTMLCanvasElement.toBlob`
                    this.cropper1.getCroppedCanvas().toBlob(function (blob) {
                        var formData = new FormData();
                        formData.append('upload', blob);
                        formData.append('useid',pageHelperUsers.getSelectRowData().id);
                        $.ajax('${ctx}/upload/headImageUpload', {
                            method: "POST",
                            data: formData,
                            processData: false,
                            contentType: false,
                            success: function (res) {
                                vtoast(vue,res.tip);
                                vue.headImg.showUpload=false;
                                vue.headImg.showHeadImage=true;
                                vue.headImg.url=domain+"/"+res.data.url;
                                //render中已经有domain
                                pageHelperUsers.getSelectRowData().img=res.data.url;
                            },
                            error: function () {
                                console.log('Upload error');
                            }
                        });
                    });
                },
                showHeadImg(url){
                    this.headImg.showHeadImage=true;
                    this.headImg.url=url;
                },
                pageChangeUsers(index){
                    pageHelperUsers.pageIndexChanging(index);
                },
                pageSizeChangeUsers(pageSize){
                    pageHelperUsers.pageIndexChanging(1);
                },
                tableUsersRowClick(data,index){
                    pageHelperUsers.setSelectRowIndex(index);
                },
                selectCorporationChange(option){
                    if(isBlank(option)||isBlank(option.value)) {
                        pageHelperUsers.load(null);
                    }
                    else{
                        pageHelperUsers.load("u.corporationId='" + option.value + "'");
                        selectHelperDepartment.load("corporationId='" + option.value + "'");
                        selectHelperRole.load("corporationId='" + option.value + "'");
                        selectHelperQueryDepartment.load("corporationId='" + option.value + "'");
                    }
                },
                selectQueryDepartChange(option){
                    if(isBlank(option)||isBlank(option.value)) {
                        pageHelperUsers.load("u.corporationId='" + selectHelperCorporation.getSelectItem() + "'");
                    }
                    else{
                        pageHelperUsers.load("u.corporationId='" + selectHelperCorporation.getSelectItem() + "' and u.departId='"+option.value+"'");
                    }
                },
                selectDepartChange(option){
                    this.formModal.bindModel.departName=option.label;
                },
                selectRoleChange(option){
                    this.formModal.bindModel.roleName=option.label;
                },
                butAdd(){
                    if(selectHelperCorporation.getSelectItem()) {
                        this.$refs['formModal.bindModel'].resetFields();
                        this.formModal.modalShow = true;
                        this.formModal.isAddStatus = true;
                        this.formModal.okButShow = true;
                        this.formModal.title = "增加用户";
                    }
                    else{
                        valert(this,"请选择组织机构");
                    }
                },
                butEdit(){
                    if(selectHelperCorporation.getSelectItem()) {
                        if (pageHelperUsers.getSelectRowIndex() > -1) {
                            this.$refs['formModal.bindModel'].resetFields();
                            this.formModal.modalShow = true;
                            this.formModal.okButShow = true;
                            this.formModal.isAddStatus = false;
                            this.formModal.spinShow=true;
                            this.formModal.title = "修改用户";
                            let rowData = pageHelperUsers.getSelectRowData();
                            let vue = this;
                            //延迟500毫秒,等待resetFields执行完毕。
                            setTimeout(() => {
                                $.each(rowData, function (key, value) {
                                    if (typeof vue.formModal.bindModel[key] != undefined) {
                                        vue.formModal.bindModel[key] = value;
                                    }
                                });
                                vue.formModal.spinShow=false;
                            },500);
                        }
                        else {
                            valert(this, "请选择一行记录修改");
                        }
                    }
                    else{
                        valert(this,"请选择组织机构");
                    }
                },
                butDel(){
                    if(pageHelperUsers.getSelectRowIndex()>-1){
                        vconfirm(this,"确认删除吗？",()=>{
                            let rowData=pageHelperUsers.getSelectRowData();
                            vajaxPost(usersDelete_url,{id:rowData.id},false,(result)=>{
                                if(result&&result.success){
                                    pageHelperUsers.deleteSelectedRow();
                                    pageHelperUsers.setSelectRowIndex(-1);
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
                    if(pageHelperUsers.getSelectRowIndex()>-1){
                        this.$refs['formModal.bindModel'].resetFields();
                        this.formModal.modalShow=true;
                        this.formModal.okButShow=false;
                        this.formModal.spinShow=true;
                        this.formModal.title="用户信息";
                        let rowData=pageHelperUsers.getSelectRowData();
                        let vue=this;
                        //延迟500毫秒,等待resetFields执行完毕。
                        setTimeout(() => {
                            $.each(rowData, function (key, value) {
                                if (typeof vue.formModal.bindModel[key] != undefined) {
                                    vue.formModal.bindModel[key] = value;
                                }
                            });
                            vue.formModal.spinShow=false;
                        },500);
                    }
                    else{
                        valert(this,"请选择一行记录修改");
                    }
                },
                butUploadHead(){
                    if(selectHelperCorporation.getSelectItem()) {
                        if (pageHelperUsers.getSelectRowIndex() > -1) {
                            this.headImg.showUpload=true;
                            if(!this.cropper1) {
                                setTimeout(() => {
                                    //在初始化裁减前不能隐藏modal
                                    this.cropper1 = new Cropper(document.getElementById('cropimg1'), {
                                        aspectRatio: 1 / 1,
                                        dragMode: 'move',
                                        preview: '#preview1',
                                        restore: false,
                                        center: false,
                                        highlight: false,
                                        cropBoxMovable: true,
                                        toggleDragModeOnDblclick: false
                                    });
                                },200);
                            }
                        }
                        else {
                            valert(this, "请选择一行记录修改");
                        }
                    }
                    else{
                        valert(this,"请选择组织机构");
                    }
                },
                butExport(){
                    pageHelperUsers.export(usersExport_url,this);
                },
                butRefresh(){
                    window.location.reload();
                },
                formModalDropdownClick(name){
                    if(name=="reset"){
                        this.$refs['formModal.bindModel'].resetFields();
                    }
                    else if(name=="refresh"){
                        selectHelperDepartment.reload();
                        selectHelperRole.reload();
                    }
                },
                formModalCancel(){
                    this.formModal.modalShow=false;
                    this.formModal.okButLoading=false;
                },
                formModalOk(){
                    this.$refs['formModal.bindModel'].validate((valid) => {
                        if (valid) {
                            let vue=this;
                            let url= this.formModal.isAddStatus?usersInsert_url:usersUpdate_url;
                            let data=this.formModal.bindModel;

                            if(this.formModal.isAddStatus){
                                data["id"]=null;
                                data["corporationid"]=selectHelperCorporation.getSelectItem();
                            }
                            else{
                                if(data["roleid"]=="")  data["roleid"]=0;
                            }

                            vajaxPost(url,data,true,(result)=>{
                                if(result&&result.success){
                                    vtoast(vue,result.tip);
                                    vue.formModal.modalShow=false;
                                    if(vue.formModal.isAddStatus){
                                        pageHelperUsers.pageIndexChanging(1);
                                    }
                                    else{
                                        let rowData= pageHelperUsers.getSelectRowData();
                                        $.each(data,function(key,value){
                                            if(typeof rowData[key]!=undefined){
                                                rowData[key]=value;
                                            }
                                        });
                                        pageHelperUsers.setHighlightRow();
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