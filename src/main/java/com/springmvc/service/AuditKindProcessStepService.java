package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.AuditKindProcessStepMapper;
import com.springmvc.model.AuditKindProcessStep;
import com.springmvc.model.PageHelper;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @Title: AuditKindProcessStepService
* @Description: 审核流程步骤接口
* @author chy
* @date 2017/12/29 14:43
*/
@Service
public class AuditKindProcessStepService extends BaseService {

    @Autowired
    AuditKindProcessStepMapper mapper;

    /**
     * 根据流程获取所有步骤
     * @param pid
     * @return
     */
    public List<AuditKindProcessStep> getList(Integer pid) {
        return mapper.selectByPid(pid);
    }

    /**
     * 插入记录
     * @param c
     * @return
     */
    public boolean insert(AuditKindProcessStep c) {
        return mapper.insertSelective(c) > 0;
    }

    /**
     * 更新记录
     * @param c
     * @return
     */
    public boolean update(AuditKindProcessStep c) {
        return mapper.updateByPrimaryKeySelective(c) > 0;
    }

    /**
     * 根据流程步骤获取步骤
     * 同一个步骤可能有多个审核人(或关系)
     * @param pid
     * @param step
     * @return
     */
    public List<AuditKindProcessStep> getAuditKindProcessStep(Integer pid,Integer step){
       return mapper.selectByEnableStep(pid,step);
    }


    /**
     * 批量删除记录
     * @param pid
     * @return
     */
    public boolean deleteByPId(Integer pid){
        return mapper.deleteByProcessId(pid) > 0;
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