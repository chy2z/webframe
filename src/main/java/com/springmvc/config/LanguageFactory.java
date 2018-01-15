package com.springmvc.config;

import com.springmvc.enums.LanguageType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
* @Title: LanguageFactory
* @Description: 语言工厂
* @author chy
* @date 2018/1/13 10:46
*/
@Component
public class LanguageFactory {

    protected static Logger logger = LoggerFactory.getLogger(LanguageFactory.class);

    /**
     * 默认类型
     */
    private static LanguageType lType=LanguageType.ZHCN;

    /**
     * 单例
     */
    private static Language signle;

    /**
     * 并发锁
     */
    private static String lock = "language";

    /**
     * 创建语言
     * @return
     */
    public static Language getLanguages() {
        if (signle == null) {
            synchronized (lock) {
                if (signle == null) {
                    logger.info("语言初始化完成--->"+lType.getName());
                    switch (lType) {
                        case ZHCN:
                            signle = new Language_zh_cn();
                            break;
                        case ENUS:
                            signle = new Language_en_us();
                            break;
                        default:
                            signle = new Language_zh_cn();
                            break;
                    }
                }
            }
        }

        return signle;
    }

    /**
     * 改变语言
     * @return
     */
    protected static void setLanguages(LanguageType type) {
        if (signle != null) {
            synchronized (lock) {
                if (signle != null) {
                    signle = null;
                    lType=type;
                    logger.info("语言配置完成--->"+lType.getName());
                }
            }
        }
    }

}
