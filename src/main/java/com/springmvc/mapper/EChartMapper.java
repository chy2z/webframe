package com.springmvc.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
* @Title: EChartMapper
* @Description: mybatis 图表
* @author chy
* @date 2017/11/21 10:32
*/
public interface EChartMapper {

    /**
     * 查询某个用户最近几年的登录统计
     * @return
     */
    public List<Map<String,Object>> getLoginLogLastNYearsForYearCity(@Param("usersId") int usersId, @Param("num") int num);


    /**
     * 查询某个用户最近几年的登录统计
     * @return
     */
    public List<Map<String,Object>> getLoginLogLastNYearsForCityYear(@Param("usersId") int usersId, @Param("num") int num);

    /**
     * 查询某个用户最近几年的登录统计
     * @return
     */
    public List<Map<String,Object>> getLoginLogLastNYearsForCity(@Param("usersId") int usersId, @Param("num") int num);

}
