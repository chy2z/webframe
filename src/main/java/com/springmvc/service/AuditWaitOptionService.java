package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.config.LanguageFactory;
import com.springmvc.enums.AuditStateType;
import com.springmvc.mapper.AuditWaitOpinionMapper;
import com.springmvc.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import javax.swing.text.rtf.RTFEditorKit;
import java.util.Date;
import java.util.List;
import java.util.Random;

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

    @Autowired
    AuditWaitService auditWaitService;

    @Autowired
    AuditKindProcessService auditKindProcessService;

    @Autowired
    AuditKindProcessStepService auditKindProcessStepService;

    /**
     * 获取审核意见集合
     * @param awid
     * @return
     */
    public List<AuditWaitOpinion> getList(Integer awid) {
        return mapper.selectByAwid(awid);
    }

    /**
     * 设置审核意见
     * @param awid
     * @param uid
     * @param auditState
     * @param opinion
     * @return
     */
    @Transactional(isolation = Isolation.DEFAULT,rollbackFor = Exception.class)
    public RequestResult setAuditOpinion(String awid, String uid, String auditState, String opinion) {

        RequestResult r = new RequestResult();

        int result = 0;

        // 获取待审核信息
        AuditWait aw = auditWaitService.getAuditWait(Integer.parseInt(awid));

        // 获取审核类型
        AuditKindProcess akp = auditKindProcessService.getAuditKindProcess(aw.getPid());

        // 获取下一步审核步骤信息
        List<AuditKindProcessStep> akps = auditKindProcessStepService.getAuditKindProcessStep(aw.getPid(), aw.getSteps() + 1);

        // 不是最后一步
        if (aw.getSteps().intValue() != akp.getStepnum().intValue()) {
            // 后续是否存在可用的审核步骤
            if (akps.size() <= 0) {
                r.setFail(LanguageFactory.getLanguages().AUDIT_NEXT_STEP_DISABLE);
                return r;
            }
        }

        // 审核意见
        AuditWaitOpinion awOption = new AuditWaitOpinion();
        awOption.setAwid(aw.getId());
        awOption.setPid(aw.getPid());
        awOption.setPsid(0);
        awOption.setAuditstate(auditState);
        awOption.setOpinion(opinion);
        awOption.setStep(aw.getSteps());
        awOption.setUid(Integer.parseInt(uid));
        awOption.setReceivedate(aw.getReceivedate());
        awOption.setCreatedate(new Date());

        // 插入审核意见
        result += mapper.insertSelective(awOption);

        // 修改待审核记录
        if (awOption.getAuditstate().equals(AuditStateType.DH.getName())) {
            aw.setStatus(AuditStateType.DH.getName());
            aw.setEnddate(new Date());
            //设置送审记录的状态
            auditWaitService.updateOperation(aw.getTname(), aw.getTkey(), aw.getTvalue(), aw.getStatus());
        } else {
            // 是否是最后一步
            if (aw.getSteps().intValue() == akp.getStepnum().intValue()) {
                aw.setStatus(AuditStateType.TG.getName());
                aw.setEnddate(new Date());
                //设置送审记录的状态
                auditWaitService.updateOperation(aw.getTname(), aw.getTkey(), aw.getTvalue(), aw.getStatus());
            } else {
                if (akps.size() > 0) {
                    int s = 0;
                    //Random rand = new Random();
                    //s=rand.nextInt(akps.size());
                    aw.setStatus(AuditStateType.SHZ.getName());
                    aw.setSteps(akps.get(s).getStep());
                    aw.setReceivedate(new Date());
                }
            }
        }

        if (auditWaitService.update(aw)) {
            result++;
        }

        if (result > 0) {
            r.setSucceed(LanguageFactory.getLanguages().AUDIT_SUCESS, result);
        } else {
            r.setFail(LanguageFactory.getLanguages().AUDIT_FAIL);
        }

        return r;
    }
}