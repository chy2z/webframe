/**
 * 分页类
 * @param url
 * @param ivTable
 * @param ivPage
 */
function pageHepler(url,ivTable,ivPage){

    this.mPageSize=0;

    this.mpageNo=0;

    this.mWhere=null;

    this.mOrderBy=null;

    /**
     * 负责初始化
     * @param pageNo
     * @param pageSize
     * @param where
     * @param orderBy
     */
    this.load=function(pageNo,pageSize,where,orderBy){
        this.mpageNo=pageNo;
        this.mPageSize=pageSize;
        this.mWhere=where;
        this.mOrderBy=orderBy;
        var data = {pageNo:this.mpageNo,pageSize:this.mPageSize,where:this.mWhere,orderBy:this.mOrderBy};
        $.ajax({
            url: url,
            type: "POST",
            data: data,
            beforeSend:function(){
                ivTable.pageLoading=true;
            },
            complete:function(){
                ivTable.pageLoading=false;
            },
            success: function(res){
                var json=$.evalJSON(res);
                ivTable.dataCorpration=json.result;
                ivPage.pageNo=json.pageNo;
                ivPage.totalCount=json.totalCount;
            },
            error: function(res){
                alert(res.responseText);
            }
        });
    }

    /**
     * 页面索引改变
     * @param pageNo
     * @param where
     * @param orderBy
     */
    this.pageIndexChanging=function(pageNo){
        this.mpageNo=pageNo;
        var data = {pageNo:this.mpageNo,pageSize:this.mPageSize,where:this.mWhere,orderBy:this.mOrderBy};
        $.ajax({
            url: url,
            type: "POST",
            data: data,
            beforeSend:function(){
                ivTable.pageLoading=true;
            },
            complete:function(){
                ivTable.pageLoading=false;
            },
            success: function(res){
                var json=$.evalJSON(res);
                ivTable.dataCorpration=json.result;
                ivPage.pageNo=json.pageNo;
                ivPage.totalCount=json.totalCount;
            },
            error: function(res){
                alert(res.responseText);
            }
        });
    }


}
