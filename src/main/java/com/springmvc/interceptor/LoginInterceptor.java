package com.springmvc.interceptor;

import com.springmvc.config.SysConfig;
import com.springmvc.model.UsersControlLog;
import com.springmvc.model.UsersToken;
import com.springmvc.service.UsersControlLogService;
import com.springmvc.service.UsersTokenService;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.SpringContextUtil;
import com.springmvc.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
* @Title: LoginInterceptor
* @Description: 用于登录用户身份合法性验证
* @author chy
* @date 2018/2/5 14:27
*/
public class LoginInterceptor implements HandlerInterceptor {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    private static UsersTokenService utService;

    private static UsersControlLogService usersControlLogService;

    /**
     * Handler执行完成之后调用这个方法
     * @param request
     * @param response
     * @param handler
     * @param exc
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object handler, Exception exc)
            throws Exception {

    }

    /**
     * Handler执行之后，ModelAndView返回之前调用这个方法
     * @param request
     * @param response
     * @param handler
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) throws Exception {

        if(modelAndView!=null) {
            modelAndView.addObject("version", SysConfig.version);
        }
    }

    /**
     * Handler执行之前调用这个方法
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws Exception {
        // 登录页面
        String loginUrl = "/login.jsp";

        // 获取请求的URL
        String url = request.getRequestURI();

        // 获取token
        String jwt= request.getParameter("jwt");

        if(!StringUtil.isNotBlank(jwt)){
            response.sendRedirect(request.getContextPath() + loginUrl);
            return false;
        }

        if (LoginInterceptor.utService == null) {
            synchronized (this) {
                if (LoginInterceptor.utService == null) {
                    utService = (UsersTokenService) SpringContextUtil.getBean("usersTokenService");
                    usersControlLogService= (UsersControlLogService) SpringContextUtil.getBean("usersControlLogService");
                }
            }
        }

        UsersToken ut= utService.getUsersToken(jwt);

        if(ut==null){
            response.sendRedirect(request.getContextPath() + loginUrl);
            return false;
        }

        UsersControlLog ucl=new UsersControlLog();
        ucl.setUid(ut.getUserid());
        ucl.setToken(jwt);
        ucl.setType(request.getMethod());
        ucl.setUrl(url);
        ucl.setName(url.split("/")[1]);
        ucl.setParameter(JsonUtil.writeValueAsString(request.getParameterMap()));
        ucl.setCreatedate(new Date());

        usersControlLogService.insert(ucl);

        return true;
    }

}