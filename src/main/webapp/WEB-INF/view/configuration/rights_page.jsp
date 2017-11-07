<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>权限分配</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <style>
        /* 实现card body 高度100% */
        .my-layout-body .ivu-card{
            height: 100%;
            padding: 51px 0 0;
        }

        /* 实现card body 高度100% */
        .my-layout-body .ivu-card .ivu-card-head{
            margin: -51px 0 0;
        }

        /* 实现card body 高度100% */
        .my-layout-body .ivu-card .ivu-card-body{
            height: 100%;
            overflow: auto;
        }

        .my-layout-body .ivu-card .ivu-card-head {
            border-bottom: 1px solid #e9eaec;
            padding: 14px 16px;
            line-height: 1;
            background-color: #eaf4fe;
        }
    </style>
</head>
<body>
<div class="my-app" id="app">
    <Row class-name="my-box" type="flex">
        <i-col span="12">
            <div class="my-layout my-box-left">
                <Row class-name="my-layout-top" justify="end" align="middle" type="flex">
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
                    </i-col>
                    <i-col span="10">
                        <div class="float-left">
                            <label class="my-label">角色：</label>
                            <i-Select  style="width:200px" @on-change="selectRoleChange"
                                       v-model="selectRole.selectItem"
                                       :disabled="selectRole.disabled"
                                       :placeholder="selectRole.placeholder"
                                       :not-found-text="selectRole.notFoundText"
                                       :label-in-value="selectRole.labelInValue"
                                       :size="selectRole.size" :clearable="selectRole.clearable"
                                       :filterable="selectRole.filterable">
                                <i-Option v-for="item in selectRole.dataTable" :value="item.id"
                                          :key="item.id">{{ item.label }}</i-Option>
                            </i-Select>
                        </div>
                    </i-col>
                    <i-col span="4">

                    </i-col>
                </Row>
                <Row class-name="my-layout-body" type="flex">
                    <i-col class-name="col-left" span="24">
                        <Card>
                            <p slot="title">分配权限</p>
                            <div class="tree-box">
                                <Tree ref="rightsTree" :data="dataLeft" show-checkbox multiple></Tree>
                                <Spin size="large" fix v-if="spinLeftShow"></Spin>
                            </div>
                        </Card>
                    </i-col>
                </Row>
               <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                    <i-col span="6"></i-col>
                    <i-col span="18">
                    </i-col>
                </Row>
            </div>
        </i-col>
        <i-col span="12">
            <div class="my-layout my-box-right">
                <Row class-name="my-layout-top" justify="end" align="middle" type="flex">
                    <i-col span="10">
                    </i-col>
                    <i-col span="14">
                        <div class="float-right">
                            <%@include file="../rightTemplate.jsp" %>
                        </div>
                    </i-col>
                </Row>
                <Row class-name="my-layout-body" type="flex">
                    <i-col class-name="col-right" span="24">
                        <Card>
                            <p slot="title">已有权限</p>
                            <Tree :data="dataRight"  multiple></Tree>
                            <Spin size="large" fix v-if="spinRightShow"></Spin>
                        </Card>
                    </i-col>
                </Row>
                <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                    <i-col span="6"></i-col>
                    <i-col span="18">
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
    var role_Select_url="${ctx}/role/vselect/selectRole?jwt=${requestScope.jwt}";
    var corporation_Select_url="${ctx}/corporation/vselect/selectCorporation?jwt=${requestScope.jwt}";
    var rights_all_url="${ctx}/right/all?jwt=${requestScope.jwt}";
    var rights_own_url="${ctx}/right/own?jwt=${requestScope.jwt}";
    var rights_save_url="${ctx}/right/save?jwt=${requestScope.jwt}";

    var selectHelperCorporation=new selectHelper(corporation_Select_url,{});

    var selectHelperRole=new selectHelper(role_Select_url,{});

    new Vue({
        el: '#app',
        data: {
            jwt:"${requestScope.jwt}",
            butShow:${requestScope.rightBut},
            spinLeftShow:false,
            spinRightShow:false,
            selectCorporation:selectHelperCorporation.ivSelect,
            selectRole:selectHelperRole.ivSelect,
            dataRight:[],
            dataLeft:[]
        },
        created:function(){
        },
        mounted:function () {
            //权限控制
            if(nomanage){
                //加载组织机构
                selectHelperCorporation.load("id='"+corporationId+"'");
                selectHelperCorporation.setSelectItem(parseInt(corporationId));
                selectHelperCorporation.setDisabled(true);
                selectHelperRole.load("corporationId='"+corporationId+"'");
            }
            else{
                //加载组织机构
                selectHelperCorporation.load(null);
            }
        },
        methods:{
            selectCorporationChange(option){
                if(option==null||option.value==""){
                    selectHelperRole.load(null);
                }
                else {
                    selectHelperRole.load("corporationId='" + option.value + "'");
                }
            },
            selectRoleChange(option){
                if(option&&option.value!="") {
                    vajaxPost(rights_all_url, {roleId: option.value}, false, (res) => {
                        var json = $.evalJSON(res);
                        this.dataLeft = json;
                    }, () => {
                        this.spinLeftShow = true;
                    }, () => {
                        setTimeout(()=>{
                            this.spinLeftShow = false;
                        },1000);
                    });

                    vajaxPost(rights_own_url, {roleId: option.value}, false, (res) => {
                        var json = $.evalJSON(res);
                        this.dataRight = json;
                    }, () => {
                        this.spinRightShow = true;
                    }, () => {
                        setTimeout(()=>{
                            this.spinRightShow = false;
                        },1000);
                    });
                }
            },
            butSave(){
                let nodes= this.$refs["rightsTree"].getCheckedNodes();
                log(nodes);
                if(nodes.length>0) {
                    vajaxPost(rights_save_url + "&roleId=" + this.selectRole.selectItem, nodes, true, (res) => {
                        log(res);
                    }, () => {
                        this.spinLeftShow = true;
                        this.spinRightShow = true;
                    }, () => {
                        setTimeout(() => {
                            this.spinLeftShow = false;
                            this.spinRightShow = false;
                        }, 1000);
                    });
                }
                else{
                    valert(this,"请分配权限");
                }
            },
            butRefresh(){
                window.location.reload();
            }
        }
    });
</script>
</html>
