<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<%@ include file="../../../taglib/import_audit.jsp"%>
<html>
<head>
    <title>系统通知</title>
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
                    <i-Select  style="width:200px"
                               @on-change="selectCorporationChange"
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
                    label-position="right" label-width="55">
                <Form-Item label="发布人" prop="userName">
                    <i-Input element-id="quserName" v-model="queryModal.bindModel.userName" placeholder="请输入发布人"></i-Input>
                </Form-Item>
                <Form-Item label="标题" prop="title">
                    <i-Input element-id="qtitle" v-model="queryModal.bindModel.title" placeholder="请输入标题"></i-Input>
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
                },
                {
                    title: '状态',
                    key: 'auditstate',
                    render: (h, params) => {
                        return h("div",{
                            attrs: {
                                class: (params.row.auditstate==vLang.audit.pass?vLang.audit.classPass:(params.row.auditstate==vLang.audit.return?vLang.audit.classReturn:(params.row.auditstate==vLang.audit.new?vLang.audit.classNew:vLang.audit.classProcess)))
                            }
                        },[
                            h('strong', params.row.auditstate)
                        ]);
                    }
                }
            ]
        },{orderBy:" s.id desc ",rightRecord:"${requestScope.rightRecord}"});

        var selectHelperCorporation=new selectHelper(corporation_Select_url,{});

        new Vue({
            el: '#app',
            data: {
                spinShow:false,
                jwt:"${requestScope.jwt}",
                butShow:${requestScope.rightBut},
                recordShow:"${requestScope.rightRecord}",
                queryModal:{
                    title:"条件查询",
                    modalShow:false,
                    okButShow:true,
                    okButLoading:false,
                    bindModel:{
                        userName:"",
                        title:""
                    },
                    ruleValidate:{}
                },
                selectCorporation:selectHelperCorporation.ivSelect,
                noticeTable:pageHelperNotice.ivTable,
                noticePage:pageHelperNotice.ivPage
            },
            created:function(){
                Audit.initConfig(this,domain,this.jwt,Audit.operationType.sys_notice,${requestScope.useId},${requestScope.departId});
            },
            mounted:function () {
                //设置表格的高度，显示记录较多时，出现滚动条，仅仅设置height=100%，不会出现滚动条
                pageHelperNotice.setHeight($(".my-layout-body").height());

                //权限控制
                if(nomanage) {
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
                    pageHelperNotice.pageIndexChanging(1,pageSize);
                },
                tableNoticeRowClick(data,index){
                    pageHelperNotice.setSelectRowIndex(index);
                },
                selectCorporationChange(option){
                    if(isBlank(option)||isBlank(option.value)) {
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
                    Audit.canEdit(this,pageHelperNotice.getSelectRowIndex(),pageHelperNotice.getSelectRowData(),()=>{
                        let rowData=pageHelperNotice.getSelectRowData();
                        vPopWindowShow("action_update",noticeUpdate_url+"&id="+rowData.id,"系统通知修改");
                    });
                },
                butDel(){
                    Audit.canDel(this,pageHelperNotice.getSelectRowIndex(),pageHelperNotice.getSelectRowData(),()=>{
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
                        },()=>{
                            this.spinShow=true;
                        },()=>{
                            this.spinShow=false;
                        });
                    });
                },
                butAuditProcess(){
                    Audit.auditProcess(this,pageHelperNotice.getSelectRowIndex(),pageHelperNotice.getSelectRowData(),(url)=>{
                        vPopWindowShow("action_flow_view",url,vLang.audit.processViewTitle);
                    });
                },
                butSendAudit(){
                    Audit.sendAudit(this,pageHelperNotice.getSelectRowIndex(),pageHelperNotice.getSelectRowData(),(row)=>{
                        let content=row==null?"":row.title;
                        return content;
                    },()=>{
                        vPopWindowShow("action_audit",Audit.urls.sendAudit_url,Audit.config.title,Audit.config);
                    });
                },
                butLook(){
                    if(pageHelperNotice.getSelectRowIndex()>-1){
                        let rowData=pageHelperNotice.getSelectRowData();
                        vPopWindowShow("action_look",noticeLook_url+"&id="+rowData.id,"系统通知查看");
                    }
                    else{
                        valert(this,"请选择一行记录修改");
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
                queryModalOk(){
                    this.$refs['queryModal.bindModel'].validate((valid) => {
                        if (valid) {
                            let WR = [];
                            WR[WR.length] = new whereRelation("u.corporationId", selectHelperCorporation.getSelectItem(), "string", null, null, false);
                            WR[WR.length] = new whereRelation("u.name", this.queryModal.bindModel.userName, "string", null, null, true);
                            WR[WR.length] = new whereRelation("s.title",this.queryModal.bindModel.title, "string", null, null, true);
                            pageHelperNotice.load(new pageHelperWhere(WR).getWhere());
                            this.queryModal.modalShow=false;
                        }
                        else{
                            valert(this,'表单验证失败!');
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
             if(action=="action_add"){
                 pageHelperNotice.pageIndexChanging(1);
             }
             else if(action=="action_update"){
                 pageHelperNotice.updateSelectRowData(parameter);
             }
             else if(action=="action_audit"){
                 pageHelperNotice.updateSelectRowData(parameter);
             }
             else {
                 return ;
             }
        }
</script>
</html>
