package com.springmvc.service;

import com.springmvc.mapper.UsersControlLogMapper;
import com.springmvc.model.PageHelper;
import com.springmvc.model.UsersControlLog;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
* @Title: UsersControlLogService
* @Description: 用户控制日志业务
* @author chy
* @date 2018/2/5 15:46 
*/
@Service
public class UsersControlLogService {

    @Autowired
    UsersControlLogMapper mapper;

    /**
     * 插入
     *
     * @param u
     * @return
     */
    public boolean insert(UsersControlLog u) {
        return mapper.insertSelective(u) > 0;
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

        ph.setTotalCount(mapper.getCount(ph.getWhere(), ph.getOrderBy()));

        ph.setResult(mapper.selectPagination(ph.getWhere(), ph.getOrderBy(), ph.getStart(), ph.getPageSize()));

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
