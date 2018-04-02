package com.springmvc.util;

import org.csource.common.NameValuePair;
import org.csource.fastdfs.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
* @Title: FastDFSUtil
* @Description: fastDfs工具类
* @author chy
* @date 2018/2/26 14:03
*/
public class FastDFSUtil {

    public static final Logger logger = LoggerFactory.getLogger(FastDFSUtil.class);

    static TrackerClient tClient;

    static StorageServer sServer;

    public static String uploadPic(String fileExt,MultipartFile pic) {
        String[] uploadResults = null;
        String groupName="";
        String remoteFileName="";
        try {

            if (tClient == null) {

                synchronized (FastDFSUtil.class) {

                    if (tClient == null) {

                        ClientGlobal.init("fdfs_client.conf");

                        logger.info("FastDFS配置信息: " + ClientGlobal.configInfo());

                        tClient = new TrackerClient();
                    }
                }
            }

            TrackerServer tServer= tClient.getConnection();

            StorageClient sClient= new StorageClient(tServer, sServer);

            NameValuePair[] pair = new NameValuePair[3];
            // 文件名称
            pair[0] = new NameValuePair("fileName", pic.getOriginalFilename());
            // 文件扩展名
            pair[1] = new NameValuePair("fileExt", fileExt);
            // 文件大小
            pair[2] = new NameValuePair("fileSize", String.valueOf(pic.getSize()));

            //上传文件
            uploadResults = sClient.upload_appender_file(pic.getBytes(), fileExt, pair);

            groupName = uploadResults[0];

            remoteFileName = uploadResults[1];

        } catch (IOException ex) {

        } catch (Exception ex) {

        }
        return groupName + "/" + remoteFileName;
    }

}
