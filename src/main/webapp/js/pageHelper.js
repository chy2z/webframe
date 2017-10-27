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
        height:200,
        pageLoading:true,
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
        pageSizeOpts:[10,20,30,50],
        pageNo:1,
        totalCount:0,
        orderBy:null
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
     * 负责初始化 默认加载第一页，此时where条件可以改变
     * @param pageNo
     * @param pageSize
     * @param where
     * @param orderBy
     */
    this.load=function(where){
        this.mpageNo=1;
        this.mPageSize=this.ivPage.pageSize;
        this.mWhere=where;
        this.mOrderBy=this.ivPage.orderBy;
        let my=this;
        let data = {pageNo:this.mpageNo,pageSize:this.mPageSize,where:this.mWhere,orderBy:this.mOrderBy};
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
     * 页面索引改变 此时where不会改变
     * @param pageNo
     * @param where
     * @param orderBy
     */
    this.pageIndexChanging=function(pageNo){
        this.mpageNo=pageNo;
        let my=this;
        let data = {pageNo:this.mpageNo,pageSize:this.mPageSize,where:this.mWhere,orderBy:this.mOrderBy};
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
     * 获取选中的行索引
     * @returns {*}
     */
    this.getSelectRowIndex=function(){
        return  this.ivTable.selectRowIndex;
    }

    /**
     * 返回选中的行数据
     * @returns {*}
     */
    this.getSelectRowData=function(){
        if(this.ivTable.selectRowIndex<0){ alert("行数据为空"); return null; }
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
     * 设置表格高度
     * @param h
     */
    this.setHeight=function(h){
        this.ivTable.height=h;
    }

}
