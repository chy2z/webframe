<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<%@ include file="../../../taglib/import_audit.jsp"%>
<head>
    <title>审核流程选择</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">
    <div class="my-layout">
        <Row class-name="my-layout-top" align="middle" type="flex">
            <i-col span="24">
                <div class="float-left fil-width">
                    <Row align="middle" type="flex">
                        <i-col>
                            <label class="my-label">送审业务：</label>
                            <label class="my-label">{{ operation }}</label>
                        </i-col>
                    </Row>
                </div>
            </i-col>
        </Row>
        <Row class-name="my-layout-body padding-2" justify="center" type="flex">
            <i-col span="12">
                <div class="ivu-card-padding ivu-card-body-padding">
                    <Card>
                        <p slot="title">审核类型</p>
                        <div class="my-layout my-layout-clear-top">
                            <Row class-name="my-layout-body my-layout-body-left"  type="flex">
                                <i-col span="24">
                                    <i-Table :height="processTable.height"
                                             :width="processTable.width"
                                             :show-header="processTable.showHeader"
                                             :loading="processTable.pageLoading"
                                             :stripe="processTable.showStripe"
                                             :border="processTable.showBorder"
                                             :highlight-row="processTable.highlightRow"
                                             :size="processTable.tableSize"
                                             :columns="processTable.columns"
                                             :data="processTable.dataTable"
                                             @on-row-click="tableProcessRowClick"></i-Table>
                                </i-col>
                            </Row>
                            <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                                <i-col span="24">
                                    <div class="float-right">
                                        <Page @on-change="pageChangeProcess"
                                              @on-page-size-change="pageSizeChangeProcess"
                                              :page-size="processPage.pageSize"
                                              :page-size-opts="processPage.pageSizeOpts"
                                              :placement="processPage.placement"
                                              :current:="processPage.pageNo"
                                              :total="processPage.totalCount"
                                              :show-elevator="processPage.showElevator"
                                              :show-total="processPage.showTotal"
                                              :show-sizer="processPage.showSizer"></Page>
                                    </div>
                                </i-col>
                            </Row>
                        </div>
                    </Card>
                </div>
            </i-col>
            <i-col span="12">
                <div class="ivu-card-padding ivu-card-body-padding">
                    <Card>
                        <p slot="title">审核步骤</p>
                        <div class="my-layout my-layout-clear-top">
                            <Row class-name="my-layout-body my-layout-body-right"  type="flex">
                                <i-col span="24">
                                    <i-Table :height="stepTable.height"
                                             :width="stepTable.width"
                                             :show-header="stepTable.showHeader"
                                             :loading="stepTable.pageLoading"
                                             :stripe="stepTable.showStripe"
                                             :border="stepTable.showBorder"
                                             :highlight-row="stepTable.highlightRow"
                                             :size="stepTable.tableSize"
                                             :columns="stepTable.columns"
                                             :data="stepTable.dataTable"
                                    >
                                    </i-Table>
                                </i-col>
                            </Row>
                            <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                                <i-col span="24">
                                    <div class="float-right">
                                        <Page
                                                :page-size="stepPage.pageSize"
                                                :page-size-opts="stepPage.pageSizeOpts"
                                                :placement="stepPage.placement"
                                                :current:="stepPage.pageNo"
                                                :total="stepPage.totalCount"
                                                :show-elevator="stepPage.showElevator"
                                                :show-total="stepPage.showTotal"
                                                :show-sizer="stepPage.showSizer"></Page>
                                    </div>
                                </i-col>
                            </Row>
                        </div>
                    </Card>
                </div>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col span="6"></i-col>
            <i-col span="18">
                <div class="float-right">
                    <i-Button type="success" @click="butRefresh()" icon="refresh">刷新</i-Button>
                    <i-Button type="error" @click="butFlowChart()" v-show="flowState" icon="android-share-alt">流程图</i-Button>
                    <i-Button type="primary" @click="butSave()" :disabled="saveState" icon="ios-shuffle-strong">送审</i-Button>
                </div>
            </i-col>
        </Row>
    </div>
</div>
</body>
<script>
    var domain="${ctx}";
    var flowChartStep_url=domain+"/auditKindProcess/path/flowStepView?jwt=${requestScope.jwt}";

    var pageHelperProcess=new pageHepler("${ctx}/auditKindProcess/pagination?jwt=${requestScope.jwt}",{
        columns: [
            {
                title: '序号',
                key: 'id'
            },
            {
                title: '流程名称',
                key: 'pname'
            },
            {
                title: '审核类型',
                key: 'auditkind'
            },
            {
                title: '部门',
                key: 'departname'
            },
            {
                title: '状态',
                key: 'enable',
                render: (h, params) => {
                    return h("div",{
                        style: {
                            color: params.row.enable=="启用"?'green':'blue'
                        }
                    },[
                        h('strong', params.row.enable)
                    ]);
                }
            },
            {
                title: '步骤数',
                key: 'stepnum'
            }
        ]
    },{orderBy:" ap.id desc "});

    var pageHelperStep=new pageHepler("${ctx}/auditKindProcessStep/pagination?jwt=${requestScope.jwt}",{
        columns: [
            {
                title: '步骤',
                key: 'step'
            },
            {
                title: '审核人',
                key: 'uname'
            },
            {
                title: '角色',
                key: 'rolename'
            },
            {
                title: '部门',
                key: 'departname'
            }
        ]
    },{orderBy:" aps.step asc "});

    new Vue({
        el: '#app',
        data: {
            jwt:"${requestScope.jwt}",
            useid:"${requestScope.user.id}",
            departid:"${requestScope.user.departid}",
            operation:"${requestScope.auditKind.operation}",
            kid:"${requestScope.auditKind.id}",
            flowState:false,
            saveState:true,
            processTable:pageHelperProcess.ivTable,
            processPage:pageHelperProcess.ivPage,
            stepTable:pageHelperStep.ivTable,
            stepPage:pageHelperStep.ivPage
        },
        created:function(){
            Audit.initConfig(this,domain,this.jwt,this.operation,this.useid,this.departid);
        },
        mounted:function () {
            //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
            pageHelperProcess.setHeight($(".my-box-left .my-layout-body-left").height());
            //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
            pageHelperStep.setHeight($(".my-box-right .my-layout-body-right").height());
            //加载表格数据
            pageHelperProcess.load(" ap.departId='"+this.departid+"' and ap.kId='"+this.kid+"' ");
        },
        methods:{
            pageChangeProcess(index){
                pageHelperProcess.pageIndexChanging(index);
            },
            pageSizeChangeProcess(pageSize){
                pageHelperProcess.pageIndexChanging(1,pageSize);
            },
            tableProcessRowClick(data,index){
                pageHelperProcess.setSelectRowIndex(index);
                pageHelperStep.load(" ap.id='" + data.id + "' ");
                if(data.enable=="启用") {
                    this.saveState=false;
                }
                else{
                    this.saveState=true;
                    vtoast(this,"审核类型被禁用");
                }
            },
            butRefresh(){
                window.location.reload();
            },
            butFlowChart(){
                if(pageHelperProcess.getSelectRowIndex()>-1){
                    let rowData=pageHelperProcess.getSelectRowData();
                    vOpenWindow(flowChartStep_url+"&id="+rowData.id);
                }
                else{
                    valert(this,"请选择一行记录");
                }
            },
            butSave(){
                Audit.selectAudit(this,pageHelperProcess.getSelectRowIndex(),pageHelperProcess.getSelectRowData(),()=>{
                      vPopWindowsColse({auditstate:vLang.audit.process});
                });
            }
        }
    });

</script>
</html>
