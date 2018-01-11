<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>审核流程</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div class="my-app" id="app">
    <Row class-name="my-box" type="flex">
        <i-col span="14">
            <div class="my-layout my-box-left">
                <Row class-name="my-layout-top" justify="end" align="middle" type="flex">
                    <i-col span="24">
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
                </Row>
                <Row class-name="my-layout-body" type="flex">
                    <i-col class-name="col-left" span="24">
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
                    <i-col span="6"></i-col>
                    <i-col span="18">
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
        </i-col>
        <i-col span="10">
            <div class="my-layout my-box-right">
                <Row class-name="my-layout-top" justify="end" align="middle" type="flex">
                    <i-col span="24">
                        <div class="float-right">
                            <%@include file="../rightTemplate.jsp" %>
                        </div>
                    </i-col>
                </Row>
                <Row class-name="my-layout-body" type="flex">
                    <i-col class-name="col-right" span="24">
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
                    <i-col span="6"></i-col>
                    <i-col span="18">
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
        </i-col>
    </Row>
</div>
</body>
<script>
    var domain="${ctx}";
    var nomanage=${requestScope.nomanage};
    var corporationId="${requestScope.corporationId}";
    var add_url=domain+"/auditKindProcess/path/add?jwt=${requestScope.jwt}";
    var update_url=domain+"/auditKindProcess/path/update?jwt=${requestScope.jwt}";
    var delete_url=domain+"/auditKindProcess/delete?jwt=${requestScope.jwt}";
    var corporation_Select_url="${ctx}/corporation/vselect/selectCorporation?jwt=${requestScope.jwt}";

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
                key: 'enable'
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
                key: 'uname',
                width:300
            }
        ]
    },{orderBy:" aps.step asc "});

    var selectHelperCorporation=new selectHelper(corporation_Select_url,{});

    new Vue({
        el: '#app',
        data: {
            jwt:"${requestScope.jwt}",
            butShow:${requestScope.rightBut},
            selectCorporation:selectHelperCorporation.ivSelect,
            processTable:pageHelperProcess.ivTable,
            processPage:pageHelperProcess.ivPage,
            stepTable:pageHelperStep.ivTable,
            stepPage:pageHelperStep.ivPage
        },
        created:function(){

        },
        mounted:function () {
            //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
            pageHelperProcess.setHeight($(".my-box-left .my-layout-body").height());
            //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
            pageHelperStep.setHeight($(".my-box-right .my-layout-body").height());

            //权限控制
            if(nomanage){
                //加载角色表格数据
                pageHelperProcess.load(" c.id='"+corporationId+"'");
                //加载组织机构
                selectHelperCorporation.load("id='"+corporationId+"'");
                selectHelperCorporation.setSelectItem(parseInt(corporationId));
                selectHelperCorporation.setDisabled(true);
            }
            else{
                //加载角色表格数据
                pageHelperProcess.load(null);
                //加载组织机构
                selectHelperCorporation.load(null);
            }
        },
        methods:{
            selectCorporationChange(option){
                if(option==null||option.value==""){
                    pageHelperProcess.load(null);
                }
                else {
                    pageHelperProcess.load(" c.id='" + option.value + "'");
                }
            },
            pageChangeProcess(index){
                pageHelperProcess.pageIndexChanging(index);
            },
            pageSizeChangeProcess(pageSize){
                pageHelperProcess.pageIndexChanging(1);
            },
            tableProcessRowClick(data,index){
                pageHelperProcess.setSelectRowIndex(index);
                pageHelperStep.load(" ap.id='" + data.id + "' ");
            },
            butAdd(){
                if(isBlank(selectHelperCorporation.getSelectItem())){
                    valert(this,"请选择组织机构");
                }
                else {
                    vPopWindowShow("action_add", add_url, "审核流程增加");
                }
            },
            butEdit(){
                if(pageHelperProcess.getSelectRowIndex()>-1){
                    let rowData=pageHelperProcess.getSelectRowData();
                    vPopWindowShow("action_update",update_url+"&id="+rowData.id,"审核流程修改");
                }
                else{
                    valert(this,"请选择一行记录修改");
                }
            },
            butDel(){
                if(pageHelperProcess.getSelectRowIndex()>-1){
                    vconfirm(this,"确认删除吗？",()=>{
                        let rowData=pageHelperProcess.getSelectRowData();
                        vajaxPost(delete_url,{id:rowData.id},false,(result)=>{
                            if(result&&result.success){
                                pageHelperProcess.deleteSelectedRow();
                                pageHelperProcess.setSelectRowIndex(-1);
                                pageHelperStep.load(" ap.id=0 ");
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
            butFlowChart(){
                window.open()
            }
        }
    });

    /**
     * 全局弹出窗体回调
     * @param action
     * @param parameter
     */
    function popupsCallBack(action,parameter){
        if(action=="action_add"){
            pageHelperProcess.pageIndexChanging(1);
        }
        else if(action=="action_update"){
            pageHelperProcess.updateSelectRowData(parameter);
        }
        else {
            return ;
        }
    }

</script>
</html>
