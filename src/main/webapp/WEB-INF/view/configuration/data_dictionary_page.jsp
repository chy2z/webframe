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
    <link rel="stylesheet" href="../../../css/default.css">
    <style>
        .my-box {
            height: 100%;
        }
    </style>
</head>
<body>
<div class="myapp" id="app">
    <Row class-name="my-box" type="flex">
        <i-col span="10">
            <div class="my-layout my-box-left">
                <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
                    <i-col span="1"></i-col>
                    <i-col span="23"></i-col>
                </Row>
                <Row class-name="my-layout-body" type="flex">
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
                </Row>
                <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                    <i-col span="1"></i-col>
                    <i-col span="23">
                        <div style="float: right;margin: 0 5px;">
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
                <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
                    <i-col span="10"></i-col>
                    <i-col span="14">
                        <div style="float: right;margin: 0 5px;">
                            <%@include file="../rightTemplate.jsp" %>
                        </div>
                    </i-col>
                </Row>
                <Row class-name="my-layout-body" type="flex">
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

                </Row>
                <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                    <i-col span="1"></i-col>
                    <i-col span="23">
                        <div style="float: right;margin: 0 5px;">
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
</div>
</body>
<script>
    var domain = "${ctx}";
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
            }
        ]
    }, {orderBy: " id desc "});

    new Vue({
        el: '#app',
        data: {
            jwt: "${requestScope.jwt}",
            butShow:${requestScope.rightBut},
            parentTable: pageHelperParent.ivTable,
            parentPage: pageHelperParent.ivPage,
            childTable: pageHelperChild.ivTable,
            childPage: pageHelperChild.ivPage
        },
        created: function () {
        },
        mounted: function () {
            //设置表格宽度(左右布局有bug必须设置宽度)
            pageHelperParent.setWidth($(".my-box-left .my-layout-body").width());
            pageHelperChild.setWidth($(".my-box-right .my-layout-body").width());
            //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
            pageHelperParent.setHeight($(".my-box-left .my-layout-body").height());
            pageHelperChild.setHeight($(".my-box-right .my-layout-body").height());
            pageHelperParent.load(null);
        },
        methods: {
            butRefresh() {
                window.location.reload();
            },
            parentTableRowClick() {
                pageHelperChild.load(null);
            },
            pageChangeParent() {

            },
            pageSizeChangeParent() {

            },
            childTableRowClick() {

            },
            pageChangeChild() {

            },
            pageSizeChangeChild() {

            }
        }
    });
</script>
</html>
