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

    List<MenuItem> selectMenuAll();

    List<MenuItem> selectMenuByRole(String roleName);

    List<MenuItem> selectButAll(String parentId);

    List<MenuItem> selectButByRole(@Param("roleName") String roleName,@Param("parentId")  String parentId);
}