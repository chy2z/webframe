

function selectHelper(url,ivSelectConfig){

    this.ivSelect=$.extend({
        //绑定的数据项
        selectItem:null,
        size:"large",
        placeholder:"请选择...",
        notFoundText:"无匹配数据项",
        placement:"bottom",
        multiple:false,
        disabled:false,
        transfer:false,
        clearable:true,
        filterable:true,
        disabled:false,
        labelInValue:true,
        //数据源
        dataTable:null,
        //是否使用远程搜索
        remote:false,
        //远程搜索方法
        remoteMethod:null,
        //加载数据
        loading:false,
        loadingText:"加载中"
    },ivSelectConfig);

    this.mwhere=null;

    /**
     * 加载数据
     * @param where
     */
    this.load=function (where) {
        //加载静态数据
        if(!url){

        }
        //加载动态数据
        else{
            this.mwhere=where;
            this.request();
        }
    }

    /**
     * 重新加载数据
     */
    this.reload=function(){
        //加载静态数据
        if(!url){

        }
        //加载动态数据
        else{
            this.request();
        }
    }

    /**
     * 数据请求
     */
    this.request=function(){
        let my=this;
        $.ajax({
            url: url,
            type: "POST",
            data: {where:my.mwhere},
            beforeSend:function(){
                my.ivSelect.loading=true;
            },
            complete:function(){
                my.ivSelect.loading=false;
            },
            success: function(res){

                var json=$.evalJSON(res);

                my.ivSelect.dataTable=json;
            },
            error: function(res){
                alert(res.responseText);
            }
        });
    }

    /**
     * 配置选中项
     * @returns {null}
     */
    this.getSelectItem=function () {
        return this.ivSelect.selectItem;
    }

    /**
     * 设置选中项
     * @param obj
     */
    this.setSelectItem=function (obj) {
        this.ivSelect.selectItem=obj;
    }

    /**
     * 禁用
     * @param status
     */
    this.setDisabled=function (status) {
        this.ivSelect.disabled=status;
    }
}