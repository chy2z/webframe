/**
 审核平台
 */
var Audit={
    // 审核类型
    operationType:{
        sys_notice:"系统通知",
        sys_other:""
    },
    // 访问地址
    urls:{
        auditProcess_url:"/auditKindProcess/path/flowProcessView",
        sendAudit_url:"/auditKindProcess/path/sendAudit",
        selectAudit_url:"/auditWait/selectAudit",
        allowViewProcess:"/auditWait/allowViewProcess",
        allowSendAudit:"/auditWait/allowSendAudit",
        allowEditAndDel:"/auditWait/allowEditAndDel"
    },
    // 默认配置
    config:{
        auditState:"auditState",
        title:"送审",
        content:"",
        useId:0,
        departId:0,
        operation:null,
        tName:null,
        tValue:null,
        tKey:null,
        url:null
    },
    // 初始化配置
    initConfig(vue,domian,jwt,operation,useId,departId,other){
       switch(operation){
           case this.operationType.sys_notice:
               $.extend(this.config,{
                   title:this.operationType.sys_notice+"送审",
                   useId:useId,
                   operation:operation,
                   departId:departId,
                   tName:"sys_notice",
                   tKey:"id",
                   url:domian+"/sysNotice/path/look"
               });
               break;
           case this.operationType.sys_other:
               $.extend(this.config,{
                   title:this.operationType.sys_notice+"送审",
                   useId:useId,
                   operation:operation,
                   departId:departId,
                   tName:"sys_other",
                   tKey:"id",
                   url:url
               });
               break;
           default:
               valert(vue,"审核类型找不到");
               break;
       }
       this.urls.selectAudit_url=domian+this.urls.selectAudit_url+"?jwt="+jwt;
       this.urls.auditProcess_url=domian+this.urls.auditProcess_url+"?jwt="+jwt;
       this.urls.sendAudit_url=domian+this.urls.sendAudit_url+"?jwt="+jwt+"&operation="+encodeURIComponent(operation);
       this.urls.allowViewProcess=domian+this.urls.allowViewProcess+"?jwt="+jwt;
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
    sendAudit(vue,rowIndex,selectRow,getContent,callBack){
        if(rowIndex<0){ valert(vue,"请选择一行记录送审!"); return false;}
        if(!selectRow){ valert(vue,"请选择一行记录送审!"); return false;}
        this.config.tValue=selectRow.id;
        this.config.content=getContent(selectRow);
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
    // 选择审核类型
    selectAudit(vue,rowIndex,selectRow,callBack){
        if(rowIndex<0){ valert(vue,"请选择审核类型!"); return false;}
        if(!selectRow){ valert(vue,"请选择审核类型!"); return false;}
        vconfirm(vue,"确认要送审吗？",()=>{
            let cacheConfig=VPopConfig();
            this.config.tValue=cacheConfig.tValue;
            this.config.content=cacheConfig.content;
            vajaxPost(this.urls.selectAudit_url,$.extend(this.config,{pid:selectRow.id}),false,(result)=>{
                if(!result||!result.success||!result.data) {
                    valert(vue,"记录送审失败!");
                    return false;
                }
                vtoast(vue,"送审成功");
                callBack&&callBack();
            },()=>{},()=>{},()=>{},true);
        },()=>{
            return false;
        });
    },
    // 流程进度图和审核意见
    auditProcess(vue,rowIndex,selectRow,callBack){
        if(rowIndex<0){ valert(vue,"请选择一行记录送审!"); return false;}
        if(!selectRow){ valert(vue,"请选择一行记录送审!"); return false;}
        if(selectRow.auditstate==vLang.audit.new){
            valert(vue,"记录不能查看审核进度!"); return false;
        }
        this.config.tValue=selectRow.id;
        let url=this.urls.auditProcess_url+"&tName="+this.config.tName+"&tKey="+this.config.tKey+"&tValue="+this.config.tValue;
        vajaxPost(this.urls.allowViewProcess,this.config,false,(result)=>{
            if(!result||!result.success||!result.data) {
                valert(vue,"记录不能查看审核进度!");
                return false;
            }
            callBack&&callBack(url);
        },()=>{},()=>{},()=>{},true);
    }
}