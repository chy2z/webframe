
String.prototype.Trim = function(){
    return this.replace(/(^\s*)|(\s*$)/g, "");
}

String.prototype.LTrim = function(){
    return this.replace(/(^\s*)/g, "");
}

String.prototype.RTrim = function(){
    return this.replace(/(\s*$)/g, "");
}

/**
 * 是否空字符
 * @param obj
 * @returns {boolean}
 */
function isBlank(obj){
   if(obj==null||obj==""){
       return true;
   }
   else {
       return false;
   }
}

/**
 // 对Date的扩展，将 Date 转化为指定格式的String
 // 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
 // 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
 // 例子：
 // (new Date()).Format("yyyy-MM-dd HH:mm:ss.S") ==> 2006-07-02 08:09:04.423
 // (new Date()).Format("yyyy-M-d H:m:s.S")      ==> 2006-7-2 8:9:4.18 *
 *
 * @param fmt
 * @returns {*}
 * @constructor
 */
Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "H+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

/**
 * 存储授权信息
 * @param v
 */
function vSetAuthenticationStorage(v) {
    sessionStorage.setItem("jwt",v);
}

/**
 * 获取授权信息
 */
function vGetAuthenticationStorage() {
    return sessionStorage.getItem("jwt");
}

/**
 * 全局窗体显示
 * @param action
 * @param url
 * @param title
 */
function vPopWindowShow(action,url,title){
    window.parent.popShow(action,url,title);
}

/**
 * 全局窗体关闭
 * @param result
 */
function vPopWindowsColse(parameter){
    window.parent.popClose(parameter);
}

/**
 * Unicode转换成中文
 * @param str
 */
function decodeUnicode(str) {
    return unescape(str.replace(/\\u/g, "%u"));
}

/**
 * 验证手机号码
 * @param phone
 * @returns {boolean}
 */
function validatePhone(phone){
    var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
    if(!myreg.test(phone)){
        return false;
    }
    else{
        return true;
    }
}

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
 * 整页加载 等待效果
 * @param delayedClosing
 */
function vSpin(vue,delayedClosing){
    vue.$Spin.show();
    if(!delayedClosing){
           delayedClosing=2000;
    }
    setTimeout(() => {
        vue.$Spin.hide();
    }, delayedClosing);
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

    /**
     * vue 默认子页面弹出
     */

    /**
     * 改成在main页面弹出
     */
    vue=window.parent.mainVue||vue;

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
    /**
     * vue 默认子页面弹出
     */

    /**
     * 改成在main页面弹出
     */
    vue=window.parent.mainVue||vue;

    vue.$Modal.confirm({
        title: '确认提示框',
        content: content,
        okText: '确定',
        cancelText: '取消',
        onOk: () => {
            //防止关闭$Modal对话框冲突
            setTimeout(() => {
                okEvent&&okEvent();
            },500);
        },
        onCancel: () => {
            //防止关闭$Modal对话框冲突
            setTimeout(() => {
                cancelEvent&&cancelEvent();
            },500);
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
    /**
     * vue 默认子页面弹出
     */

    /**
     * 改成在main页面弹出
     */
    vue=window.parent.mainVue||vue;

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