/**
 * 输出日志
 * @param msg
 */
function log(msg,target){
    if(!target){
        console.log(msg);
    }
    else{
        console.log("--------"+target+"--------");
        console.log(msg);
        console.log("--------"+target+"--------");
    }
}

/**
 * alert提示框
 * alert(this,"请输入查询条件");
 * @param vue
 * @param content 提示内容
 * @param title   提示标题
 * @param type    提示类型
 *
 */
function valert(vue,content,title,type) {
    title=title||"信息提示";
    if(!type) {
        vue.$Modal.warning({
            title: title,
            content: content
        });
    }
    else{
        switch (type) {
            case 'info':
                vue.$Modal.info({
                    title: title,
                    content: content
                });
                break;
            case 'success':
                vue.$Modal.success({
                    title: title,
                    content: content
                });
                break;
            case 'warning':
                vue.$Modal.warning({
                    title: title,
                    content: content
                });
                break;
            case 'error':
                vue.$Modal.error({
                    title: title,
                    content: content
                });
                break;
        }
    }
}

/**
 * 确认对话框
 * confirm(this,"确认删除吗?",function(v){
                        toast(v,"确定","success");
                    },function (v) {
                        toast(v,"取消","success");
                    });
 *
 *
 * @param vue
 * @param content
 */
function vconfirm(vue,content,okEvent,cancelEvent){
    vue.$Modal.confirm({
        title: '确认提示框',
        content: content,
        okText: '确定',
        cancelText: '取消',
        onOk: () => {
            okEvent&&okEvent();
        },
        onCancel: () => {
            cancelEvent&&cancelEvent();
        }
    });
}

/**
 * toast 消息提示
 * toast(this,"增加一行记录","success");
 * @param vue
 * @param content 提示内容
 * @param type    类型
 * @param duration
 */
function vtoast(vue,content,type,duration){
    duration=duration||4;
    if(!type) {
        vue.$Message.info({
            content: content,
            duration: duration,
            closable: true
        });
    }
    else{
        switch (type) {
            case 'info':
                vue.$Message.info({
                    content: content,
                    duration: duration,
                    closable: true
                });
                break;
            case 'success':
                vue.$Message.success({
                    content: content,
                    duration: duration,
                    closable: true
                });
                break;
            case 'warning':
                vue.$Message.warning({
                    content: content,
                    duration: duration,
                    closable: true
                });
                break;
            case 'error':
                vue.$Message.error({
                    content: content,
                    duration: duration,
                    closable: true
                });
                break;
            case 'loading':
                vue.$Message.loading({
                    content: content,
                    duration: duration,
                    closable: true
                });
                break;
        }
    }
}

/**
 * jquery ajax 请求
 * @param url
 * @param data
 * @param dataTypeJson
 * @param successEvnent
 * @param completeEvnent
 * @param beforeSendEvent
 * @param errorEvent
 */
function vajaxPost(url,data,dataTypeJson,successEvnent,beforeSendEvent,completeEvnent,errorEvent){

    if($==null){ alert("$不是对象"); return ; }

    let ajaxConfig={
        url: url,
        type: "POST",
        data: dataTypeJson?$.toJSON(data):data,
        beforeSend:function(){
            beforeSendEvent&&beforeSendEvent();
        },
        complete:function(){
            completeEvnent&&completeEvnent();
        },
        success: function(result){
            successEvnent&&successEvnent(result);
        },
        error: function(res){
            alert(res.responseText);
            errorEvent&&errorEvent(res);
        }
    };

    if(dataTypeJson) {
        ajaxConfig = $.extend(ajaxConfig, {
            dataType: "json",
            contentType: 'application/json;charset=utf-8'
        });
    }

    //log(ajaxConfig);

    $.ajax(ajaxConfig);
}