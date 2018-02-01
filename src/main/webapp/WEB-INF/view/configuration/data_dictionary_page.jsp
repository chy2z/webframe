<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../taglib/taglibs.jsp" %>
<%@ include file="../../../taglib/import_iview.jsp" %>
<%@ include file="../../../taglib/import_jquery.jsp" %>
<%@ include file="../../../taglib/import_common.jsp" %>
<html>
<head>
    <title>数据字典</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">
    <Row class-name="my-box" type="flex">
        <i-col span="10">
            <div class="my-layout my-box-left">
                <Row class-name="my-layout-top" justify="end" align="middle" type="flex">
                    <i-col span="14">
                        <div class="float-left">
                            <label class="my-label">字典名称：</label>
                            <i-Select  style="width:200px" @on-change="selectDkeyChange"
                                       v-model="selectDkey.selectItem"
                                       :placeholder="selectDkey.placeholder"
                                       :not-found-text="selectDkey.notFoundText"
                                       :label-in-value="selectDkey.labelInValue"
                                       :size="selectDkey.size" :clearable="selectDkey.clearable"
                                       :filterable="selectDkey.filterable">
                                <i-Option v-for="item in selectDkey.dataTable" :value="item.value"
                                          :key="item.value">{{ item.value }}</i-Option>
                            </i-Select>
                        </div>
                    </i-col>
                    <i-col span="10">

                    </i-col>
                </Row>
                <Row class-name="my-layout-body" type="flex">
                    <i-col class-name="col-left" span="24">
                    <i-Table :height="parentTable.height"
                             :width="parentTable.width"
                             :show-header="parentTable.showHeader"
                             :loading="parentTable.pageLoading"
                             :stripe="parentTable.showStripe"
                             :border="parentTable.showBorder"
                             :highlight-row="parentTable.highlightRow"
                             :size="parentTable.tableSize"
                             :columns="parentTable.columns"
                             :data="parentTable.dataTable"
                             @on-row-click="parentTableRowClick"></i-Table>
                    </i-col>
                </Row>
                <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                    <i-col span="1"></i-col>
                    <i-col span="23">
                        <div class="float-right">
                            <Page @on-change="pageChangeParent"
                                  @on-page-size-change="pageSizeChangeParent"
                                  :page-size="parentPage.pageSize"
                                  :page-size-opts="parentPage.pageSizeOpts"
                                  :placement="parentPage.placement"
                                  :current:="parentPage.pageNo"
                                  :total="parentPage.totalCount"
                                  :show-elevator="parentPage.showElevator"
                                  :show-total="parentPage.showTotal"
                                  :show-sizer="parentPage.showSizer"></Page>

                        </div>
                    </i-col>
                </Row>
            </div>
        </i-col>
        <i-col span="14">
            <div class="my-layout my-box-right">
                <Row class-name="my-layout-top" justify="end" align="middle" type="flex">
                    <i-col span="10"></i-col>
                    <i-col span="14">
                        <div class="float-right">
                            <%@include file="../rightTemplate.jsp" %>
                        </div>
                    </i-col>
                </Row>
                <Row class-name="my-layout-body" type="flex">
                    <i-col class-name="col-right" span="24">
                    <i-Table :height="childTable.height"
                             :width="childTable.width"
                             :show-header="childTable.showHeader"
                             :loading="childTable.pageLoading"
                             :stripe="childTable.showStripe"
                             :border="childTable.showBorder"
                             :highlight-row="childTable.highlightRow"
                             :size="childTable.tableSize"
                             :columns="childTable.columns"
                             :data="childTable.dataTable"
                             @on-row-click="childTableRowClick"></i-Table>
                    </i-col>
                </Row>
                <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                    <i-col span="1"></i-col>
                    <i-col span="23">
                        <div class="float-right">
                            <Page @on-change="pageChangeChild"
                                  @on-page-size-change="pageSizeChangeChild"
                                  :page-size="childPage.pageSize"
                                  :page-size-opts="childPage.pageSizeOpts"
                                  :placement="childPage.placement"
                                  :current:="childPage.pageNo"
                                  :total="childPage.totalCount"
                                  :show-elevator="childPage.showElevator"
                                  :show-total="childPage.showTotal"
                                  :show-sizer="childPage.showSizer"></Page>
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
                    label-position="right" label-width="80" >
                <Form-Item label="字典属性" prop="dvalue">
                    <i-Input v-model="formModal.bindModel.dvalue" placeholder="请输入字典属性"></i-Input>
                </Form-Item>
                <Form-Item label="字典备注" prop="dmemo">
                    <i-Input v-model="formModal.bindModel.dmemo" placeholder="请输入字典备注"></i-Input>
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
    var domain = "${ctx}";
    var dataDictionaryInsert_url="${ctx}/dataDictionary/insert?jwt=${requestScope.jwt}";
    var dataDictionaryUpdate_url="${ctx}/dataDictionary/update?jwt=${requestScope.jwt}";
    var dataDictionaryDelete_url="${ctx}/dataDictionary/delete?jwt=${requestScope.jwt}";
    var pageHelperParent = new pageHepler("${ctx}/dataDictionary/pagination/parent?jwt=${requestScope.jwt}", {
        columns: [
            {
                title: '字典名称',
                key: 'dkey'
            }
        ]
    }, {orderBy: " dkey desc "});

    var pageHelperChild = new pageHepler("${ctx}/dataDictionary/pagination/child?jwt=${requestScope.jwt}", {
        columns: [
            {
                title: '字典属性',
                key: 'dvalue'
            },
            {
                title: '字典备注',
                key: 'dmemo'
            },
            {
                title: '属性',
                key: 'edits',
                width:100,
                render: (h, params) => {
                    return h("div",{
                        attrs: {
                            class: params.row.edits==1?"stateWrite":"stateReadOnly"
                        }
                    },[
                        h('strong',(params.row.edits==1?"编辑":"只读"))
                    ]);
                }
            }
        ]
    }, {pageSize:20,orderBy: " id desc "});

    var selectHelperDkey=new selectHelper("${ctx}/dataDictionary/vselect/selectDataDictionaryDkey?jwt=${requestScope.jwt}",{});

    new Vue({
        el: '#app',
        data: {
            jwt: "${requestScope.jwt}",
            butShow:${requestScope.rightBut},
            formModal:{
                title:"",
                modalShow:false,
                okButShow:true,
                okButLoading:false,
                isAddStatus:true,
                bindModel:{
                    id:null,
                    dkey:null,
                    dvalue:"",
                    dmemo:""
                },
                ruleValidate:{
                    dvalue: [
                        { required: true, message: '字典属性不能为空', trigger: 'blur' }
                    ]
                }
            },
            parentTable: pageHelperParent.ivTable,
            parentPage: pageHelperParent.ivPage,
            childTable: pageHelperChild.ivTable,
            childPage: pageHelperChild.ivPage,
            selectDkey:selectHelperDkey.ivSelect
        },
        created: function () {
        },
        mounted: function () {
            //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
            pageHelperParent.setHeight($(".my-box-left .my-layout-body").height());
            pageHelperChild.setHeight($(".my-box-right .my-layout-body").height());
            //加载表格字典关键字
            pageHelperParent.load(null);
            //加载下拉选择字典关键字
            selectHelperDkey.load(null);
        },
        methods: {
            butRefresh() {
                window.location.reload();
            },
            butAdd(){
                this.$refs['formModal.bindModel'].resetFields();
                this.formModal.modalShow=true;
                this.formModal.isAddStatus=true;
                this.formModal.okButShow=true;
                this.formModal.title="增加字典属性";
            },
            butEdit(){
                if(pageHelperChild.getSelectRowIndex()>-1){
                    if(pageHelperChild.getSelectRowData().edits==1) {
                        this.$refs['formModal.bindModel'].resetFields();
                        this.formModal.modalShow = true;
                        this.formModal.okButShow = true;
                        this.formModal.isAddStatus = false;
                        this.formModal.title = "修改字典属性";
                        let rowData = pageHelperChild.getSelectRowData();
                        let vue = this;
                        $.each(rowData, function (key, value) {
                            if (typeof vue.formModal.bindModel[key] != undefined) {
                                vue.formModal.bindModel[key] = value;
                            }
                        });
                    }
                    else{
                        valert(this,"属性只读禁止修改");
                    }
                }
                else{
                    valert(this,"请选择一行记录修改");
                }
            },
            butDel(){
                if(pageHelperChild.getSelectRowIndex()>-1){
                    if(pageHelperChild.getSelectRowData().edits==1) {
                        vconfirm(this, "确认删除吗？", () => {
                            let rowData = pageHelperChild.getSelectRowData();
                            vajaxPost(dataDictionaryDelete_url, rowData, true, (result) => {
                                if (result && result.success) {
                                    pageHelperChild.deleteSelectedRow();
                                    pageHelperChild.setSelectRowIndex(-1);
                                    vtoast(this, result.tip);
                                }
                                else {
                                    valert(this, result.tip);
                                }
                            });
                        });
                    }
                    else{
                        valert(this,"属性只读禁止删除");
                    }
                }
                else{
                    valert(this,"请选择一行记录删除");
                }
            },
            parentTableRowClick(data, index) {
                pageHelperParent.setSelectRowIndex(index);
                pageHelperChild.load("dkey='" + data.dkey + "'");
            },
            pageChangeParent(index) {
                pageHelperParent.pageIndexChanging(index);
            },
            pageSizeChangeParent(pageSize) {
                pageHelperParent.pageIndexChanging(1);
            },
            childTableRowClick(data, index) {
                pageHelperChild.setSelectRowIndex(index);
            },
            pageChangeChild(index) {
                pageHelperChild.pageIndexChanging(index);
            },
            pageSizeChangeChild() {
                pageHelperChild.pageIndexChanging(1);
            },
            selectDkeyChange(option){
               if(isBlank(option)) {
                   pageHelperParent.load(null);
                   pageHelperChild.clearDataTable();
               }
               else{
                   pageHelperParent.load("dkey='"+option.label+"'");
                   pageHelperChild.load("dkey='" +option.label + "'");
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
                        let url= this.formModal.isAddStatus?dataDictionaryInsert_url:dataDictionaryUpdate_url;
                        let data=this.formModal.bindModel;
                        if(this.formModal.isAddStatus){
                            data["id"]=null;
                            data["dkey"]=pageHelperParent.getSelectRowData().dkey;
                        }
                        vajaxPost(url,data,true,(result)=>{
                            if(result&&result.success){
                                vtoast(vue,result.tip);
                                vue.formModal.modalShow=false;
                                if(vue.formModal.isAddStatus){
                                    pageHelperChild.pageIndexChanging(1);
                                }
                                else{
                                    let rowData= pageHelperChild.getSelectRowData();
                                    $.each(data,function(key,value){
                                        if(rowData[key]!=undefined){
                                            rowData[key]=value;
                                        }
                                    });
                                    pageHelperChild.setHighlightRow();
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