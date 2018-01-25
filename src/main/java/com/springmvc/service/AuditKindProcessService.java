package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.AuditKindProcessMapper;
import com.springmvc.model.AuditKindProcess;
import com.springmvc.model.AuditKindProcessStep;
import com.springmvc.model.PageHelper;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
* @Title: AuditKindProcessService
* @Description: 审核流程接口
* @author chy
* @date 2017/12/29 14:00
*/
@Service
public class AuditKindProcessService extends BaseService {

    @Autowired
    AuditKindProcessMapper mapper;

    @Autowired
    AuditKindProcessStepService auditKindProcessStepService;

    /**
     * 获取信息
     * @param id
     * @return
     */
    public AuditKindProcess getAuditKindProcess(Integer id) {
        return mapper.selectByPrimaryKey(id);
    }

    /**
     * 增加流程和流程步骤
     * @param p
     * @param steps
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    public boolean insertStep(AuditKindProcess p,List<AuditKindProcessStep> steps) {
        int result = mapper.insertSelective(p);
        for (AuditKindProcessStep s : steps) {
            s.setPid(p.getId());
            if (auditKindProcessStepService.insert(s)) {
                result++;
            }
        }
        return result > 0;
    }

    /**
     * 更新流程和流程步骤
     * @param p
     * @param steps
     * @param editStep 是否更新步骤
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    public boolean updateStep(AuditKindProcess p,List<AuditKindProcessStep> steps,int editStep) {
        int result = mapper.updateByPrimaryKeySelective(p);
        if (editStep != 0) {
            //删除旧节点
            if (auditKindProcessStepService.deleteByPId(p.getId())) {
                //插入新节点
                for (AuditKindProcessStep s : steps) {
                    s.setPid(p.getId());
                    if (auditKindProcessStepService.insert(s)) {
                        result++;
                    }
                }
            }
        }
        return result > 0;
    }

    /**
     * 更新记录
     * @param p
     * @return
     */
    public boolean update(AuditKindProcess p) {
        return mapper.updateByPrimaryKeySelective(p) > 0;
    }


    /**
     * 删除记录
     * @param id
     * @return
     */
    @Transactional(rollbackFor = Exception.class)
    public boolean delete(Integer id) {
        mapper.deleteByPrimaryKey(id);

        /**
         * 同时删除审核步骤
         */
        return auditKindProcessStepService.deleteByPId(id);
    }

    /**
     * 返回分页数据
     * @param pageNo
     * @param pageSize
     * @param where
     * @param orderBy
     * @return
     */
    public PageHelper getPagination(int pageNo, int pageSize, String where , String orderBy){

        PageHelper ph=new PageHelper();

        ph.setPageNo(pageNo);

        ph.setPageSize(pageSize);

        ph.setWhere(StringUtil.nullOrString(where));

        ph.setOrderBy(StringUtil.nullOrString(orderBy));

        ph.setTotalCount(mapper.getCount(ph.getWhere(),ph.getOrderBy()));

        ph.setResult(mapper.selectPagination(ph.getWhere(),ph.getOrderBy(),ph.getStart(),ph.getPageSize()));

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
    public String toPaginationJson(int pageNo,int pageSize,String where ,String orderBy) {
        return JsonUtil.writeValueAsString(getPagination(pageNo, pageSize, where, orderBy));
    }

}