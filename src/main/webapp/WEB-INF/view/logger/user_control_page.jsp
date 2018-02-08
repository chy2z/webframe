<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<%@ include file="../../../taglib/import_audit.jsp"%>
<html>
<head>
    <title>用户操作日志</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">
    <Spin size="large" fix v-if="spinShow"></Spin>
    <div class="my-layout">
        <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
            <i-col span="10">
                <div class="float-left">
                    <label class="my-label">组织机构：</label>
                    <i-Select  style="width:200px"
                               @on-change="selectCorporationChange"
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
                <i-Table :height="logTable.height"
                         :width="logTable.width"
                         :show-header="logTable.showHeader"
                         :loading="logTable.pageLoading"
                         :stripe="logTable.showStripe"
                         :border="logTable.showBorder"
                         :highlight-row="logTable.highlightRow"
                         :size="logTable.tableSize"
                         :columns="logTable.columns"
                         :data="logTable.dataTable"
                         @on-row-click="tableLogRowClick"></i-Table>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col  span="6"></i-col >
            <i-col  span="18">
                <div class="float-right">
                    <Page @on-change="pageChangeLog"
                          @on-page-size-change="pageSizeChangeLog"
                          :page-size="logPage.pageSize"
                          :page-size-opts="logPage.pageSizeOpts"
                          :placement="logPage.placement"
                          :current:="logPage.pageNo"
                          :total="logPage.totalCount"
                          :show-elevator="logPage.showElevator"
                          :show-total="logPage.showTotal"
                          :show-sizer="logPage.showSizer"></Page>
                </div>
            </i-col>
        </Row>
    </div>

    <Modal v-model="queryModal.modalShow" :mask-closable="false" :styles="{top: '20px'}" :width="500">
        <p slot="header" class="my-modal-title">
            <Icon type="search"></Icon>
            <span>{{queryModal.title}}</span>
        </p>
        <div>
            <i-Form ref="queryModal.bindModel" :model="queryModal.bindModel" :rules="queryModal.ruleValidate"
                    label-position="right" label-width="70">
                <Form-Item label="登录姓名" prop="uName">
                    <i-Input v-model="queryModal.bindModel.uName" placeholder="请输入登录人"></i-Input>
                </Form-Item>
                <Form-Item label="登录令牌" prop="uToken">
                    <i-Input v-model="queryModal.bindModel.uToken" placeholder="请输入登录令牌"></i-Input>
                </Form-Item>
                <Form-Item label="功能模块" prop="name">
                    <i-Input v-model="queryModal.bindModel.name" placeholder="请输入登录令牌"></i-Input>
                </Form-Item>
                <Form-Item label="登录时间">
                    <Row>
                        <i-Col span="11">
                            <Form-Item prop="sDate">
                                <Date-Picker type="datetime" format="yyyy-MM-dd HH:mm"  v-model="queryModal.bindModel.sDate"  placeholder="选择开始时间"></Date-Picker>
                            </Form-Item>
                        </i-Col>
                        <i-Col span="2" style="text-align: center">-</i-Col>
                        <i-Col span="11">
                            <Form-Item prop="eDate">
                                <Date-Picker type="datetime" format="yyyy-MM-dd HH:mm"  v-model="queryModal.bindModel.eDate"  placeholder="选择结束时间"></Date-Picker>
                            </Form-Item>
                        </i-Col>
                    </Row>
                </Form-Item>
                <Form-Item label="模糊查询" prop="likeState">
                    <i-Switch size="large" v-model="queryModal.bindModel.likeState">
                        <span slot="open">模糊</span>
                        <span slot="close">精确</span>
                    </i-Switch>
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
    var domain="${ctx}";
    var nomanage=${requestScope.nomanage};
    var corporationId="${requestScope.corporationId}";
    var corporation_Select_url="${ctx}/corporation/vselect/selectCorporation?jwt=${requestScope.jwt}";

    var pageHelperLogger=new pageHepler("${ctx}/userControlLog/pagination?jwt=${requestScope.jwt}",{
        columns: [
            {
                title: '序号',
                key: 'id'
            },
            {
                title: '姓名',
                key: 'uName'
            },
            {
                title: '部门',
                key: 'departName'
            },
            {
                title: '模块',
                key: 'name'
            },
            {
                title: '路径',
                key: 'url',
                width:350
            },
            {
                title: '令牌',
                key: 'token',
                width:350
            },
            {
                title: '操作时间',
                key: 'createdate',
                width:200
            }
        ]
    },{orderBy:" l.id desc ",rightRecord:"${requestScope.rightRecord}"});

    var selectHelperCorporation=new selectHelper(corporation_Select_url,{});

    new Vue({
        el: '#app',
        data: {
            spinShow:false,
            jwt:"${requestScope.jwt}",
            butShow:${requestScope.rightBut},
            recordShow:"${requestScope.rightRecord}",
            queryModal:{
                title:"条件查询",
                modalShow:false,
                okButShow:true,
                okButLoading:false,
                bindModel:{
                    uName:"",
                    uToken:"",
                    name:"",
                    sDate:"",
                    eDate:"",
                    likeState:true
                },
                ruleValidate:{}
            },
            selectCorporation:selectHelperCorporation.ivSelect,
            logTable:pageHelperLogger.ivTable,
            logPage:pageHelperLogger.ivPage
        },
        created:function(){

        },
        mounted:function () {
            //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
            pageHelperLogger.setHeight($(".my-layout-body").height());
            //权限控制
            if(nomanage) {
                //加载组织机构
                selectHelperCorporation.load("id='"+corporationId+"'");
                selectHelperCorporation.setSelectItem(parseInt(corporationId));
                selectHelperCorporation.setDisabled(true);
            }
            else{
                //表格加载数据
                pageHelperLogger.load(null);

                //加载组织机构
                selectHelperCorporation.load(null);
            }
        },
        methods:{
            pageChangeLog(index){
                pageHelperLogger.pageIndexChanging(index);
            },
            pageSizeChangeLog(pageSize){
                pageHelperLogger.pageIndexChanging(1,pageSize);
            },
            tableLogRowClick(data,index){
                pageHelperLogger.setSelectRowIndex(index);
            },
            selectCorporationChange(option){
                if(isBlank(option)||isBlank(option.value)) {
                    pageHelperLogger.load(null);
                }
                else{
                    pageHelperLogger.load("u.corporationId='" + option.value + "'");
                }
            },
            butRefresh(){
                window.location.reload();
            },
            butSearch(){
                this.queryModal.modalShow=true;
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
                        WR[WR.length] = new whereRelation("u.corporationId", selectHelperCorporation.getSelectItem(), "string", null, null, false);
                        WR[WR.length] = new whereRelation("u.name", this.queryModal.bindModel.uName, "string", null, null, this.queryModal.bindModel.likeState);
                        WR[WR.length] = new whereRelation("l.token",this.queryModal.bindModel.uToken , "string", null, null, this.queryModal.bindModel.likeState);
                        WR[WR.length] = new whereRelation("l.name",this.queryModal.bindModel.name , "string", null, null, this.queryModal.bindModel.likeState);
                        WR[WR.length] = new whereRelation("l.createDate", vDateFormat(this.queryModal.bindModel.sDate,"yyyy-MM-dd HH:mm:ss"), "datatime", vDateFormat(this.queryModal.bindModel.eDate,"yyyy-MM-dd HH:mm:ss"), null, false);
                        pageHelperLogger.load(new pageHelperWhere(WR).getWhere());
                        this.queryModal.modalShow=false;
                    }
                    else{
                        valert(this,'表单验证失败!');
                    }
                });
            }
        }
    });

</script>
</html>
