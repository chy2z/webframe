package com.springmvc.base;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

/**
* @Title: BaseControl
* @Description: 控制层基类
* @author chy
* @date 2018/1/12 17:24
*/
@Controller
public class BaseControl {

    protected Logger logger = LoggerFactory.getLogger("watchlog");
}
