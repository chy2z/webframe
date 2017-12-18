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
                <i-Table :height="noticeTable.height"
                         :width="noticeTable.width"
                         :show-header="noticeTable.showHeader"
                         :loading="noticeTable.pageLoading"
                         :stripe="noticeTable.showStripe"
                         :border="noticeTable.showBorder"
                         :highlight-row="noticeTable.highlightRow"
                         :size="noticeTable.tableSize"
                         :columns="noticeTable.columns"
                         :data="noticeTable.dataTable"
                         @on-row-click="tableNoticeRowClick"></i-Table>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col  span="6"></i-col >
            <i-col  span="18">
                <div class="float-right">
                    <Page @on-change="pageChangeNotice" @on-page-size-change="pageSizeChangeNotice"
                          :page-size="noticePage.pageSize"
                          :page-size-opts="noticePage.pageSizeOpts"
                          :placement="noticePage.placement"
                          :current:="noticePage.pageNo"
                          :total="noticePage.totalCount"
                          :show-elevator="noticePage.showElevator"
                          :show-total="noticePage.showTotal"
                          :show-sizer="noticePage.showSizer"></Page>
                </div>
            </i-col >

        </Row>
    </div>
</div>
</body>
<script>
        var domain="${ctx}";
        var nomanage=${requestScope.nomanage};
        var corporationId="${requestScope.corporationId}";
        var noticeDelete_url=domain+"/sysNotice/delete?jwt=${requestScope.jwt}";
        var noticeAdd_url=domain+"/sysNotice/path/add?jwt=${requestScope.jwt}";
        var noticeUpdate_url=domain+"/sysNotice/path/update?jwt=${requestScope.jwt}";
        var noticeLook_url=domain+"/sysNotice/path/look?jwt=${requestScope.jwt}";
        var corporation_Select_url="${ctx}/corporation/vselect/selectCorporation?jwt=${requestScope.jwt}";
        var pageHelperNotice=new pageHepler("${ctx}/sysNotice/pagination?jwt=${requestScope.jwt}",{
            columns: [
                {
                    title: '序号',
                    key: 'id'
                },
                {
                    title: '发布人',
                    key: 'userName'
                },
                {
                    title: '部门',
                    key: 'departName'
                },
                {
                    title: '标题',
                    key: 'title'
                },
                {
                    title: '发布时间',
                    key: 'createtime'
                    //render: function (h, params) {
                    //    return h('div',
                    //        new Date(this.row.createtime).Format('yyyy-MM-dd'));
                    //}
                }
            ]
        },{orderBy:" s.id desc "});

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
                    pageHelperNotice.load("u.corporationId='"+corporationId+"'");
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
                        pageHelperNotice.load("u.corporationId='" + option.value + "'");
                    }
                },
                butAdd(){
                    vPopWindowShow("action_add",noticeAdd_url,"系统通知增加");
                },
                butEdit(){
                    if(pageHelperNotice.getSelectRowIndex()>-1){
                        vPopWindowShow("action_update",noticeUpdate_url,"系统通知修改");
                    }
                    else{
                        valert(this,"请选择一行记录修改");
                    }
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
                        vPopWindowShow("action_look",noticeLook_url,"系统通知修改");
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

        /**
         * 全局弹出窗体回调
         * @param action
         * @param parameter
         */
        function popupsCallBack(action,parameter){
             log(action);
             log(parameter);
        }
</script>
</html>
