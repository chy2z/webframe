<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ include file="../../../taglib/taglibs.jsp"%>
<%@ include file="../../../taglib/import_iview.jsp"%>
<%@ include file="../../../taglib/import_jquery.jsp"%>
<%@ include file="../../../taglib/import_common.jsp"%>
<html>
<head>
    <title>审核流程新增</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
    <script type="text/javascript" src="${ctx}/js/sortablejs/Sortable.min.js"></script>
</head>
<body>
<div class="my-app" id="app">
    <div class="my-layout my-layout-clear-top-10">
        <Row class-name="my-layout-body" justify="center" type="flex">
            <i-col span="8">
                <div class="ivu-card-padding ivu-card-body-padding">
                <Card>
                    <p slot="title">审核类型-选择</p>
                    <div class="my-layout">
                        <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
                             <i-col span="24">
                                <div class="float-left">
                                    <label class="my-label">所属部门：</label>
                                    <i-Select style="width:200px"
                                               v-model="selectATDepart.selectItem"
                                               :disabled="selectATDepart.disabled"
                                               :placeholder="selectATDepart.placeholder"
                                               :not-found-text="selectATDepart.notFoundText"
                                               :label-in-value="selectATDepart.labelInValue"
                                               :size="selectATDepart.size"
                                               :clearable="selectATDepart.clearable"
                                               :filterable="selectATDepart.filterable">
                                        <i-Option v-for="item in selectATDepart.dataTable" :value="item.id"
                                                  :key="item.id">{{ item.label }}</i-Option>
                                    </i-Select>
                                </div>
                            </i-col >
                        </Row>
                        <Row class-name="my-layout-body my-layout-body-ak"  type="flex">
                            <i-col span="24">
                                <i-Table :height="dataTableAK.height"
                                         :width="dataTableAK.width"
                                         :show-header="dataTableAK.showHeader"
                                         :loading="dataTableAK.pageLoading"
                                         :stripe="dataTableAK.showStripe"
                                         :border="dataTableAK.showBorder"
                                         :highlight-row="dataTableAK.highlightRow"
                                         :size="dataTableAK.tableSize"
                                         :columns="dataTableAK.columns"
                                         :data="dataTableAK.dataTable"
                                         @on-row-click="tableRowClickAK"></i-Table>
                            </i-col>
                        </Row>
                        <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                            <i-col span="24">
                                <div class="float-right">
                                    <Page @on-change="pageChangeAK"
                                          @on-page-size-change="pageSizeChangeAK"
                                          :page-size="dataPageAK.pageSize"
                                          :page-size-opts="dataPageAK.pageSizeOpts"
                                          :placement="dataPageAK.placement"
                                          :current:="dataPageAK.pageNo"
                                          :total="dataPageAK.totalCount"
                                          :show-elevator="dataPageAK.showElevator"
                                          :show-total="dataPageAK.showTotal"
                                          :show-sizer="dataPageAK.showSizer"></Page>
                                </div>
                            </i-col>
                        </Row>
                    </div>
                </Card>
                </div>
            </i-col>
            <i-col span="8">
                <div class="ivu-card-padding ivu-card-body-padding">
                    <Card>
                        <p slot="title">审核人-选择</p>
                        <div class="my-layout">
                            <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
                                <i-col span="24">
                                    <div class="float-left">
                                        <label class="my-label">所属部门：</label>
                                        <i-Select style="width:200px"
                                                  @on-change="selectUDepartChange"
                                                  v-model="selectUDepart.selectItem"
                                                  :disabled="selectUDepart.disabled"
                                                  :placeholder="selectUDepart.placeholder"
                                                  :not-found-text="selectUDepart.notFoundText"
                                                  :label-in-value="selectUDepart.labelInValue"
                                                  :size="selectUDepart.size"
                                                  :clearable="selectUDepart.clearable"
                                                  :filterable="selectUDepart.filterable">
                                            <i-Option v-for="item in selectUDepart.dataTable" :value="item.id"
                                                      :key="item.id">{{ item.label }}</i-Option>
                                        </i-Select>
                                    </div>
                                </i-col >
                            </Row>
                            <Row class-name="my-layout-body my-layout-body-u"  type="flex">
                                <i-col span="24">
                                    <i-Table :height="userTable.height"
                                             :width="userTable.width"
                                             :show-header="userTable.showHeader"
                                             :loading="userTable.pageLoading"
                                             :stripe="userTable.showStripe"
                                             :border="userTable.showBorder"
                                             :highlight-row="userTable.highlightRow"
                                             :size="userTable.tableSize"
                                             :columns="userTable.columns"
                                             :data="userTable.dataTable"
                                    >
                                    </i-Table>
                                </i-col>
                            </Row>
                            <Row class-name="my-layout-bottom" justify="end" align="middle" type="flex">
                                <i-col span="24">
                                    <div class="float-right">
                                        <Page
                                                @on-change="pageChangeUser"
                                                @on-page-size-change="pageSizeChangeUser"
                                                :page-size="userPage.pageSize"
                                                :page-size-opts="userPage.pageSizeOpts"
                                                :placement="userPage.placement"
                                                :current:="userPage.pageNo"
                                                :total="userPage.totalCount"
                                                :show-elevator="userPage.showElevator"
                                                :show-total="userPage.showTotal"
                                                :show-sizer="userPage.showSizer"></Page>
                                    </div>
                                </i-col>
                            </Row>
                        </div>
                    </Card>
                </div>
            </i-col>
            <i-col span="8">
                <div class="ivu-card-padding ivu-card-body-padding">
                    <Card>
                        <p slot="title">审核步骤</p>
                        <div class="fil-height">
                            <dragabletable :columns-List="columnsStep" v-model="dataStep" @on-start="dragOnstart" @on-end="dragOnend" @on-choose="dragOnchoose" >
                            </dragabletable>
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
                </div>
            </i-col>
        </Row>
    </div>
    </div>
</div>
</body>
<script>
    var domain="${ctx}";
    var add_url=domain+"/sysNotice/insert?jwt=${requestScope.jwt}";
    var department_Select_url="${ctx}/department/vselect/selectDepartment?jwt=${requestScope.jwt}";

    var selectHelperATDepartment= new selectHelper(department_Select_url,{});
    var selectHelperUDepartment= new selectHelper(department_Select_url,{});

    var pagingHelperAK=new pageHepler("${ctx}/auditKind/pagination?jwt=${requestScope.jwt}",{
        columns: [
            {
                title: '序号',
                key: 'id'
            },
            {
                title: '名称',
                key: 'name'
            },
            {
                title: '备注',
                key: 'memo'
            }
        ]
    },{orderBy:" id desc "});
    var pageHelperUser=new pageHepler("${ctx}/users/pagination?jwt=${requestScope.jwt}",{
        columns: [
            {
                title: '姓名',
                key: 'name'
            },
            {
                title: '职位',
                key: 'office',
                width:300
            },
            {
                title:'角色',
                key:'roleName'
            }
        ]
    },{pageSize:50,orderBy:" u.id desc "});

    // 注册拖拽表格组件
    Vue.component('dragabletable', {
        name: 'dragabletable',
        template: `
             <i-Table
            border
            ref="dragable"
            :columns="columnsList"
            :data="value"
            stripe
            ></i-Table>
         `,
        data () {
            return {

            };
        },
        props: {
            columnsList: Array,
            value: Array
        },
        methods: {
            startFunc (e) {
                this.$emit('on-start', e.oldIndex);
            },
            endFunc (e) {
                let movedRow = this.value[e.oldIndex];
                this.value.splice(e.oldIndex, 1);
                this.value.splice(e.newIndex, 0, movedRow);
                this.$emit('on-end', {
                    value: this.value,
                    from: e.oldIndex,
                    to: e.newIndex
                });
            },
            chooseFunc (e) {
                this.$emit('on-choose', e.oldIndex);
            }
        },
        mounted () {
            var el = this.$refs.dragable.$children[1].$el.children[1];
            let vm = this;
            Sortable.create(el, {
                onStart: vm.startFunc,
                onEnd: vm.endFunc,
                onChoose: vm.chooseFunc
            });
        }
    });


    new Vue({
        el: '#app',
        data: {
            spinShow:false,
            userid:${requestScope.user.id},
            corporationid:${requestScope.user.corporationid},
            selectATDepart:selectHelperATDepartment.ivSelect,
            selectUDepart:selectHelperUDepartment.ivSelect,
            dataTableAK:pagingHelperAK.ivTable,
            dataPageAK:pagingHelperAK.ivPage,
            userTable:pageHelperUser.ivTable,
            userPage:pageHelperUser.ivPage,
            dragTable: {
                hasDragged: false,
                isDragging: false,
                oldIndex: 0,
                newIndex: 0,
                chooseRecord: []
            },
            columnsStep: [
                {
                    title: '序号',
                    type: 'index',
                    width: 80,
                    align: 'center'
                },
                {
                    title: '姓名',
                    key: 'name'
                },
                {
                    title: '步骤',
                    key: 'age'
                },
                {
                    title: 'Action',
                    key: 'action',
                    width: 150,
                    align: 'center',
                    render: (h, params) => {
                        return h('div', [
                            h('Button', {
                                props: {
                                    type: 'primary',
                                    size: 'small'
                                },
                                style: {
                                    marginRight: '5px'
                                },
                                on: {
                                    click: () => {
                                        this.show(params.index)
                                    }
                                }
                            }, '编辑'),
                            h('Button', {
                                props: {
                                    type: 'error',
                                    size: 'small'
                                },
                                on: {
                                    click: () => {
                                        this.remove(params.index)
                                    }
                                }
                            }, '删除')
                        ]);
                    }
                }
            ],
            dataStep: [
                {
                    name: 'John Brown',
                    age: 18
                },
                {
                    name: 'Jim Green',
                    age: 24
                }
            ]
        },
        mounted:function () {
            pagingHelperAK.setHeight($(".my-layout-body-ak").height());
            pagingHelperAK.setWidth($(".my-layout-body-ak").width());

            pageHelperUser.setHeight($(".my-layout-body-u").height());
            pageHelperUser.setWidth($(".my-layout-body-u").width());

            pagingHelperAK.load(null);
            pageHelperUser.load("u.corporationId='" + this.corporationid + "'");

            selectHelperATDepartment.load("corporationId='" + this.corporationid + "'");
            selectHelperUDepartment.load("corporationId='" + this.corporationid + "'");
        },
        methods:{
            pageChangeAK(index){
                pagingHelperAK.pageIndexChanging(index);
            },
            pageSizeChangeAK(pageSize){
                pagingHelperAK.setSelectRowIndex(1);
            },
            pageChangeUser(index){
                pageHelperUser.pageIndexChanging(index);
            },
            pageSizeChangeUser(pageSize){
                pagingHelperAK.setSelectRowIndex(1);
            },
            tableRowClickAK(data,index){

            },
            selectUDepartChange(option){
                if(option==null||option.value==""){
                    pageHelperUser.load("u.corporationId='" + this.corporationid + "'");
                }
                else {
                    pageHelperUser.load(" u.departId='"+option.value+"' ");
                }
            },
            dragOnstart (from) {
                this.dragTable.oldIndex = from;
                this.dragTable.hasDragged = true;
                this.dragTable.isDragging = true;
            },
            dragOnend (e) {
                this.dragTable.newIndex = e.to;
                this.dragTable.isDragging = false;
            },
            dragOnchoose (from) {
                this.dragTable.chooseRecord.unshift(this.dataStep[from].name);
            },
            butRefresh(){
                vconfirm(this,"确认刷新吗?",()=>{
                    window.location.reload();
                });
            }
        }
    });
</script>
</html>
