package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.model.PageHelper;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.springmvc.mapper.UsersMapper;
import com.springmvc.model.Users;

import java.util.List;

/**
* @Title: UsersService
* @Description: 用户业务层
* @author chy
* @date 2017/10/18 16:00
*/
@Service
public class UsersService  extends BaseService {

	@Autowired
	private UsersMapper umap;


	/**
	 * 获取用户信息
 	 * @param id
	 * @return
	 */
	public Users getUsers(int id) {
		return umap.selectByPrimaryKey(id);
	}

	/**
	 * 获取用户信息
	 * @param name
	 * @param pwd
	 * @return
	 */
	public Users getUsers(String name,String pwd){
		return umap.selectByNameAndPwd(name,pwd);
	}

	/**
	 * 获取用户数量
	 * @param roleid
	 * @return
	 */
	public int getCountByRole(int roleid){
		return  umap.getUsersCountByRole(roleid);
	}

	/**
	 * 插入记录
	 * @param c
	 * @return
	 */
	public boolean insert(Users c) {
		return umap.insertSelective(c) > 0;
	}

	/**
	 * 更新用户信息
	 * 
	 * @param u
	 * @return
	 */
	public boolean update(Users u) {
		return umap.updateByPrimaryKeySelective(u) > 0;
	}

	/**
	 * 删除记录
	 * @param id
	 * @return
	 */
	public boolean delete(Integer id) {
		return umap.deleteByPrimaryKey(id) > 0;
	}

	/**
	 * 导出数据
	 * @param where
	 * @return
	 */
	public List<Users> exportForExcel(String where){
		return  umap.exportForExcel(where);
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

		ph.setTotalCount(umap.getCount(ph.getWhere(),ph.getOrderBy()));

		ph.setResult(umap.selectPagination(ph.getWhere(),ph.getOrderBy(),ph.getStart(),ph.getPageSize()));

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
