package com.springmvc.controller;

import com.springmvc.base.BaseControl;
import com.springmvc.model.Corporation;
import com.springmvc.model.Department;
import com.springmvc.model.Users;
import com.springmvc.service.CorporationService;
import com.springmvc.service.DepartmentService;
import com.springmvc.service.UsersService;
import com.springmvc.util.ExportExcelUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedHashMap;
import java.util.Map;

/**
* @Title: ExportControl
* @Description: 导出接口
* @author chy
* @date 2017/11/8 22:17
*/
@Controller
@RequestMapping("/export")
public class ExportControl extends BaseControl {

    @Autowired
    CorporationService corpService;

    @Autowired
    DepartmentService departmentService;

    @Autowired
    UsersService usersService;

    /**
     * 导出组织机构数据
     * <Connector port="8080" protocol="HTTP/1.1"
     *   connectionTimeout="20000"  redirectPort="8443"  URIEncoding="utf-8" />
     *   URIEncoding="utf-8" 解决get请求中文乱码
     *
     * @param request
     * @param response
     */
    @RequestMapping("/exportCorporation")
    public void exportCorporation(HttpServletRequest request, HttpServletResponse response) {
        String where=request.getParameter("where");
        ExportExcelUtil<Corporation> export= new ExportExcelUtil<Corporation>();
        String[] headers = { "序号", "名称", "编号"};
        String fileName = "组织机构";
        export.exportExcel(headers,corpService.exportForExcel(StringUtil.nullOrString(where)),fileName,response);
    }

    /**
     * 导出部门数据
     * @param request
     * @param response
     */
    @RequestMapping("/exportDepartment")
    public void exportDepartment(HttpServletRequest request, HttpServletResponse response) {
        String where=request.getParameter("where");
        ExportExcelUtil<Department> export= new ExportExcelUtil<Department>();
        String[] headers = { "序号", "名称", "电话","领导","地址","备注"};
        String fileName = "部门";
        export.exportExcel(headers,departmentService.exportForExcel(StringUtil.nullOrString(where)),fileName,response);
    }

    /**
     * 导出用户数据
     * @param request
     * @param response
     */
    @RequestMapping("/exportUsers")
    public void exportUsers(HttpServletRequest request, HttpServletResponse response) {
        String where=request.getParameter("where");
        ExportExcelUtil<Users> export= new ExportExcelUtil<Users>();
        Map headers = new LinkedHashMap();
        headers.put("序号","id");
        headers.put("登录名称","loginname");
        headers.put("名称","name");
        headers.put("密码","password");
        String fileName = "用户信息";
        export.exportExcel(headers,usersService.exportForExcel(StringUtil.nullOrString(where)),fileName,response);
    }

}
