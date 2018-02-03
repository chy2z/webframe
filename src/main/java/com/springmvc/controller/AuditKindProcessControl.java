package com.springmvc.controller;

import com.springmvc.base.BaseControl;
import com.springmvc.config.LanguageFactory;
import com.springmvc.enums.AuditEnableType;
import com.springmvc.model.*;
import com.springmvc.model.flowchart.FlowChart;
import com.springmvc.model.flowchart.FlowChartNode;
import com.springmvc.service.*;
import com.springmvc.util.DateUtil;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;


/**
* @Title: AuditProcessControl
* @Description: 审核流程接口
* @author chy
* @date 2017/12/29 11:42
*/
@Controller
@RequestMapping("/auditKindProcess")
public class AuditKindProcessControl extends BaseControl {

    @Autowired
    AuditKindService auditKindService;

    @Autowired
    AuditKindProcessService auditKindProcessService;

    @Autowired
    AuditKindProcessStepService auditKindProcessStepService;

    @Autowired
    AuditWaitService auditWaitService;

    @Autowired
    AuditWaitOptionService auditWaitOptionService;

    @Autowired
    UsersService uService;

    @Autowired
    UsersTokenService utService;

    /**
     * 路径跳转
     * @return
     */
    @RequestMapping("/path/{page}")
    public String toPage(@PathVariable("page") String page, HttpServletRequest request, Model model) {
        String jwt = request.getParameter("jwt");
        UsersToken ut= utService.getUsersToken(jwt);
        model.addAttribute("jwt", jwt);
        if (page.equals("add")) {
            Users u= uService.getUsers(ut.getUserid());
            model.addAttribute("user", u);
            return "auditing/audit_kind_process_add_page";
        }
        else if(page.equals("update")){
            String id = (String) request.getParameter("id");
            Users u= uService.getUsers(ut.getUserid());
            AuditKindProcess sModel= auditKindProcessService.getAuditKindProcess(Integer.parseInt(id));
            List<AuditKindProcessStep> steps= auditKindProcessStepService.getList(Integer.parseInt(id));
            model.addAttribute("user", u);
            model.addAttribute("kindProcess",sModel);
            model.addAttribute("kindProcessStep",JsonUtil.writeValueAsString(steps));
            return "auditing/audit_kind_process_update_page";
        }
        // 流程图
        else if(page.equals("flowStepView")){
            String id = (String) request.getParameter("id");
            AuditKindProcess sModel= auditKindProcessService.getAuditKindProcess(Integer.parseInt(id));
            model.addAttribute("kindProcess",sModel);
            return "flowchart/flow_chat_step_view_page";
        }
        // 审核进度
        else if(page.equals("flowProcessView")){
            String tName = request.getParameter("tName");
            String tKey = request.getParameter("tKey");
            String tValue = request.getParameter("tValue");
            Integer pid = auditWaitService.getAuditProcess(tName, tKey, tValue);
            AuditKindProcess sModel= auditKindProcessService.getAuditKindProcess(pid);
            model.addAttribute("tName",tName);
            model.addAttribute("tKey",tKey);
            model.addAttribute("tValue",tValue);
            model.addAttribute("kindProcess",sModel);
            return "flowchart/flow_chat_process_view_page";
        }
        // 审核意见
        else if(page.equals("auditOption")){
            String tName = request.getParameter("tName");
            String tKey = request.getParameter("tKey");
            String tValue = request.getParameter("tValue");
            Integer pid = auditWaitService.getAuditProcess(tName, tKey, tValue);
            AuditKindProcess sModel= auditKindProcessService.getAuditKindProcess(pid);
            model.addAttribute("tName",tName);
            model.addAttribute("tKey",tKey);
            model.addAttribute("tValue",tValue);
            model.addAttribute("kindProcess",sModel);
            Users u = uService.getUsers(ut.getUserid());
            model.addAttribute("user", u);
            return "auditing/audit_wait_opinion_page";
        }
        // 送审
        else if(page.equals("sendAudit")) {
            Users u = uService.getUsers(ut.getUserid());
            AuditKind auditKind = auditKindService.getModelByOperation(request.getParameter("operation"));
            model.addAttribute("user", u);
            model.addAttribute("auditKind", auditKind);
            return "auditing/audit_kind_process_select_page";
        }
        else if(page.equals("cancelAudit")){
            String tName = request.getParameter("tName");
            String tKey = request.getParameter("tKey");
            String tValue = request.getParameter("tValue");
            Integer pid = auditWaitService.getAuditProcess(tName, tKey, tValue);
            AuditKindProcess sModel= auditKindProcessService.getAuditKindProcess(pid);
            model.addAttribute("tName",tName);
            model.addAttribute("tKey",tKey);
            model.addAttribute("tValue",tValue);
            model.addAttribute("kindProcess",sModel);
            Users u = uService.getUsers(ut.getUserid());
            model.addAttribute("user", u);
            return "auditing/audit_wait_cancel_page";
        }
        else {
            return "error";
        }
    }


    /**
     * 分页
     * @return
     */
    @ResponseBody
    @RequestMapping("/pagination")
    public String pagination(HttpServletRequest request, HttpServletResponse response) {

        int pageNo=Integer.parseInt(request.getParameter("pageNo"));

        int pageSize=Integer.parseInt(request.getParameter("pageSize"));

        String where=request.getParameter("where");

        String orderBy=request.getParameter("orderBy");

        return auditKindProcessService.toPaginationJson(pageNo,pageSize,where,orderBy);
    }

    /**
     * 插入流程和步骤
     * @param process
     * @param steps
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/insert",method = {RequestMethod.POST})
    public RequestResult insert(String process , String steps){
        RequestResult result=new RequestResult();
        if(null==process||null==steps) {
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else{
            AuditKindProcess c= JsonUtil.jsonToBean(process,AuditKindProcess.class);

            List<AuditKindProcessStep> stepList=(List<AuditKindProcessStep>)JsonUtil.jsonToListBean(steps,AuditKindProcessStep.class);

            if(auditKindProcessService.insertStep(c,stepList)){
                result.setSucceed(LanguageFactory.getLanguages().INSERT_SUCESS,null);
            }
            else{
                result.setFail(LanguageFactory.getLanguages().INSERT_FAIL);
            }
        }

        return  result;
    }

    /**
     * 修改流程和步骤
     * @param process
     * @param steps
     * @param editStep 是否更新步骤
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/update",method = {RequestMethod.POST})
    public RequestResult update(String process , String steps,int editStep){
        RequestResult result=new RequestResult();
        if(null==process||null==steps) {
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else{
            AuditKindProcess c= JsonUtil.jsonToBean(process,AuditKindProcess.class);
            if(auditWaitService.getCountByPid(c.getId())==0) {
                if (c.getId().intValue() != 0) {
                    List<AuditKindProcessStep> stepList = (List<AuditKindProcessStep>) JsonUtil.jsonToListBean(steps, AuditKindProcessStep.class);
                    if (auditKindProcessService.updateStep(c, stepList, editStep)) {
                        result.setSucceed(LanguageFactory.getLanguages().UPDATE_SUCESS, null);
                    } else {
                        result.setFail(LanguageFactory.getLanguages().UPDATE_FAIL);
                    }
                } else {
                    result.setFail(LanguageFactory.getLanguages().DATA_EXCEPTION);
                }
            }
            else{
                result.setFail(LanguageFactory.getLanguages().AUDIT_KIND_USING);
            }
        }

        return  result;
    }

    /**
     * 更新状态
     * @param pid
     * @param enable
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/updateEnable",method = {RequestMethod.POST})
    public RequestResult updateEnable(String pid,String enable) {
        RequestResult result = new RequestResult();
        if (null == pid || null == enable) {
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        } else {
            AuditKindProcess p=new AuditKindProcess();
            p.setId(Integer.parseInt(pid));
            p.setEnable(enable);
            if(auditKindProcessService.update(p)){
                result.setSucceed(LanguageFactory.getLanguages().UPDATE_SUCESS, null);
            }
            else{
                result.setSucceed(LanguageFactory.getLanguages().UPDATE_FAIL, null);
            }
        }
        return result;
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delete",method = {RequestMethod.POST})
    public RequestResult delete(String id) {
        RequestResult result = new RequestResult();
        if (id == null) {
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        } else {
            if (auditWaitService.getCountByPid(Integer.parseInt(id)) == 0) {
                if (auditKindProcessService.delete(Integer.parseInt(id))) {
                    result.setSucceed(LanguageFactory.getLanguages().DELETE_SUCESS, null);
                } else {
                    result.setFail(LanguageFactory.getLanguages().DELETE_FAIL);
                }
            } else {
                result.setFail(LanguageFactory.getLanguages().AUDIT_KIND_USING);
            }
        }
        return result;
    }

    /**
     * 查看流程图
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/flowChartStepView",method = {RequestMethod.POST})
    public RequestResult flowChartStepView(String id){
        RequestResult result=new RequestResult();
        if(id==null){
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        }
        else {
            List<AuditKindProcessStep> steps = auditKindProcessStepService.getList(Integer.parseInt(id));

            List<FlowChartNode> nodes = new ArrayList<>();

            FlowChartNode node;

            // 级别数
            Integer level=-1;

            Integer index=0;

            String prcs_parent="";

            // 存储前一个节点
            FlowChartNode lastNode=null;

            // 下一级别的父节点
            List<String> parent = new ArrayList<String>();

            for (AuditKindProcessStep s : steps) {
                if (level < s.getStep()) {
                    level = s.getStep();
                }
            }

            for (AuditKindProcessStep s : steps) {
                node = new FlowChartNode();
                // 第一个节点
                if (index++ == 0) {
                    parent.add(index.toString());
                    node.setPrcs_parent("0");
                } else {
                    //同一个级别
                    if (lastNode.getPrcs_id() == s.getStep().intValue()) {
                        // 合并父节点集合
                        parent.add(index.toString());
                        // 和上一个节点父节点一样
                        node.setPrcs_parent(lastNode.getPrcs_parent());
                    } else {
                        // 新的级别
                        prcs_parent="";
                        for (int i = 0, len = parent.size() - 1; i <= len; i++) {
                            if (i < len) {
                                // 字符串加
                                prcs_parent+=parent.get(i).toString() + ",";
                            } else {
                                // 字符串加
                                prcs_parent+=parent.get(i).toString();
                            }
                        }

                        node.setPrcs_parent(prcs_parent);

                        parent.clear();

                        parent.add(index.toString());
                    }
                }
                node.setPrcs_id(s.getStep());
                node.setFlow_prcs(index.toString());
                node.setPrcs_title(s.getDepartname());
                node.setPrcs_content(String.format("第 %s 步 %s (%s)",s.getStep(),s.getUname(),s.getRolename()));
                node.setPrcs_type("");

                // 禁用
                if(!s.getEnable().equals(AuditEnableType.YES.getName())){
                    node.setPrcs_class("window_disable");
                }
                else {
                    // 开始
                    if (s.getStep().intValue() == 1) {
                        node.setPrcs_class("window_start");
                    }
                    // 结束
                    else if (s.getStep().intValue() == level) {
                        node.setPrcs_class("window_end");
                    }
                    // 中间过程
                    else {
                        node.setPrcs_class("window_child");
                    }
                }

                nodes.add(node);

                lastNode = node;
            }

            FlowChart<FlowChartNode> flowChart = new FlowChart<>();

            flowChart.setTotal(nodes.size());

            flowChart.setLevel(level.toString());

            flowChart.setList(nodes);

            result.setSucceed(LanguageFactory.getLanguages().SUCCESS, flowChart);
        }

        return result;
    }

    /**
     * 查看审核进度
     * @param tName
     * @param tKey
     * @param tValue
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/flowChartProcessView",method = {RequestMethod.POST})
    public RequestResult flowChartProcessView(String tName,
                                              String tKey,
                                              String tValue) {
        RequestResult result = new RequestResult();
        if (tName == null || tKey == null || tValue == null) {
            result.setFail(LanguageFactory.getLanguages().DATA_LOSS);
        } else {
            Integer pid = auditWaitService.getAuditProcess(tName, tKey, tValue);

            if (pid == null || pid.intValue() == 0) {
                result.setFail(LanguageFactory.getLanguages().FAIL);
            } else {

                //获取待审核信息
                AuditWait aw= auditWaitService.getNewestAuditWait(tName,tKey,tValue);

                //获取审核意见
                List<AuditWaitOpinion> options=auditWaitOptionService.getList(aw.getId());

                //获取所有审核步骤
                List<AuditKindProcessStep> steps = auditKindProcessStepService.getList(pid.intValue());

                StringBuilder tip=new StringBuilder();

                List<FlowChartNode> nodes = new ArrayList<>();

                FlowChartNode node;

                // 级别数
                Integer level = -1;

                Integer index = 0;

                String prcs_parent="";

                // 存储前一个节点
                FlowChartNode lastNode = null;

                // 下一级别的父节点
                List<String> parent = new ArrayList<String>();

                for (AuditKindProcessStep s : steps) {
                    if (level < s.getStep()) {
                        level = s.getStep();
                    }
                }

                for (AuditKindProcessStep s : steps) {
                    node = new FlowChartNode();
                    // 第一个节点
                    if (index++ == 0) {
                        parent.add(index.toString());
                        node.setPrcs_parent("0");
                    } else {
                        //同一个级别
                        if (lastNode.getPrcs_id() == s.getStep().intValue()) {
                            // 合并父节点集合
                            parent.add(index.toString());
                            // 和上一个节点父节点一样
                            node.setPrcs_parent(lastNode.getPrcs_parent());
                        } else {
                            // 新的级别
                            prcs_parent="";
                            for (int i = 0, len = parent.size() - 1; i <= len; i++) {
                                if (i < len) {
                                    // 字符串加
                                    prcs_parent+=parent.get(i).toString() + ",";
                                } else {
                                    // 字符串加
                                    prcs_parent+=parent.get(i).toString();
                                }
                            }

                            node.setPrcs_parent(prcs_parent);

                            parent.clear();

                            parent.add(index.toString());
                        }
                    }
                    node.setPrcs_id(s.getStep());
                    node.setFlow_prcs(index.toString());

                    // 提示信息(多个分支)
                    node.setPrcs_title("无审核信息");
                    for(AuditWaitOpinion option : options){
                        if(s.getStep().intValue()==option.getStep().intValue()&&s.getUid().intValue()==option.getUid().intValue()) {
                            tip.delete(0, tip.length());
                            tip.append("<b>审核信息:</b><br><br>");
                            tip.append("<span style=\"text-decoration:underline;font-weight:bold;color:red\">"+s.getUname()+" 主办</span>");
                            tip.append("[<font color=green>");
                            tip.append(option.getAuditstate());
                            tip.append(",用时："+DateUtil.dateDiff(option.getReceivedate(),option.getCreatedate()));
                            tip.append("</font>]<br>");
                            tip.append("开始于："+ DateUtil.formatDate(option.getReceivedate())+"<br>");
                            tip.append("结束于："+DateUtil.formatDate(option.getCreatedate())+"<br><br>");
                            tip.append("<b>审核意见:</b><br><br>");
                            tip.append(StringUtil.emptyOrString(option.getOpinion()));
                            node.setPrcs_title(tip.toString());
                        }
                    }

                    // 显示信息
                    node.setPrcs_content(String.format("第 %s 步 %s-%s (%s)", s.getStep(),s.getDepartname(),s.getUname(),s.getRolename()));
                    node.setPrcs_type("");

                    // 禁用
                    if(!s.getEnable().equals(AuditEnableType.YES.getName())){
                         node.setPrcs_class("window_disable");
                    }else {
                        // 不是当前步骤
                        if (s.getStep().intValue() != aw.getSteps().intValue()) {

                            // 开始
                            if (s.getStep().intValue() == 1) {
                                node.setPrcs_class("window_start");
                            }

                            // 结束
                            else if (s.getStep().intValue() == level) {
                                node.setPrcs_class("window_end");
                            }

                            // 中间过程
                            else {
                                node.setPrcs_class("window_child");
                            }
                        } else {
                            // 当前
                            node.setPrcs_class("window_current");
                        }
                    }

                    nodes.add(node);

                    lastNode = node;
                }

                FlowChart<FlowChartNode> flowChart = new FlowChart<>();

                flowChart.setTotal(nodes.size());

                flowChart.setLevel(level.toString());

                flowChart.setList(nodes);

                result.setSucceed(LanguageFactory.getLanguages().SUCCESS, flowChart);
            }
        }
        return result;
    }
}