<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>组织机构</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <link rel="stylesheet" href="../../../css/default.css">
    <style>
        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
        }

        #app {
            height: 100%;
        }

        .my-layout {
            width: 100%;
            height: 100%;
            /* 上下间距 60px */
            padding: 60px 0;
            border: 0px solid #d7dde4;

            border-radius: 4px;
            overflow: hidden;
        }

        .my-layout-top{
            width: 100%;
            height:60px;
            /* 向上偏移 60px */
            margin: -60px 0 0;
        }


        .my-layout-body{
            width: 100%;
            /* 占满剩余高度 */
            height: 100%;
            background: #eee;
        }

        .my-layout-bottom{
            width: 100%;
            height:60px;
            /* 向下偏移 60px */
            margin:0 0 -60px;
        }

    </style>
</head>
<body>
<div id="app">
    <div class="my-layout">
        <Row class-name="my-layout-top" justify="end" align="middle" type="flex">
            <i-col  span="12"></i-col >
            <i-col  span="12">
                <div style="float: right;margin: 0 5px;">
                <Button-Group size="large" shape="circle">
                    <i-Button type="primary" icon="ios-search-strong">搜索</i-Button>
                    <i-Button type="primary" icon="plus">增加</i-Button>
                    <i-Button type="primary" icon="edit">修改</i-Button>
                    <i-Button type="primary" icon="close">删除</i-Button>
                    <i-Button type="primary" icon="ios-glasses">查看</i-Button>
                    <i-Button type="primary" icon="arrow-down-c">导出</i-Button>
                    <i-Button type="primary" icon="refresh">刷新</i-Button>
                </Button-Group>
                </div>

            </i-col >
        </Row>
        <Row class-name="my-layout-body" type="flex">
            <i-col span="24">
                <i-Table :show-header="tableCroporation.showHeader" :loading="tableCroporation.pageLoading"
                         :stripe="tableCroporation.showStripe" :border="tableCroporation.showBorder"
                         :highlight-row="tableCroporation.highlightRow" :size="tableCroporation.tableSize"
                         :columns="tableCroporation.columnsCorpration" :data="tableCroporation.dataCorpration"></i-Table>
            </i-col >
        </Row>
        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
            <i-col  span="12"></i-col >
            <i-col  span="12">
                <div style="float: right;margin: 0 5px;">
                   <Page @on-change="pageChange" @on-page-size-change="pageSizeChange"
                         :page-size="pageCroporation.pageSize"
                         :page-size-opts="pageCroporation.pageSizeOpts"
                         :placement="pageCroporation.placement"
                         :current:="pageCroporation.pageNo"
                         :total="pageCroporation.totalCount"
                         :show-elevator="pageCroporation.showElevator" :show-total="pageCroporation.showTotal"
                         :show-sizer="pageCroporation.showSizer"></Page>
                </div>
            </i-col >

        </Row>
    </div>
</div>
</body>
<script>
    window.onload=function() {
        new Vue({
            el: '#app',
            data: {
                jwt:"${requestScope.jwt}",
                pageCroporation:{
                    showElevator:true,
                    showTotal:true,
                    showSizer:true,
                    placement:"top",
                    pageSize:1,
                    pageSizeOpts:[1,10,20,30,50],
                    pageNo:1,
                    totalCount:2
                },
                tableCroporation:{
                    pageLoading:true,
                    showBorder: true,
                    showStripe: true,
                    showHeader: true,
                    highlightRow:true,
                    showIndex: false,
                    showCheckbox: false,
                    fixedHeader: false,
                    tableSize: 'default',
                    columnsCorpration:[
                        {
                            title: '序号',
                            key: 'id'
                        },
                        {
                            title: '姓名',
                            key: 'name'
                        },
                        {
                            title: '编号',
                            key: 'code'
                        }
                    ],
                    dataCorpration:[]
                }
            },
            created:function(){
                var vue=this;
                var jwt=this.jwt;
                var data = {pageNo:vue.pageCroporation.pageNo,pageSize:vue.pageCroporation.pageSize,where:null,orderBy:null};
                $.ajax({
                    url: "${ctx}/corporation/pagination?jwt="+jwt,
                    type: "POST",
                    data: data,
                    beforeSend:function(){
                       vue.tableCroporation.pageLoading=true;
                    },
                    complete:function(){
                        vue.tableCroporation.pageLoading=false;
                    },
                    success: function(res){
                        //log(res);
                        var json=$.evalJSON(res);
                        vue.tableCroporation.dataCorpration=json.result;
                        vue.pageCroporation.pageNo=json.pageNo;
                        vue.pageCroporation.totalCount=json.totalCount;
                    },
                    error: function(res){
                        alert(res.responseText);
                    }
                });
            },
            methods:{
                pageChange(index){
                    //alert(index);
                },
                pageSizeChange(pageSize){
                    //alert(pageSize);
                }
            }
        });
    }
</script>
</html>
