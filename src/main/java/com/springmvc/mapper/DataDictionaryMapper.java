package com.springmvc.mapper;

import com.springmvc.model.DataDictionary;

public interface DataDictionaryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(DataDictionary record);

    int insertSelective(DataDictionary record);

    DataDictionary selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(DataDictionary record);

    int updateByPrimaryKey(DataDictionary record);
}