package com.springmvc.controller;

import com.springmvc.model.*;
import com.springmvc.model.flowchart.FlowChart;
import com.springmvc.model.flowchart.FlowChartNode;
import com.springmvc.service.AuditKindProcessService;
import com.springmvc.service.AuditKindProcessStepService;
import com.springmvc.service.UsersService;
import com.springmvc.service.UsersTokenService;
import com.springmvc.util.JsonUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
public class AuditKindProcessControl {

    @Autowired
    AuditKindProcessService auditKindProcessService;

    @Autowired
    AuditKindProcessStepService auditKindProcessStepService;

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
        String jwt = (String) request.getParameter("jwt");
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
            model.addAttribute("user", u);
            model.addAttribute("kindProcess",sModel);
            return "auditing/audit_kind_process_update_page";
        }
        else if(page.equals("flowstepview")){
            String id = (String) request.getParameter("id");
            AuditKindProcess sModel= auditKindProcessService.getAuditKindProcess(Integer.parseInt(id));
            model.addAttribute("kindProcess",sModel);
            return "flowchart/flow_chat_step_view_page";
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
            result.setFail("没有数据");
        }
        else{
            AuditKindProcess c= JsonUtil.jsonToBean(process,AuditKindProcess.class);

            List<AuditKindProcessStep> stepList=(List<AuditKindProcessStep>)JsonUtil.jsonToListBean(steps,AuditKindProcessStep.class);

            if(auditKindProcessService.insertStep(c,stepList)){
                result.setSucceed("保存成功",null);
            }
            else{
                result.setFail("没有数据");
            }
        }

        return  result;
    }

    /**
     * 修改
     * @param c
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/update",method = {RequestMethod.POST})
    public RequestResult update(@RequestBody AuditKindProcess c){
        RequestResult result=new RequestResult();
        if(null==c){
            result.setFail("没有数据");
        }
        else{
            if(auditKindProcessService.update(c)){
                result.setSucceed("修改成功",null);
            }
            else{
                result.setFail("没有数据");
            }
        }

        return  result;
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delete",method = {RequestMethod.POST})
    public RequestResult delete(String id){
        RequestResult result=new RequestResult();
        if(id==null){
            result.setFail("没有数据");
        }
        else{
            if(auditKindProcessService.delete(Integer.parseInt(id))){
                result.setSucceed("删除成功",null);
            }
            else{
                result.setFail("没有数据");
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
    @RequestMapping(value = "/flowChartView",method = {RequestMethod.POST})
    public RequestResult flowChartView(String id){
        RequestResult result=new RequestResult();
        if(id==null){
            result.setFail("没有数据");
        }
        else {
            List<AuditKindProcessStep> steps = auditKindProcessStepService.getList(Integer.parseInt(id));

            List<FlowChartNode> nodes = new ArrayList<>();

            FlowChartNode node;

            // 级别数
            Integer level=-1;

            Integer index=0;

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
                        parent.add(lastNode.getFlow_prcs());
                        // 和上一个节点父节点一样
                        node.setPrcs_parent(lastNode.getPrcs_parent());
                    } else {
                        // 新的级别
                       for(int i=0,len=parent.size()-1;i<=len;i++) {
                           if (i < len) {
                               // 字符串加
                               node.setPrcs_parent(parent.get(i).toString() + ",");
                           } else {
                               // 字符串加
                               node.setPrcs_parent(parent.get(i).toString());
                           }
                       }

                        parent.clear();

                        parent.add(index.toString());
                    }
                }
                node.setPrcs_id(s.getStep());
                node.setFlow_prcs(index.toString());
                node.setPrcs_title(s.getUname());
                node.setPrcs_content("第"+s.getStep().toString()+"步 "+s.getUname());
                node.setPrcs_type("");

                // 开始
                if(s.getStep().intValue()==1) {
                    node.setPrcs_class("window_start");
                }
                // 结束
                else if(s.getStep().intValue()==level){
                    node.setPrcs_class("window_end");
                }
                // 中间过程
                else{
                    node.setPrcs_class("window_child");
                }

                nodes.add(node);
                lastNode = node;
            }

            FlowChart<FlowChartNode> flowChart = new FlowChart<>();

            flowChart.setTotal(nodes.size());

            flowChart.setLevel(level.toString());

            flowChart.setList(nodes);

            result.setSucceed("保存成功", flowChart);
        }

        return result;
    }

}