package com.springmvc.service;

import com.springmvc.mapper.AuditKindProcessStepMapper;
import com.springmvc.model.AuditKindProcessStep;
import com.springmvc.model.PageHelper;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
* @Title: AuditKindProcessStepService
* @Description: 审核流程步骤接口
* @author chy
* @date 2017/12/29 14:43
*/
@Service
public class AuditKindProcessStepService {

    @Autowired
    AuditKindProcessStepMapper mapper;

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
     * 删除记录
     * @param id
     * @return
     */
    public boolean delete(Integer id) {
        return mapper.deleteByPrimaryKey(id) > 0;
    }

    /**
     * 删除记录
     * @param Pid
     * @return
     */
    public boolean deleteByPId(Integer Pid){
        return mapper.deleteByProcessId(Pid) > 0;
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