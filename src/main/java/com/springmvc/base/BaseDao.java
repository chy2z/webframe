package com.springmvc.base;

import com.springmvc.util.DateUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
* @Title: BaseDao
* @Description: 数据访问层基类
* @author chy
* @date 2018/1/13 14:00
*/
public class BaseDao
{
	protected  Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	protected JdbcTemplate jdbcTemplate;

	public ArrayList<Map<String, Object>> queryForList(String sql)
	{
		return (ArrayList<Map<String, Object>>) jdbcTemplate.query(sql, new RowMapper<Map<String, Object>>()
		{
			@Override
			public Map<String, Object> mapRow(ResultSet rs, int rowNum) throws SQLException
			{
				Map<String, Object> map = new HashMap<>();
				int columnCount = rs.getMetaData().getColumnCount();
				for (int i = 1; i < columnCount + 1; i++)
				{
					if (rs.getObject(i) instanceof Timestamp)
					{
						map.put(rs.getMetaData().getColumnName(i), DateUtil.formatDate(rs.getTimestamp(i)));
					} else
					{
						map.put(rs.getMetaData().getColumnName(i), rs.getObject(i));
					}
				}
				return map;
			}
		});
	}

	public ArrayList<Map<String, Object>> queryForList(String sql, Object[] args)
	{
		return (ArrayList<Map<String, Object>>) jdbcTemplate.query(sql, args, new RowMapper<Map<String, Object>>()
		{
			@Override
			public Map<String, Object> mapRow(ResultSet rs, int rowNum) throws SQLException
			{

				Map<String, Object> map = new HashMap<>();
				int columnCount = rs.getMetaData().getColumnCount();
				for (int i = 1; i < columnCount + 1; i++)
				{
					if (rs.getObject(i) instanceof Timestamp)
					{
						map.put(rs.getMetaData().getColumnName(i), DateUtil.formatDate(rs.getTimestamp(i)));
					} else if (rs.getObject(i) instanceof Date) {
						map.put(rs.getMetaData().getColumnName(i), rs.getTime(i));
					}else {
						map.put(rs.getMetaData().getColumnName(i), rs.getObject(i));
					}
				}
				return map;
			}
		});
	}
}
