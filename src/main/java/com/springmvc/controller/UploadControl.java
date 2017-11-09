package com.springmvc.controller;

import com.springmvc.model.RequestResult;
import com.springmvc.util.JsonUtil;
import com.springmvc.util.UploadFileUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

    @RequestMapping(value = "/imageUpload")
    public void imageUpload(
            @RequestParam(value = "upload", required = false) MultipartFile file,
            HttpServletRequest request, ModelMap model,
            HttpServletResponse response) throws IOException {

        RequestResult result=new RequestResult();

        String fileUrl = UploadFileUtil.copyFile(file, request);

        HashMap<String, Object> data = new HashMap<>();

        data.put("url", fileUrl);

        data.put("fileName", file.getOriginalFilename());

        result.setSucceed("上传成功",data);

        response.getWriter().write(JsonUtil.writeValueAsString(result));

        //允许跨域
        response.setHeader("Access-Control-Allow-Origin", "*");
    }
}
