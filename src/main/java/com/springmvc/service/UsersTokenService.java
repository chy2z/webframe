package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.UsersTokenMapper;
import com.springmvc.model.UsersToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
* @Title: UsersTokenService
* @Description: token业务层
* @author chy
* @date 2017/10/19 15:46
*/
@Service
public class UsersTokenService extends BaseService {

    @Autowired
    private UsersTokenMapper utmap;

    /**
     * 根据用户获取tokne
     * @param userid
     * @return
     */
    public UsersToken  getUsersToken(int userid){
       return  utmap.selectByUserId(userid);
    }

    public UsersToken  getUsersToken(String md5Token){
        return  utmap.selectByMd5Token(md5Token);
    }

    public boolean insert(UsersToken ut){
       return  utmap.insertSelective(ut)>0;
    }

    public boolean update(UsersToken ut){
        return  utmap.updateByPrimaryKeySelective(ut)>0;
    }
}
