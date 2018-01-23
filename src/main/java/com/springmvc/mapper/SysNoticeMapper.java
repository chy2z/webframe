package com.springmvc.mapper;

import com.springmvc.model.SysNotice;
import com.springmvc.model.Users;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
* @Title: SysNoticeMapper
* @Description:系统通知操作接口
* @author chy
* @date 2017/12/13 10:11
*/
public interface SysNoticeMapper {

    int deleteByPrimaryKey(Integer id);

    int insertSelective(SysNotice record);

    SysNotice selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysNotice record);

    /**
     * 获取最新的消息
     * @param top
     * @return
     */
    List<SysNotice> selectTopNewest(@Param("where") String where,@Param("top") Integer top);

    /**
     * 根据条件获取记录数
     * @param where
     * @param orderBy
     * @return
     */
    int getCount(@Param("where") String where, @Param("orderBy") String orderBy);

    /**
     * 分页获取记录
     * @param where
     * @param orderBy
     * @param start
     * @param pageSize
     * @return
     */
    List<Users> selectPagination(@Param("where") String where,
                                 @Param("orderBy") String orderBy,
                                 @Param("start") Integer start,
                                 @Param("pageSize") Integer pageSize
    );
}