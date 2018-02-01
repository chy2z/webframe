/**
 * 分页类
 * @param url
 * @param ivTableConfig
 * @param ivPageConfig
 */
function pageHepler(url,ivTableConfig,ivPageConfig){

    /**
     * iview 表格属性
     * @type {void|*}
     */
    this.ivTable=$.extend({
        elementid:null,
        width:0,
        height:0,
        pageLoading:false,
        showBorder: true,
        showStripe: true,
        showHeader: true,
        highlightRow:true,
        showIndex: false,
        showCheckbox: false,
        fixedHeader: false,
        tableSize: 'default',
        selectRowIndex:-1,
        columns:null,
        dataTable:[]
    },ivTableConfig);

    /**
     * iview 分页控件属性
     * @type {void|*}
     */
    this.ivPage=$.extend({
        showElevator:true,
        showTotal:true,
        showSizer:true,
        placement:"top",
        pageSize:10,
        pageSizeOpts:[10,20,30,50,100,200],
        pageNo:1,
        totalCount:0,
        orderBy:null,
        orderInner:null,
        whereInner:null,
        rightRecord:null
    },ivPageConfig);

    /**
     * 煤业数量
     * @type {number}
     */
    this.mPageSize=0;

    /**
     * 每页数据量
     * @type {number}
     */
    this.mpageNo=0;

    /**
     * 查询条件
     * @type {null}
     */
    this.mWhere=null;

    /**
     * 排序条件
     * @type {null}
     */
    this.mOrderBy=null;

    /**
     * 查询条件
     * @type {null}
     */
    this.mWhereInner=null;

    /**
     * 排序条件
     * @type {null}
     */
    this.mOrderByInner=null;

    /**
     * 记录权限
     * @type {null}
     */
    this.mRightRecord=null;

    /**
     * 当前选中行
     * @type {null}
     */
    this.currentRow=null;

    /**
     * 负责初始化 默认加载第一页，此时where条件可以改变
     * @param pageNo
     * @param pageSize
     * @param where
     * @param orderBy
     */
    this.load=function(where){
        this.mpageNo=1;
        this.mWhere=where;
        this.mPageSize=this.ivPage.pageSize;
        this.mOrderBy=this.ivPage.orderBy;
        this.mOrderByInner=this.ivPage.mOrderByInner;
        this.mWhereInner=this.ivPage.whereInner;
        this.mRightRecord=this.ivPage.rightRecord;
        let my=this;
        let data = {
            pageNo:this.mpageNo,pageSize:this.mPageSize,
            where:this.mWhere,orderBy:this.mOrderBy,
            whereInner:this.mWhereInner,orderInner:this.orderInner,
            rightRecord:this.mRightRecord
        };
        this.setSelectRowIndex(-1);
        $.ajax({
            url: url,
            type: "POST",
            data: data,
            beforeSend:function(){
                my.ivTable.pageLoading=true;
            },
            complete:function(){
                my.ivTable.pageLoading=false;
            },
            success: function(res){

                var json=$.evalJSON(res);

                my.ivTable.dataTable=json.result;

                my.ivTable.selectRowIndex=-1;

                my.ivPage.pageNo=json.pageNo;

                my.ivPage.totalCount=json.totalCount;
            },
            error: function(res){
                alert(res.responseText);
            }
        });
    }

    /**
     * 页面索引改变 此时where不会改变
     * @param pageNo
     * @param where
     * @param orderBy
     */
    this.pageIndexChanging=function(pageNo,pageSize){
        this.mpageNo=pageNo;
        if(pageSize!=null) {
            this.mPageSize = pageSize;
        }
        let my=this;
        let data = {
            pageNo:this.mpageNo,pageSize:this.mPageSize,
            where:this.mWhere,orderBy:this.mOrderBy,
            whereInner:this.mWhereInner,orderInner:this.orderInner,
            rightRecord:this.mRightRecord
        };
        this.setSelectRowIndex(-1);
        $.ajax({
            url: url,
            type: "POST",
            data: data,
            beforeSend:function(){
                my.ivTable.pageLoading=true;
            },
            complete:function(){
                my.ivTable.pageLoading=false;
            },
            success: function(res){

                var json=$.evalJSON(res);

                my.ivTable.dataTable=json.result;

                my.ivPage.pageNo=json.pageNo;

                my.ivPage.totalCount=json.totalCount;
            },
            error: function(res){
                alert(res.responseText);
            }
        });
    }

    /**
     * 设置选中的行索引
     * @param index
     */
    this.setSelectRowIndex=function(index){
        this.ivTable.selectRowIndex=index;
    }

    /**
     * 设置高亮行
     */
    this.setHighlightRow=function(){
        for(let index in this.ivTable.dataTable){
            if(index!=this.ivTable.selectRowIndex){
                Vue.set(this.ivTable.dataTable[index],"_highlight",false);
            }
            else{
                Vue.set(this.ivTable.dataTable[index],"_highlight",true);
            }
        }
    }

    /**
     * 更新选中行的数据
     * @param data
     */
    this.updateSelectRowData=function(data){
        let rowData= this.getSelectRowData();
        $.each(data,function(key,value){
            if(typeof rowData[key]!=undefined){
                rowData[key]=value;
            }
        });
        this.setHighlightRow();
    }

    /**
     * 获取选中的行索引
     * @returns {*}
     */
    this.getSelectRowIndex=function(){
        return this.ivTable.selectRowIndex;
    }

    /**
     * 返回选中的行数据
     * @returns {*}
     */
    this.getSelectRowData=function(){
        if(this.ivTable.selectRowIndex<0){ return null; }
        return this.ivTable.dataTable[this.ivTable.selectRowIndex];
    }

    /**
     * 删除一行
     * @param index
     */
    this.deleteRow=function(index){
        this.ivTable.dataTable.splice(index,1);
    }

    /**
     * 删除选中行
     */
    this.deleteSelectedRow=function(){
        this.ivTable.dataTable.splice(this.ivTable.selectRowIndex,1);
    }

    /**
     * 清理数据
     */
    this.clearDataTable=function () {
        this.ivTable.dataTable.splice(0,this.ivTable.dataTable.length);
    }

    /**
     * 设置表格高度
     * @param h
     */
    this.setHeight=function(h){
        this.ivTable.height=h;
    }

    /**
     * 设置宽度
     * @param w
     */
    this.setWidth=function(w){
        this.ivTable.width=w;
    }

    /**
     * 导出数据
     * @param corporationExport_url
     */
    this.export=function (export_url,vue) {
        if(this.ivPage.totalCount==0){
            valert(vue,"无数据");
        }
        else if(this.ivPage.totalCount>30000){
            valert(vue,"数据量超过30000，请分批导出");
        }
        else{
            window.open(export_url + '&where=' + encodeURIComponent(this.mWhere));
        }
    }
}
