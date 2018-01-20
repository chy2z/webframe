package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.AuditWaitOpinionMapper;
import com.springmvc.model.AuditWaitOpinion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @Title: AuditWaitOptionService
* @Description: 审核意见接口
* @author chy
* @date 2018/1/19 17:17
*/
@Service
public class AuditWaitOptionService extends BaseService {

    @Autowired
    AuditWaitOpinionMapper mapper;

    /**
     * 获取审核意见集合
     * @param awid
     * @return
     */
    public List<AuditWaitOpinion> getList(Integer awid) {
        return mapper.selectByAwid(awid);
    }

}

