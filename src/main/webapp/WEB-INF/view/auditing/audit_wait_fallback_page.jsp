<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>撤销审核</title>
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
                <i-Table :height="WaitAuditTable.height"
                         :width="WaitAuditTable.width"
                         :show-header="WaitAuditTable.showHeader"
                         :loading="WaitAuditTable.pageLoading"
                         :stripe="WaitAuditTable.showStripe"
                         :border="WaitAuditTable.showBorder"
                         :highlight-row="WaitAuditTable.highlightRow"
                         :size="WaitAuditTable.tableSize"
                         :columns="WaitAuditTable.columns"
                         :data="WaitAuditTable.dataTable"
                         @on-row-click="tableWaitAuditRowClick"></i-Table>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col  span="6"></i-col>
            <i-col  span="18">
                <div class="float-right">
                    <Page @on-change="pageChangeWaitAudit"
                          @on-page-size-change="pageSizeChangeWaitAudit"
                          :page-size="WaitAuditPage.pageSize"
                          :page-size-opts="WaitAuditPage.pageSizeOpts"
                          :placement="WaitAuditPage.placement"
                          :current:="WaitAuditPage.pageNo"
                          :total="WaitAuditPage.totalCount"
                          :show-elevator="WaitAuditPage.showElevator"
                          :show-total="WaitAuditPage.showTotal"
                          :show-sizer="WaitAuditPage.showSizer"></Page>
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
                <Form-Item label="审核类型" prop="kid">
                    <i-Select  v-model="queryModal.bindModel.kid"
                               :disabled="selectAuditKind.disabled"
                               :placeholder="selectAuditKind.placeholder"
                               :not-found-text="selectAuditKind.notFoundText"
                               :label-in-value="selectAuditKind.labelInValue"
                               :size="selectAuditKind.size" :clearable="selectAuditKind.clearable"
                               :filterable="selectAuditKind.filterable">
                        <i-Option v-for="item in selectAuditKind.dataTable" :value="item.id"
                                  :key="item.id">{{ item.label }}</i-Option>
                    </i-Select>
                </Form-Item>
                <Form-Item label="送审人" prop="sendUser">
                    <i-Input  v-model="queryModal.bindModel.sendUser" placeholder="请输入送审人"></i-Input>
                </Form-Item>
                <Form-Item label="结束时间">
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
    var opinion_url=domain+"/auditKindProcess/path/cancelAudit?jwt=${requestScope.jwt}";
    var auditKind_Select_url="${ctx}/auditKind/vselect/selectAuditKind?jwt=${requestScope.jwt}";
    var corporation_Select_url="${ctx}/corporation/vselect/selectCorporation?jwt=${requestScope.jwt}";

    var pageHelperWaitAudit=new pageHepler("${ctx}/auditWait/pagination?jwt=${requestScope.jwt}",{
        columns: [
            {
                title: '序号',
                key: 'id'
            },
            {
                title:"送审内容",
                key:"content"
            },
            {
                title: '送审时间',
                key: 'createdate'
            },
            {
                title: '结束时间',
                key: 'enddate'
            },
            {
                title: '送审人',
                key: 'senduser'
            },
            {
                title:"送审部门",
                key:"senddepart"
            },
            {
                title:"送审类型",
                key:"kname"
            },
            {
                title:"审核状态",
                key:"status"
            },
            {
                title:"操作",
                key:"url",
                width: 150,
                align: 'center',
                render: (h, params) => {
                    return h('div', [
                        h('Button', {
                            props: {
                                type: 'success',
                                size: 'small'
                            },
                            on: {
                                click: () => {
                                    vPopWindowShow("action_cancel_audit",opinion_url,"撤销审核",params.row);
                                }
                            }
                        }, '撤销')
                    ]);
                }
            }
        ]
    },{whereInner:" aw.status='"+vLang.audit.pass+"' "});

    var selectHelperCorporation=new selectHelper(corporation_Select_url,{});

    var selectHelperAuditKind=new selectHelper(auditKind_Select_url,{vModel:false});

    new Vue({
        el: '#app',
        data: {
            spinShow:false,
            jwt:"${requestScope.jwt}",
            useid:"${requestScope.useId}",
            butShow:${requestScope.rightBut},
            queryModal:{
                title:"条件查询",
                modalShow:false,
                okButShow:true,
                okButLoading:false,
                bindModel:{
                    kid:undefined,
                    sendUser:"",
                    sDate:"",
                    eDate:""
                },
                ruleValidate:{}
            },
            selectAuditKind:selectHelperAuditKind.ivSelect,
            selectCorporation:selectHelperCorporation.ivSelect,
            WaitAuditTable:pageHelperWaitAudit.ivTable,
            WaitAuditPage:pageHelperWaitAudit.ivPage
        },
        created:function(){

        },
        mounted:function () {
            pageHelperWaitAudit.setHeight($(".my-layout-body").height());
            if(nomanage){
                //加载组织机构
                selectHelperCorporation.load("id='"+corporationId+"'");
                selectHelperCorporation.setSelectItem(parseInt(corporationId));
                selectHelperCorporation.setDisabled(true);

                //加载审核类型
                selectHelperAuditKind.load(null);
            }
            else{

                //加载组织机构
                selectHelperCorporation.load(null);

                //加载审核类型
                selectHelperAuditKind.load(null);

                //加载审核记录
                pageHelperWaitAudit.load(null);
            }
        },
        methods:{
            pageChangeWaitAudit(index){
                pageHelperWaitAudit.pageIndexChanging(index);
            },
            pageSizeChangeWaitAudit(pageSize){
                pageHelperWaitAudit.pageIndexChanging(1,pageSize);
            },
            tableWaitAuditRowClick(data,index){
                pageHelperWaitAudit.setSelectRowIndex(index);
            },
            selectCorporationChange(option){
                if(isBlank(option)||isBlank(option.value)){
                    pageHelperWaitAudit.load(null);
                }
                else {
                    pageHelperWaitAudit.load("u.corporationId='"+option.value+"'");
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
            queryModalOk() {
                this.$refs['queryModal.bindModel'].validate((valid) => {
                    if (valid) {
                        let WR = [];
                        WR[WR.length] = new whereRelation("u.corporationId", this.selectCorporation.selectItem, "int", null, "=", true);
                        WR[WR.length] = new whereRelation("k.id", this.queryModal.bindModel.kid, "int", null, "=", true);
                        WR[WR.length] = new whereRelation("u.name", this.queryModal.bindModel.sendUser, "string", null, null, true);
                        WR[WR.length] = new whereRelation("aw.endDate", vDateFormat(this.queryModal.bindModel.sDate,"yyyy-MM-dd HH:mm:ss"), "datatime", vDateFormat(this.queryModal.bindModel.eDate,"yyyy-MM-dd HH:mm:ss"), null, true);
                        pageHelperWaitAudit.load(new pageHelperWhere(WR).getWhere());
                        this.queryModal.modalShow = false;
                    }
                    else {
                        valert(this, '表单验证失败!');
                    }
                });
            }
        }
    });

    /**
     * 全局弹出窗体回调
     * @param action
     * @param parameter
     */
    function popupsCallBack(action,parameter){
        if(action=="action_cancel_audit"){
            pageHelperWaitAudit.pageIndexChanging(1);
        }
        else {
            return ;
        }
    }
</script>
</html>