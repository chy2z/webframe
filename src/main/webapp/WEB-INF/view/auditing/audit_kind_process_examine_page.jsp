<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>业务审核</title>
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
                    <label class="my-label">审核业务：</label>
                    <i-Select  style="width:200px" @on-change="selectOperationChange"
                               v-model="selectOperation.selectItem"
                               :disabled="selectOperation.disabled"
                               :placeholder="selectOperation.placeholder"
                               :not-found-text="selectOperation.notFoundText"
                               :label-in-value="selectOperation.labelInValue"
                               :size="selectOperation.size" :clearable="selectOperation.clearable"
                               :filterable="selectOperation.filterable">
                        <i-Option v-for="item in selectOperation.dataTable" :value="item.id"
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
</div>
</body>
<script>
    var domain="${ctx}";
    var nomanage=${requestScope.nomanage};
    var corporationId="${requestScope.corporationId}";
    var look_url=domain+"/sysNotice/path/look?jwt=${requestScope.jwt}";

    var operation_Select_url="${ctx}/auditOperation/vselect/selectAuditOperation?jwt=${requestScope.jwt}";

    var pageHelperWaitAudit=new pageHepler("${ctx}/auditWait/pagination?jwt=${requestScope.jwt}",{
        columns: [
            {
                title: '序号',
                key: 'id'
            },
            {
                title: '送审',
                key: 'senduser'
            },
            {
                title:"部门",
                key:"senddepart"
            },
            {
                title:"送审类型",
                key:"kname"
            },
            {
                title:"业务流程",
                key:"pname"
            },
            {
                title:"操作",
                key:"url"
            }
        ]
    },{whereInner:" aw.status='"+vLang.audit.process+"' "});

    var selectHelperOperation=new selectHelper(operation_Select_url,{});

    new Vue({
        el: '#app',
        data: {
            spinShow:false,
            jwt:"${requestScope.jwt}",
            butShow:${requestScope.rightBut},
            selectOperation:selectHelperOperation.ivSelect,
            WaitAuditTable:pageHelperWaitAudit.ivTable,
            WaitAuditPage:pageHelperWaitAudit.ivPage
        },
        created:function(){
            //Audit.initConfig(this,domain,this.jwt,Audit.operationType.sys_notice,${requestScope.useId},${requestScope.departId});
        },
        mounted:function () {
            //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
            pageHelperWaitAudit.setHeight($(".my-layout-body").height());
            //表格加载数据
            pageHelperWaitAudit.load(null);
            //加载组织机构
            pageHelperWaitAudit.load(null);
        },
        methods:{
            pageChangeWaitAudit(index){
                pageHelperWaitAudit.pageIndexChanging(index);
            },
            pageSizeChangeWaitAudit(pageSize){
                pageHelperWaitAudit.pageIndexChanging(1);
            },
            tableWaitAuditRowClick(data,index){
                pageHelperWaitAudit.setSelectRowIndex(index);
            },
            selectOperationChange(option){
                if(option==null||option.value=="") {
                    pageHelperWaitAudit.load(null);
                }
                else{
                    pageHelperWaitAudit.load(" aw.operation='" + option.value + "'");
                }
            },
            butAudit(){

            },
            butLook(){
                if(pageHelperWaitAudit.getSelectRowIndex()>-1){

                }
                else{
                    valert(this,"请选择一行记录查看");
                }
            },
            butRefresh(){
                window.location.reload();
            }
        }
    });

    /**
     * 全局弹出窗体回调
     * @param action
     * @param parameter
     */
    function popupsCallBack(action,parameter){
        if(action=="action_audit"){
            pageHelperWaitAudit.pageIndexChanging(1);
        }
        else {
            return ;
        }
    }
</script>
</html>