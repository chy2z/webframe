/**
 审核平台
 */
var Audit={
    // 审核类型
    operationType:{
        sys_notice:"系统通知"
    },
    // 访问地址
    urls:{
        sendAudit_url:"/auditKindProcess/path/sendAudit",
        allowSendAudit:"/auditWait/allowSendAudit",
        allowEditAndDel:"/auditWait/allowEditAndDel"
    },
    // 默认配置
    config:{
        auditState:"auditState",
        title:"送审",
        useId:0,
        departId:0,
        operation:null,
        tName:null,
        tValue:null,
        tKey:null
    },
    initConfig(domian,jwt,operation,useId,departId,vue){
       switch(operation){
           case this.operationType.sys_notice:
               $.extend(this.config,{
                   title:this.operationType.sys_notice+"送审",
                   useId:useId,
                   operation:operation,
                   departId:departId,
                   tName:"sys_notice",
                   tKey:"id",
                   tValue:null
               });
               break;
           default:
               valert(vue,"审核类型找不到");
               break;
       }
       this.urls.sendAudit_url=domian+this.urls.sendAudit_url+"?jwt="+jwt;
       this.urls.allowSendAudit=domian+this.urls.allowSendAudit+"?jwt="+jwt;
       this.urls.allowEditAndDel=domian+this.urls.allowEditAndDel+"?jwt="+jwt;
    },
    canDel(vue,rowIndex,selectRow,callBack){
        if(rowIndex<0){ valert(vue,"请选择一行记录删除!"); return false;}
        if(!selectRow){ valert(vue,"请选择一行记录删除!"); return false;}
        this.config.tValue=selectRow.id;
        vajaxPost(this.urls.allowEditAndDel,this.config,false,(result)=>{
            if(!result||!result.success||!result.data) {
                valert(vue,"审核记录不能删除!");
                return false;
            }
            vconfirm(vue,"确认要删除吗？",()=>{
                callBack&&callBack();
            },()=>{
                return false;
            });
        },()=>{},()=>{},()=>{},true);
    },
    canEdit(vue,rowIndex,selectRow,callBack){
        if(rowIndex<0){ valert(vue,"请选择一行记录修改!"); return false;}
        if(!selectRow){ valert(vue,"请选择一行记录修改!"); return false;}
        this.config.tValue=selectRow.id;
        vajaxPost(this.urls.allowEditAndDel,this.config,false,(result)=>{
            if(!result||!result.success||!result.data) {
                valert(vue,"审核记录不能修改!");
                return false;
            }
            callBack&&callBack();
        },()=>{},()=>{},()=>{},true);
    },
    // 送审
    sendAudit(vue,rowIndex,selectRow,callBack){
        if(rowIndex<0){ valert(vue,"请选择一行记录送审!"); return false;}
        if(!selectRow){ valert(vue,"请选择一行记录送审!"); return false;}
        this.config.tValue=selectRow.id;
        vajaxPost(this.urls.allowSendAudit,this.config,false,(result)=>{
            if(!result||!result.success||!result.data) {
                valert(vue,"记录不能送审!");
                return false;
            }
            vconfirm(vue,"确认要送审吗？",()=>{
                callBack&&callBack();
            },()=>{
                return false;
            });
        },()=>{},()=>{},()=>{},true);
    },
    // 流程图和审核意见
    auditProcess(){

    }
}