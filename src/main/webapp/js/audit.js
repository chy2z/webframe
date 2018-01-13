/**
 审核平台
 */
var Audit={
    // 审核类型
    operations:{
        sys_notice:"系统通知"
    },
    // 默认配置
    config:{
        operation:null,
        state:null,
        tName:null,
        tKey:null,
        tValue:null
    },
    initConfig(operation,vue){
       switch(operation){
           case this.operations.sys_notice:
               $.extend(config,{
                   operation:operation,
                   tName:"sys_notice",
                   tKey:"id",
                   tValue:null
               });
               break;
           default:
               valert(vue,"审核类型找不到");
               break;
       }
    },
    canDel(domain,selectRow,vue){
        if(!selectRow){ alert("请选择一行记录删除!"); return false;}
        let url=domain+"/";
        this.config.state=selectRow.auditState;
        vajaxPost(url,config,false,(result)=>{
            log("-------------1-----------");
            if(!result||!result.success||!result.data) {
                alert("记录不能删除!");
                return false;
            }
            vconfirm(vue,"确认要删除吗？",()=>{
                return true;
            },()=>{
                return false;
            });
        },()=>{},()=>{},()=>{},true);

        log("-------------2-----------");
    },
    canEdit(){

    },
    // 送审
    auditSend(){

    },
    // 流程图和审核意见
    auditProcess(){

    }
}