package com.springmvc.controller;

import com.springmvc.model.RequestResult;
import com.springmvc.model.Users;
import com.springmvc.service.UsersService;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.StringUtil;
import com.springmvc.util.UploadFileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;

/**
* @Title: UploadControl
* @Description: 上传接口
* @author chy
* @date 2017/11/9 22:17
*/
@Controller
@RequestMapping("/upload")
public class UploadControl {

    @Autowired
    UsersService usersService;

    /**
     * 通用上传
     * 跨域
     * @param file
     * @param request
     * @param model
     * @param response
     * @throws IOException
     */
    @RequestMapping(value = "/imageUpload")
    public void imageUpload(
            @RequestParam(value = "upload", required = false) MultipartFile file,
            HttpServletRequest request, ModelMap model,
            HttpServletResponse response) throws IOException {

        RequestResult result=new RequestResult();

        String fileUrl = UploadFileUtil.copyFile(file, request);

        if(StringUtil.isNotBlank(fileUrl)) {

            HashMap<String, Object> data = new HashMap<>();

            data.put("url", fileUrl);

            data.put("fileName", file.getOriginalFilename());

            result.setSucceed("上传成功", data);

        }
        else{
            result.setFail("上传失败");
        }

        response.getWriter().write(JsonUtil.writeValueAsString(result));

        //允许跨域
        response.setHeader("Access-Control-Allow-Origin", "*");
    }

    /**
     * 上传用户头像
     * @param file
     * @param useid
     * @param request
     * @param model
     * @param response
     * @return
     * @throws IOException
     */
    @ResponseBody
    @RequestMapping(value = "/headImageUpload")
    public RequestResult headImageUpload(
            @RequestParam(value = "upload", required = false) MultipartFile file,
            @RequestParam(value = "useid", required = false) String useid,
            HttpServletRequest request, ModelMap model,
            HttpServletResponse response) throws IOException {
        RequestResult result=new RequestResult();

        String fileUrl = UploadFileUtil.copyFile(file, request);

        Users u=usersService.getUsers(Integer.parseInt(useid));

        u.setImg(fileUrl);

        if(StringUtil.isNotBlank(fileUrl)&&usersService.update(u)) {

            HashMap<String, Object> data = new HashMap<>();

            data.put("url", fileUrl);

            data.put("fileName", file.getOriginalFilename());

            result.setSucceed("上传成功", data);
        }
        else{
            result.setFail("上传失败");
        }

        return  result;
    }
}
