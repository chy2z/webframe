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
    <Spin size="large" fix v-if="spinShow"></Spin>
    <div class="my-layout">
        <Row class-name="my-layout-top" align="middle" type="flex">
            <i-col span="24">
                <div class="float-left fil-width">
                    <Row align="middle" type="flex">
                        <i-col span="6">
                            <label class="my-label">流程名称：</label>
                            <i-Input v-model="auditProcess.pname" placeholder="请输入流程名称..." class="input-300"></i-Input>
                        </i-col>
                        <i-col span="6"><label class="my-label">所属部门：</label>
                            <label class="my-label">{{auditProcess.departName}}</label></i-col>
                        <i-col span="6"><label class="my-label">流程类型：</label>
                            <label class="my-label">{{auditProcess.kind}}</label></i-col>
                        <i-col span="4">
                            <label class="my-label">步骤总数：</label>
                            <label class="my-label">{{auditProcess.stepNum}}</label>
                        </i-col>
                        <i-col span="2">
                            <Checkbox v-model="auditProcess.enable">启用</Checkbox>
                        </i-col>
                    </Row>
                </div>
            </i-col>
        </Row>
        <Row class-name="my-layout-body padding-5" justify="center" type="flex">
            <i-col span="7">
                <div class="ivu-card-padding ivu-card-body-padding">
                <Card>
                    <p slot="title">审核类型-选择</p>
                    <div class="my-layout">
                        <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
                             <i-col span="24">
                                <div class="float-left">
                                    <label class="my-label">所属部门：</label>
                                    <i-Select class="input-200"
                                               @on-change="selectATDepartChange"
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
            <i-col span="7">
                <div class="ivu-card-padding ivu-card-body-padding">
                    <Card>
                        <p slot="title">审核人-选择</p>
                        <div class="my-layout">
                            <Row id="top" class-name="my-layout-top" justify="end" align="middle" type="flex">
                                <i-col span="24">
                                    <div class="float-left">
                                        <label class="my-label">所属部门：</label>
                                        <i-Select class="input-200"
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
                                             @on-row-dblclick="tableRowClickUser"></i-Table>
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
            <i-col span="10">
                <div class="ivu-card-padding ivu-card-body-padding">
                    <Card>
                        <p slot="title">审核步骤</p>
                        <div class="fil-height">
                            <dragabletable :columns-List="columnsStep" v-model="dataStep"
                                           :edit-incell="true"
                                           @on-cell-change="editCellChange"
                                           @on-change="editRowChange"
                                           @on-delete="deleteDataStep"
                                           @on-start="dragOnstart"
                                           @on-end="dragOnend"
                                           @on-choose="dragOnchoose" >
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
                    <i-Button type="primary" @click="butSave()" icon="checkmark">保存</i-Button>
                </div>
            </i-col>
        </Row>
    </div>
</div>
</body>
<script>
    var domain="${ctx}";
    var add_url=domain+"/auditKindProcess/insert?jwt=${requestScope.jwt}";
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
                title: '序号',
                key: 'id'
            },
            {
                title: '姓名',
                key: 'name'
            },
            {
                title:'角色',
                key:'roleName'
            },
            {
                title: '职位',
                key: 'office'
            }
        ]
    },{pageSize:50,orderBy:" u.id desc "});

    // 编辑按钮
    const editButton = (vm, h, currentRow, index) => {
        return h('Button', {
            props: {
                type: currentRow.editting ? 'success' : 'primary',
                loading: currentRow.saving
            },
            style: {
                margin: '0 5px'
            },
            on: {
                'click': () => {
                    if (!currentRow.editting) {
                        if (currentRow.edittingCell) {
                            for (let name in currentRow.edittingCell) {
                                currentRow.edittingCell[name] = false;
                                vm.edittingStore[index].edittingCell[name] = false;
                            }
                        }
                        vm.edittingStore[index].editting = true;
                        vm.thisTableData = JSON.parse(JSON.stringify(vm.edittingStore));
                    } else {
                        vm.edittingStore[index].saving = true;
                        vm.thisTableData = JSON.parse(JSON.stringify(vm.edittingStore));
                        let edittingRow = vm.edittingStore[index];
                        edittingRow.editting = false;
                        edittingRow.saving = false;
                        vm.thisTableData = JSON.parse(JSON.stringify(vm.edittingStore));
                        vm.$emit('input', vm.handleBackdata(vm.thisTableData));
                        vm.$emit('on-change', vm.handleBackdata(vm.thisTableData), index);
                    }
                }
            }
        }, currentRow.editting ? '保存' : '编辑');
    };

    // 删除按钮
    const deleteButton = (vm, h, currentRow, index) => {
        return h('Poptip', {
            props: {
                confirm: true,
                title: '您确定要删除这条数据吗?',
                transfer: true,
                placement:'top-end'
            },
            on: {
                'on-ok': () => {
                    vm.thisTableData.splice(index, 1);
                    vm.$emit('input', vm.handleBackdata(vm.thisTableData));
                    vm.$emit('on-delete', vm.handleBackdata(vm.thisTableData), index);
                }
            }
        }, [
            h('Button', {
                style: {
                    margin: '0 5px'
                },
                props: {
                    type: 'error',
                    placement: 'top'
                }
            }, '删除')
        ]);
    };

    // 单元格修改按钮
    const incellEditBtn = (vm, h, param) => {
        if (vm.hoverShow) {
            return h('div', {
                'class': {
                    'show-edit-btn': vm.hoverShow
                }
            }, [
                h('Button', {
                    props: {
                        type: 'text',
                        icon: 'edit'
                    },
                    on: {
                        click: (event) => {
                            vm.edittingStore[param.index].edittingCell[param.column.key] = true;
                            vm.thisTableData = JSON.parse(JSON.stringify(vm.edittingStore));
                        }
                    }
                })
            ]);
        } else {
            return h('Button', {
                props: {
                    type: 'text',
                    icon: 'edit'
                },
                on: {
                    click: (event) => {
                        vm.edittingStore[param.index].edittingCell[param.column.key] = true;
                        vm.thisTableData = JSON.parse(JSON.stringify(vm.edittingStore));
                    }
                }
            });
        }
    };

    // 单元格删除按钮
    const saveIncellEditBtn = (vm, h, param) => {
        return h('Button', {
            props: {
                type: 'text',
                icon: 'checkmark'
            },
            on: {
                click: (event) => {
                    vm.edittingStore[param.index].edittingCell[param.column.key] = false;
                    vm.thisTableData = JSON.parse(JSON.stringify(vm.edittingStore));
                    vm.$emit('input', vm.handleBackdata(vm.thisTableData));
                    vm.$emit('on-cell-change', vm.handleBackdata(vm.thisTableData), param.index, param.column.key);
                }
            }
        });
    };

    // 单元格修改
    const cellInput = (vm, h, param, item) => {
        return h('Input', {
            props: {
                type: 'text',
                value: vm.edittingStore[param.index][item.key]
            },
            on: {
                'on-change' (event) {
                    let key = item.key;
                    vm.edittingStore[param.index][key] = event.target.value;
                }
            }
        });
    };

    // 注册拖拽和编辑表格组件
    Vue.component('dragabletable', {
        name: 'dragabletable',
        template: `
             <i-Table
            border
            disabled-hover
            ref="dragable"
            :columns="columnsList"
            :data="value"
            stripe></i-Table>
         `,
        props: {
            columnsList: Array,
            value: Array,
            editIncell: {
                type: Boolean,
                default: false
            },
            hoverShow: {
                type: Boolean,
                default: false
            }
        },
        data () {
            return {
                thisTableData: [],
                edittingStore: []
            };
        },
        created () {
            //处理数据（model-value-thisTableData）
            this.init();
        },
        mounted () {
            var el = this.$refs.dragable.$children[1].$el.children[1];
            let vm = this;
            Sortable.create(el, {
                handle: ".ivu-icon-arrow-move",
                onStart: vm.startDrag,
                onEnd: vm.endDrag,
                onChoose: vm.chooseDrag
            });
        },
        watch: {
            value (data) {
                this.init();
            }
        },
        methods: {
            init(){
                let vm = this;
                //获取编辑的表格
                let editableCell = this.columnsList.filter(item => {
                    if (item.editable) {
                        if (item.editable === true) {
                            return item;
                        }
                    }
                });
                //克隆数据
                let cloneData = JSON.parse(JSON.stringify(this.value));
                let res = [];
                //初始化编辑信息
                res = cloneData.map((item, index) => {
                    this.$set(item, 'editting', false);
                    let edittingCell = {};
                    editableCell.forEach(item => {
                        edittingCell[item.key] = false;
                    });
                    this.$set(item, 'edittingCell', edittingCell);
                    return item;
                });
                this.thisTableData = res;
                this.edittingStore = JSON.parse(JSON.stringify(this.thisTableData));
                //处理编辑文档框和操作按钮
                this.columnsList.forEach(item => {
                    //启动编辑
                    if (item.editable) {
                        item.render = (h, param) => {
                            let currentRow = this.thisTableData[param.index];
                            if (!currentRow.editting) {
                                if (this.editIncell) {
                                    return h('Row', {
                                        props: {
                                            type: 'flex',
                                            align: 'middle',
                                            justify: 'center'
                                        }
                                    }, [
                                        h('Col', {
                                            props: {
                                                span: '14'
                                            }
                                        }, [
                                            !currentRow.edittingCell[param.column.key] ? h('span', currentRow[item.key]) : cellInput(this, h, param, item)
                                        ]),
                                        h('Col', {
                                            props: {
                                                span: '10'
                                            }
                                        }, [
                                            currentRow.edittingCell[param.column.key] ? saveIncellEditBtn(this, h, param) : incellEditBtn(this, h, param)
                                        ])
                                    ]);
                                } else {
                                    return h('span', currentRow[item.key]);
                                }
                            } else {
                                return h('Input', {
                                    props: {
                                        type: 'text',
                                        value: currentRow[item.key]
                                    },
                                    on: {
                                        'on-change' (event) {
                                            let key = param.column.key;
                                            vm.edittingStore[param.index][key] = event.target.value;
                                        }
                                    }
                                });
                            }
                        };
                    }
                    //处理操作按钮
                    if (item.handle) {
                        item.render = (h, param) => {
                            let currentRowData = this.thisTableData[param.index];
                            if (item.handle.length === 2) {
                                return h('div', [
                                    editButton(this, h, currentRowData, param.index),
                                    deleteButton(this, h, currentRowData, param.index)
                                ]);
                            } else if (item.handle.length === 1) {
                                if (item.handle[0] === 'edit') {
                                    return h('div', [
                                        editButton(this, h, currentRowData, param.index)
                                    ]);
                                } else {
                                    return h('div', [
                                        deleteButton(this, h, currentRowData, param.index)
                                    ]);
                                }
                            }
                        };
                    }
                });
            },
            handleBackdata (data) {
                let clonedData = JSON.parse(JSON.stringify(data));
                clonedData.forEach(item => {
                    delete item.editting;
                    delete item.edittingCell;
                    delete item.saving;
                });
                return clonedData;
            },
            startDrag (e) {
                this.$emit('on-start', e.oldIndex);
            },
            endDrag (e) {
                let movedRow = this.value[e.oldIndex];
                this.value.splice(e.oldIndex, 1);
                this.value.splice(e.newIndex, 0, movedRow);
                this.$emit('on-end', {
                    value: this.value,
                    from: e.oldIndex,
                    to: e.newIndex
                });
            },
            chooseDrag (e) {
                this.$emit('on-choose', e.oldIndex);
            }
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
            auditProcess:{
                id:0,
                pname:"",
                departName:"",
                kind:"",
                kid:0,
                departid:0,
                enable:true,
                stepNum:0
            },
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
                    key: 'uname',
                    editable: false
                },
                {
                    title: '角色',
                    key: 'rolename'
                },
                {
                    title: '步骤',
                    key: 'step',
                    editable: true
                },
                {
                    title: '拖拽',
                    key: 'drag',
                    width: 70,
                    align: 'center',
                    render: (h) => {
                        return h(
                            'Icon',
                            {
                                props: {
                                    type: 'arrow-move',
                                    size: 24
                                }
                            }
                        );
                    }
                },
                {
                    title: '操作',
                    align: 'center',
                    width: 100,
                    key: 'handle',
                    handle: ['delete']
                }
            ],
            dataStep: []
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
                pagingHelperAK.setSelectRowIndex(1,pageSize);
            },
            pageChangeUser(index){
                pageHelperUser.pageIndexChanging(index);
            },
            pageSizeChangeUser(pageSize){
                pagingHelperAK.setSelectRowIndex(1,pageSize);
            },
            tableRowClickAK(data,index){
                this.auditProcess.kind=data.name;
                this.auditProcess.kid=data.id;
            },
            tableRowClickUser(data,index){
                if(isBlank(this.auditProcess.pname)||isBlank(this.auditProcess.departName)||isBlank(this.auditProcess.kind)) {
                   valert(this,"请先输入完整的流程信息！");
                }
                else{
                    if(!isBlank(data.roleName)) {
                        this.dataStep.push({
                            uid: data.id,
                            uname: data.name,
                            rolename: data.roleName,
                            step: (this.dataStep.length + 1)
                        });
                        this.reSort();
                    }
                    else{
                        valert(this,"审核人没有分配角色不能选择！");
                    }
                }
            },
            selectATDepartChange(option){
                if(!isBlank(option)) {
                    this.auditProcess.departName=option.label;
                    this.auditProcess.departid=option.value;
                }
            },
            selectUDepartChange(option){
                if(isBlank(option.value)){
                    pageHelperUser.load("u.corporationId='" + this.corporationid + "'");
                }
                else {
                    pageHelperUser.load(" u.departId='"+option.value+"' ");
                }
            },
            deleteDataStep(row,index){
                this.reSort();
            },
            editRowChange(row,index){
                //vtoast(this,'修改了第' + (index + 1) + '行数据');
            },
            editCellChange(row,index,key){
                //vtoast(this,'修改了第 ' + (index + 1) + ' 行列名为 ' + key + ' 的数据');
                this.reSort();
            },
            dragOnchoose (from) {
                //鼠标点击,拖拽开始前触发
                //this.dragTable.chooseRecord.unshift(this.dataStep[from].name);
            },
            dragOnstart (from) {
                this.dragTable.oldIndex = from;
                this.dragTable.hasDragged = true;
                this.dragTable.isDragging = true;
            },
            dragOnend (e) {
                this.dragTable.newIndex = e.to;
                this.dragTable.isDragging = false;
                this.reSort();
            },
            reSort(){
                let preindex=-1;
                let step=-1;
                this.dataStep.forEach((item,index) => {
                    if(index==0) {
                        step = 1;
                        preindex=parseInt(item.step);
                        item.step=step;
                    }
                    else{
                        if(preindex!=parseInt(item.step)) {
                            step = step + 1;
                            preindex = parseInt(item.step);
                            item.step = step;
                        }
                        else{
                            item.step = step;
                        }
                    }
                });
                this.auditProcess.stepNum=step;
            },
            butRefresh(){
                vconfirm(this,"确认刷新吗?",()=>{
                    window.location.reload();
                });
            },
            butSave(){
                if(this.dataStep.length>0){
                    vajaxPost(add_url,{
                        process:JSON.stringify({
                            pname:this.auditProcess.pname,
                            kid:this.auditProcess.kid,
                            departid:this.auditProcess.departid,
                            enable:(this.auditProcess.enable?"启用":"禁用"),
                            stepnum:this.auditProcess.stepNum
                        }),
                        steps:JSON.stringify(this.dataStep)
                    },false,(result)=>{
                        vtoast(this, result.tip);
                        if(result.success){
                           vPopWindowsColse({});
                        }
                    },()=>{
                        this.spinShow=true;
                    },()=>{
                        this.spinShow=false;
                    })
                }
                else{
                    valert(this,"请选择流程步骤");
                }
            }
        }
    });
</script>
</html>
