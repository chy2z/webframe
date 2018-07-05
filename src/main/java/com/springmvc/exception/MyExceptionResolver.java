package com.springmvc.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** 
* @Title: 自定义全局异常捕获
* @Description:
* @author chy
* @date 2018/7/5 8:48 
*/
public class MyExceptionResolver implements HandlerExceptionResolver {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    @Override
    public ModelAndView resolveException(HttpServletRequest request,
                                         HttpServletResponse response,
                                         Object handler,Exception ex) {

        ModelAndView mav = new ModelAndView();

        mav.addObject("ex", ex);

        mav.setViewName("myerror");

       /* if (ex instanceof MyException) {
            mav.setViewName("/showException.jsp");
        }

        if (ex instanceof MyException) {
            mav.setViewName("/showException.jsp");
        }*/

        return mav;
    }

}

