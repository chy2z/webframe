package com.springmvc.service;

import com.springmvc.enums.AuditEnableType;
import com.springmvc.enums.AuditStateType;
import com.springmvc.mapper.AuditWaitMapper;
import com.springmvc.model.AuditKindProcess;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;

/**
* @Title: AuditWaitService
* @Description: 等待审核业务层
* @author chy
* @date 2018/1/13 15:49
*/
@Service
public class AuditWaitService {

    @Autowired
    AuditWaitMapper mapper;

    @Autowired
    AuditKindProcessService auditKindProcessService;

    /**
     * 允许修改和删除记录
     * @param auditState
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    public boolean allowEditAndDel(String auditState,
                                   String tName,
                                   String tKey,
                                   String tValue){
        String state=mapper.getAuditState(auditState,tName,tKey,tValue);

        // 判断状态
        if(null!=state){

            // 判断通过状态
            if(AuditStateType.TG.getName().equals(state)){

                // 判断流程是否启用
                Integer pid=mapper.getAuditProcess(tName,tKey,tValue);

                // 流程存在
                if(null!=pid){

                    AuditKindProcess p= auditKindProcessService.getAuditKindProcess(pid);

                    if(null==p){
                        return  true;
                    }
                    else {
                        // 流程启用
                        if (AuditEnableType.YES.getName().equals(p.getEnable())) {
                            return  false;
                        }
                        else {
                            return true;
                        }
                    }
                }
                else {
                    return true;
                }

            }
            else if(AuditStateType.SHZ.getName().equals(state)){
                return  false;
            }
            else{
                return  true;
            }
        }
        else{
            return  true;
        }
    }

    /**
     * 判断是否允许送审
     * @param operation
     * @param departId
     * @param auditState
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    public boolean allowSendAudit(String operation,String departId,String auditState,
                                  String tName,
                                  String tKey,
                                  String tValue) {

        String state = mapper.getAuditState(auditState, tName, tKey, tValue);

        // 判断状态
        if (null != state) {
            // 通过和审核中的不能送审
            if (state.equals(AuditStateType.TG.getName()) || state.equals(AuditStateType.SHZ.getName())) {
                return false;
            }
            // 打回和新申请
            else {

                Integer count = mapper.getAuditProcessCount(operation, departId, AuditEnableType.YES.getName());

                // 存在审核流程才能送审
                if (count != 0) {
                    return true;
                } else {
                    return false;
                }
            }
        } else {
            return true;
        }
    }

    /**
     * 获取送审状态
     * @param operation
     * @param departId
     * @return
     */
    public String getAuditState(String operation,String departId){

        Integer count = mapper.getAuditProcessCount(operation, departId, AuditEnableType.YES.getName());

        // 存在审核流程才能送审
        if (count != 0) {
            return AuditStateType.XSQ.getName();
        } else {
            return AuditStateType.TG.getName();
        }
    }

    /**
     * 获取送审状态
     * @param request
     * @return
     */
    public String getAuditState(HttpServletRequest request){
        String operation=request.getParameter("operation");
        String departId=request.getParameter("departId");
        return  getAuditState(operation,departId);
    }
}
