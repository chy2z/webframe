package com.springmvc.service;

import com.springmvc.config.LanguageFactory;
import com.springmvc.enums.AuditEnableType;
import com.springmvc.enums.AuditStateType;
import com.springmvc.mapper.AuditWaitMapper;
import com.springmvc.model.AuditKindProcess;
import com.springmvc.model.AuditWait;
import com.springmvc.model.PageHelper;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

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
     * 选择审核类型
     * @param c
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    public boolean selectAudit(AuditWait c,String tName,
                                String tKey, String tValue) {
        int result = mapper.insertSelective(c);
        result += mapper.updateOperation(tName, tKey, tValue,c.getStatus());
        return result > 0;
    }


    /**
     * 取消审核
     * @param awid
     * @param uid
     * @return
     */
    @Transactional(isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
    public boolean auditCancel(String awid, String uid) {
        AuditWait aw = getAuditWait(Integer.parseInt(awid));
        aw.setId(Integer.parseInt(awid));
        aw.setStatus(AuditStateType.DH.getName());

        // 更新审核记录 和 送审记录
        if (update(aw)&&updateOperation(aw.getTname(),aw.getTkey(),aw.getTvalue(),AuditStateType.DH.getName())) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 更新送审记录的审核状态
     * @param tName
     * @param tKey
     * @param tValue
     * @param auditState
     * @return
     */
    public boolean updateOperation(String tName,String tKey, String tValue,String auditState) {
        return mapper.updateOperation(tName, tKey, tValue, auditState) > 0;
    }

    /**
     * 根据审核类型获取待审核记录数
     * （用于判断审核类型是否可以修改）
     * @param pid
     * @return
     */
    public int getCountByPid(Integer pid) {
        return mapper.getCountByPid(pid);
    }

    /**
     * 获取待审核信息
     * @param id
     * @return
     */
    public AuditWait getAuditWait(Integer id) {
        return mapper.selectByPrimaryKey(id);
    }

    /**
     * 获取最新的待审核信息
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    public AuditWait getNewestAuditWait(String tName,String tKey, String tValue) {
        return mapper.selectNewest(tName, tKey, tValue);
    }

    /**
     * 插入记录
     * @param c
     * @return
     */
    public boolean insert(AuditWait c) {
        return mapper.insertSelective(c) > 0;
    }

    /**
     * 更细记录
     * @param c
     * @return
     */
    public boolean update(AuditWait c) {
        return mapper.updateByPrimaryKeySelective(c) > 0;
    }

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
                                  String tName,String tKey,String tValue) {

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
     * 判断是否查看审核流程
     * @param operation
     * @param departId
     * @param auditState
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    public boolean allowViewProcess(String operation,String departId,String auditState,
                                    String tName,String tKey, String tValue) {
        String state = mapper.getAuditState(auditState, tName, tKey, tValue);

        // 判断状态
        if (null != state) {
            // 新申请不能查看
            if (state.equals(AuditStateType.XSQ.getName())) {
                return false;
            }
            // 打回、审核中
            else if (state.equals(AuditStateType.DH.getName()) || state.equals(AuditStateType.SHZ.getName())) {
                return true;
            }
            // 通过
            else {
                Integer pid = mapper.getAuditProcess(tName, tKey, tValue);
                // 存在送审才能查看流程图
                if (pid!=null&&pid != 0) {
                    return true;
                } else {
                    return false;
                }
            }
        } else {
            return false;
        }
    }

    /**
     * 获取审核流程类型
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    public Integer getAuditProcess(String tName, String tKey, String tValue) {
        return mapper.getAuditProcess(tName, tKey, tValue);
    }

    /**
     * 获取送审记录审核状态
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
     * 获取送审记录审核状态
     * @param request
     * @return
     */
    public String getAuditState(HttpServletRequest request){
        String operation=request.getParameter("operation");
        String departId=request.getParameter("departId");
        return  getAuditState(operation,departId);
    }


    /**
     * 获取待审核记录数
     * @param where
     * @return
     */
    public int getAuditWaitCount(String where) {
        return mapper.getAuditWaitCount(where);
    }

    /**
     * 返回分页数据
     * @param pageNo
     * @param pageSize
     * @param where
     * @param orderBy
     * @return
     */
    public PageHelper getPagination(int pageNo, int pageSize, String where , String orderBy,String whereInner,String orderInner){

        PageHelper ph=new PageHelper();

        ph.setPageNo(pageNo);

        ph.setPageSize(pageSize);

        ph.setWhere(StringUtil.nullOrString(where));

        ph.setOrderBy(StringUtil.nullOrString(orderBy));

        ph.setWhereInner(whereInner);

        ph.setOrderByInner(orderInner);

        ph.setTotalCount(mapper.getCount(ph.getWhere(),ph.getOrderBy(),ph.getWhereInner(),ph.getOrderByInner()));

        ph.setResult(mapper.selectPagination(ph.getWhere(),ph.getOrderBy(),ph.getStart(),ph.getPageSize(),ph.getWhereInner(),ph.getOrderByInner()));

        return ph;
    }

    /**
     * 返回分页json数据
     * @param pageNo
     * @param pageSize
     * @param where
     * @param orderBy
     * @return
     */
    public String toPaginationJson(int pageNo,int pageSize,String where ,String orderBy,String whereInner,String orderInner ) {
        return JsonUtil.writeValueAsString(getPagination(pageNo, pageSize, where, orderBy,whereInner,orderInner));
    }
}
