package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.UsersLoginLogMapper;
import com.springmvc.model.PageHelper;
import com.springmvc.model.UsersLoginLog;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
* @Title: UsersLoginLogService
* @Description: 用户登录日志业务层
* @author chy
* @date 2017/11/20 9:55
*/
@Service
public class UsersLoginLogService extends BaseService {

    @Autowired
    UsersLoginLogMapper usersLoginLogMapper;

    /**
     * 插入登录信息
     *
     * @param u
     * @return
     */
    public boolean insert(UsersLoginLog u) {
        return usersLoginLogMapper.insertSelective(u) > 0;
    }

    /**
     * 获取登录信息
     *
     * @param id
     * @return
     */
    public UsersLoginLog getUsersLoginLog(int id) {
        return usersLoginLogMapper.selectByPrimaryKey(id);
    }

    /**
     * 获取最后一次登录信息
     *
     * @param userid
     * @return
     */
    public UsersLoginLog selectLast(int userid) {
        return usersLoginLogMapper.selectLast(userid);
    }

    /**
     * 保存登录信息
     *
     * @param useid
     * @param token
     * @param ip
     * @param country
     * @param region
     * @param city
     * @return
     */
    public boolean saveLogin(int useid,String token, String ip, String country, String region, String city) {

        //上一次登录信息
        UsersLoginLog ulogLast = selectLast(useid);

        //本次登录信息
        UsersLoginLog ulog = new UsersLoginLog();
        ulog.setLastid(ulogLast == null ? 0 : ulogLast.getId());
        ulog.setToken(token);
        ulog.setIp(ip);
        ulog.setUsersid(useid);
        ulog.setCountry(country);
        ulog.setProvince(region);
        ulog.setCity(city);
        ulog.setResult("登录成功");
        ulog.setCreatedate(new Date());

        return insert(ulog);
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

        ph.setTotalCount(usersLoginLogMapper.getCount(ph.getWhere(), ph.getOrderBy()));

        ph.setResult(usersLoginLogMapper.selectPagination(ph.getWhere(), ph.getOrderBy(), ph.getStart(), ph.getPageSize()));

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