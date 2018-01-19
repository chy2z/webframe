/**
 * 选择列表
 * @param url
 * @param ivSelectConfig
 */
function selectHelper(url,ivSelectConfig){

    this.ivSelect=$.extend({
        // 绑定的数据项启用
        vModel:true,
        // 绑定的数据项
        selectItem:null,
        // 在 remote 模式下，初始化时使用。因为仅通过 value 无法得知选项的 label，需手动设置
        label:null,
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
     * 配置选中项 value
     * @returns {null}
     */
    this.getSelectItem=function () {
        if (this.ivSelect.vModel) {
            return this.ivSelect.selectItem;
        }
        else {
            alert("获取选择项被禁用");
        }
    }

    /**
     * 设置选中项
     * 问题：初始化时使用。因为仅通过 value 无法得知选项的 label，需手动设置
     * 解决方法：始化时使用,延迟执行可以解决
     * @param obj
     */
    this.setSelectItem=function (value) {
        this.ivSelect.selectItem=value;
    }

    /**
     * 禁用
     * @param status
     */
    this.setDisabled=function (status) {
        this.ivSelect.disabled=status;
    }
}