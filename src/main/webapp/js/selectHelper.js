

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
        labelInValue:false,
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

    this.load=function (where) {
        let my=this;
        //加载静态数据
        if(!url){

        }
        //加载动态数据
        else{
            $.ajax({
                url: url,
                type: "POST",
                data: {where:where},
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
    }

    this.getSelectItem=function () {
        return this.ivSelect.selectItem;
    }

}