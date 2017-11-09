package com.springmvc.util;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Date;
import java.util.UUID;

/**
* @Title: UploadFileUtil
* @Description: 上传文件
* @author chy
* @date 2017/11/9 23:01
*/
public class UploadFileUtil {

    private static String uploadFile = "/upload/image/";

    /**
     * 复制文件
     *
     * @param file
     * @param request
     * @return
     */
    public static String copyFile(MultipartFile file, HttpServletRequest request) {
        ServletContext sc = request.getSession().getServletContext();
        String filePath = uploadFile + DateUtil.formatDate(new Date(),"yyyy-MM-dd") + "/";
        String dir = sc.getRealPath(filePath);
        String fileName = file.getOriginalFilename();
        String extendName = ".png";
        if (StringUtil.isNotBlank(fileName)) {
            extendName = fileName.substring(fileName.lastIndexOf("."));
        }
        String newFileName = UUID.randomUUID() + extendName;
        File targetDir = new File(dir);
        File targetFile = new File(dir, newFileName);
        if (!targetDir.exists()) {
            targetDir.mkdirs();
        }
        try {
            file.transferTo(targetFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String fileUrl = filePath + newFileName;
        return fileUrl;
    }
}
