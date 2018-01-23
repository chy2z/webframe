package com.springmvc.controller;

import com.springmvc.base.BaseControl;
import com.springmvc.model.UsersToken;
import com.springmvc.service.EChartService;
import com.springmvc.service.UsersTokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
* @Title: EChartControl
* @Description: 图表接口
* @author chy
* @date 2017/11/20 14:25
*/
@Controller
@RequestMapping("/chart")
public class EChartControl extends BaseControl {

    @Autowired
    EChartService chartService;

    @Autowired
    UsersTokenService utService;

    /**
     * 查询某个用户最近几年的登录统计
     *
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping("/getLoginLogLastNYears/bar/horizontal")
    public String getLoginLogLastNYearsH(HttpServletRequest request, HttpServletResponse response){

        String jwt=request.getParameter("jwt");

        String num=request.getParameter("num");

        UsersToken ut= utService.getUsersToken(jwt);

        return  chartService.getLoginLogLastNYearsH(ut.getUserid(),Integer.parseInt(num));
    }

    @ResponseBody
    @RequestMapping("/getLoginLogLastNYears/bar/vertical")
    public String getLoginLogLastNYearsV(HttpServletRequest request, HttpServletResponse response){

        String jwt=request.getParameter("jwt");

        String num=request.getParameter("num");

        UsersToken ut= utService.getUsersToken(jwt);

        return  chartService.getLoginLogLastNYearsV(ut.getUserid(),Integer.parseInt(num));
    }


    @ResponseBody
    @RequestMapping("/getLoginLogLastNYears/bar/stack")
    public String getLoginLogLastNYearsStack(HttpServletRequest request, HttpServletResponse response){

        String jwt=request.getParameter("jwt");

        String num=request.getParameter("num");

        UsersToken ut= utService.getUsersToken(jwt);

        return  chartService.getLoginLogLastNYearsStack(ut.getUserid(),Integer.parseInt(num));
    }


    @ResponseBody
    @RequestMapping("/getLoginLogLastNYears/line/stack")
    public String getLoginLogLastNYearsLineStack(HttpServletRequest request, HttpServletResponse response){

        String jwt=request.getParameter("jwt");

        String num=request.getParameter("num");

        UsersToken ut= utService.getUsersToken(jwt);

        return  chartService.getLoginLogLastNYearsLineStack(ut.getUserid(),Integer.parseInt(num));
    }

    @ResponseBody
    @RequestMapping("/getLoginLogLastNYears/line")
    public String getLoginLogLastNYearsLine(HttpServletRequest request, HttpServletResponse response){

        String jwt=request.getParameter("jwt");

        String num=request.getParameter("num");

        UsersToken ut= utService.getUsersToken(jwt);

        return  chartService.getLoginLogLastNYearsLine(ut.getUserid(),Integer.parseInt(num));
    }

    @ResponseBody
    @RequestMapping("/getLoginLogLastNYears/pie")
    public String getLoginLogLastNYearsPie(HttpServletRequest request, HttpServletResponse response){

        String jwt=request.getParameter("jwt");

        String num=request.getParameter("num");

        UsersToken ut= utService.getUsersToken(jwt);

        return  chartService.getLoginLogLastNYearsPie(ut.getUserid(),Integer.parseInt(num));
    }

    @ResponseBody
    @RequestMapping("/getLoginLogLastNYears/gauge")
    public String getLoginLogLastNYearsGauge(HttpServletRequest request, HttpServletResponse response){

        String jwt=request.getParameter("jwt");

        String num=request.getParameter("num");

        UsersToken ut= utService.getUsersToken(jwt);

        return  chartService.getLoginLogLastNYearsGauge(ut.getUserid(),Integer.parseInt(num));
    }

    @ResponseBody
    @RequestMapping("/getLoginAllUserLastNYears/Geo")
    public String getLoginAllUserLastNYearsGeo(HttpServletRequest request, HttpServletResponse response){
        return  chartService.getLoginAllUserLastNYearsGeo();
    }
}