package com.springmvc.mapper;

import com.springmvc.model.MenuItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuItemMapper {
    int deleteByPrimaryKey(String id);

    int insert(MenuItem record);

    int insertSelective(MenuItem record);

    MenuItem selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(MenuItem record);

    int updateByPrimaryKey(MenuItem record);

    /**
     * 获取超级管理员菜单
     * @return
     */
    List<MenuItem> selectMenuAll();

    /**
     * 获取角色菜单
     * @return
     */
    List<MenuItem> selectMenuByRole(String roleName);

    /**
     * 获取超级管理员按钮
     * @return
     */
    List<MenuItem> selectButAll(String parentId);

    /**
     * 获取角色按钮
     * @return
     */
    List<MenuItem> selectButByRole(@Param("roleId") String roleId,@Param("parentId")  String parentId);

    /**
     * 获取全部权限
     * @return
     */
    List<MenuItem> selectRightsAll(@Param("roleId") String roleId);

    /**
     * 获取拥有权限
     * @return
     */
    List<MenuItem> selectRightsOwn(@Param("roleId") String roleId);
}