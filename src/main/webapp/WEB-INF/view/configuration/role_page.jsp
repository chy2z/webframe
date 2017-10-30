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
    <link rel="stylesheet" href="../../../css/default.css">
</head>
<body>
<div class="my-app" id="app">
    <div class="my-layout">
        <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
            <i-col span="6"></i-col >
            <i-col span="18">
                <div style="float: right;margin: 0 5px;">
                    <%@include file="../rightTemplate.jsp" %>
                </div>
            </i-col >
        </Row>
        <Row class-name="my-layout-body" type="flex">
            <i-col span="24">
                <i-Table :height="croporationTable.height"
                         :width="croporationTable.width"
                         :show-header="croporationTable.showHeader"
                         :loading="croporationTable.pageLoading"
                         :stripe="croporationTable.showStripe"
                         :border="croporationTable.showBorder"
                         :highlight-row="croporationTable.highlightRow"
                         :size="croporationTable.tableSize"
                         :columns="croporationTable.columns"
                         :data="croporationTable.dataTable"
                         @on-row-click="tableCroporationRowClick"></i-Table>
            </i-col>
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col  span="6"></i-col >
            <i-col  span="18">
                <div style="float: right;margin: 0 5px;">
                    <Page @on-change="pageChange" @on-page-size-change="pageSizeChange"
                          :page-size="croporationPage.pageSize"
                          :page-size-opts="croporationPage.pageSizeOpts"
                          :placement="croporationPage.placement"
                          :current:="croporationPage.pageNo"
                          :total="croporationPage.totalCount"
                          :show-elevator="croporationPage.showElevator"
                          :show-total="croporationPage.showTotal"
                          :show-sizer="croporationPage.showSizer"></Page>
                </div>
            </i-col >

        </Row>
    </div>
</div>
</body>
</html>
