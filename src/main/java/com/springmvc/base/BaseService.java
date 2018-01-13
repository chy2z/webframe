package com.springmvc.base;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
* @Title: BaseService
* @Description: 业务层基类
* @author chy
* @date 2018/1/13 13:56
*/
@Service
public class BaseService {
	protected  Logger logger = LoggerFactory.getLogger(getClass());
}
