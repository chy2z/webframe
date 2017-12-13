<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>系统通知</title>
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
</div>
</body>
<script>
    window.onload=function() {
        var domain="${ctx}";
        var nomanage=${requestScope.nomanage};
        var corporationId="${requestScope.corporationId}";
        var noticeDelete_url=domain+"/notice/delete?jwt=${requestScope.jwt}";
        var corporation_Select_url="${ctx}/corporation/vselect/selectCorporation?jwt=${requestScope.jwt}";

        var pageHelperNotice=new pageHepler("${ctx}/nocice/pagination?jwt=${requestScope.jwt}",{
            columns: [
                {
                    title: '序号',
                    key: 'id'
                },
                {
                    title: '发布人',
                    key: 'name'
                },
                {
                    title: '标题',
                    key: 'title'
                },
                {
                    title: '时间',
                    key: 'createTime'
                }
            ]
        },{orderBy:" id desc "});

        var selectHelperCorporation=new selectHelper(corporation_Select_url,{});

        new Vue({
            el: '#app',
            data: {
                jwt:"${requestScope.jwt}",
                butShow:${requestScope.rightBut},
                selectCorporation:selectHelperCorporation.ivSelect,
                noticeTable:pageHelperNotice.ivTable,
                noticePage:pageHelperNotice.ivPage
            },
            created:function(){

            },
            mounted:function () {
                //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
                pageHelperNotice.setHeight($(".my-layout-body").height());
                //权限控制
                if(nomanage) {
                    //表格加载数据
                    pageHelperNotice.load("corporationId='"+corporationId+"'");
                    //加载组织机构
                    selectHelperCorporation.load("id='"+corporationId+"'");
                    selectHelperCorporation.setSelectItem(parseInt(corporationId));
                    selectHelperCorporation.setDisabled(true);
                }
                else{
                    //表格加载数据
                    pageHelperNotice.load(null);
                    //加载组织机构
                    selectHelperCorporation.load(null);
                }
            },
            methods:{
                pageChangeNotice(index){
                    pageHelperNotice.pageIndexChanging(index);
                },
                pageSizeChangeNotice(pageSize){
                    pageHelperNotice.pageIndexChanging(1);
                },
                tableNoticeRowClick(data,index){
                    pageHelperNotice.setSelectRowIndex(index);
                },
                selectCorporationChange(option){
                    if(option==null||option.value=="") {
                        pageHelperNotice.load(null);
                    }
                    else{
                        pageHelperNotice.load("corporationId='" + option.value + "'");
                    }
                },
                butAdd(){

                },
                butEdit(){

                },
                butDel(){
                    if(pageHelperNotice.getSelectRowIndex()>-1){
                        vconfirm(this,"确认删除吗？",()=>{
                            let rowData=pageHelperNotice.getSelectRowData();
                            vajaxPost(noticeDelete_url,{id:rowData.id},false,(result)=>{
                                if(result&&result.success){
                                    pageHelperNotice.deleteSelectedRow();
                                    pageHelperNotice.setSelectRowIndex(-1);
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
                    if(pageHelperNotice.getSelectRowIndex()>-1){

                    }
                    else{
                        valert(this,"请选择一行记录修改");
                    }
                },
                butRefresh(){
                    window.location.reload();
                }
            }
        });
    }
</script>
</html>
