package com.springmvc.controller;

import com.springmvc.model.Corporation;
import com.springmvc.service.CorporationService;
import com.springmvc.util.ExportExcelUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
* @Title: ExportControl
* @Description: 导出接口
* @author chy
* @date 2017/11/8 22:17
*/
@Controller
@RequestMapping("/export")
public class ExportControl {

    @Autowired
    CorporationService corpService;

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
        String fileName = "组织管理";
        export.exportExcel(headers,corpService.exportForExcel(StringUtil.NullOrString(where)),fileName,response);
    }

}
