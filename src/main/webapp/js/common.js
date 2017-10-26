/**
 * 输出日志
 * @param msg
 */
function log(msg){
    console.log(msg);
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
            okEvent&&okEvent(vue);
        },
        onCancel: () => {
            cancelEvent&&cancelEvent(vue);
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

