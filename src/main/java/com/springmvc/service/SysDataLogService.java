package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.SysDataLogMapper;
import com.springmvc.model.PageHelper;
import com.springmvc.model.SysDataLog;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
* @Title: SysDataLogService
* @Description: 数据操作日志
* @author chy
* @date 2018/2/3 16:33
*/
@Service
public class SysDataLogService extends BaseService {

    @Autowired
    SysDataLogMapper sysDataLogMapper;

    /**
     * 插入
     *
     * @param s
     * @return
     */
    public boolean insert(SysDataLog s) {
        return sysDataLogMapper.insertSelective(s) > 0;
    }

    /**
     * 返回分页数据
     *
     * @param pageNo
     * @param pageSize
     * @param where
     * @param orderBy
     * @return
     */
    public PageHelper getPagination(int pageNo, int pageSize, String where, String orderBy) {

        PageHelper ph = new PageHelper();

        ph.setPageNo(pageNo);

        ph.setPageSize(pageSize);

        ph.setWhere(StringUtil.nullOrString(where));

        ph.setOrderBy(StringUtil.nullOrString(orderBy));

        ph.setTotalCount(sysDataLogMapper.getCount(ph.getWhere(), ph.getOrderBy()));

        ph.setResult(sysDataLogMapper.selectPagination(ph.getWhere(), ph.getOrderBy(), ph.getStart(), ph.getPageSize()));

        return ph;
    }

    /**
     * 返回分页json数据
     *
     * @param pageNo
     * @param pageSize
     * @param where
     * @param orderBy
     * @return
     */
    public String toPaginationJson(int pageNo, int pageSize, String where, String orderBy) {
        return JsonUtil.writeValueAsString(getPagination(pageNo, pageSize, where, orderBy));
    }

}
