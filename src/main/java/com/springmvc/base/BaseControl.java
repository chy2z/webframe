package com.springmvc.base;

import com.auth0.jwt.interfaces.Claim;
import com.springmvc.config.SysConfig;
import com.springmvc.enums.EncryptionType;
import com.springmvc.enums.RecordPermissionsType;
import com.springmvc.model.UsersToken;
import com.springmvc.service.UsersTokenService;
import com.springmvc.util.JwtTokenUtil;
import com.springmvc.util.SecurityUtil;
import com.springmvc.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
* @Title: BaseControl
* @Description: 控制层基类
* @author chy
* @date 2018/1/12 17:24
*/
@Controller
public class BaseControl {

    protected Logger logger = LoggerFactory.getLogger("watchlog");

    /**
     * 计算记录权限
     * @param rightRecord
     * @param jwt
     * @return
     * @throws Exception
     */
    protected String computeCondition(String rightRecord, String jwt, UsersTokenService utService) {

        int r = Integer.parseInt(rightRecord);

        String elseWhere = " u.id=0 ";

        try {

            UsersToken ut = utService.getUsersToken(jwt);

            Map<String, Claim> claims=JwtTokenUtil.decodedToken(ut.getToken());

            //超级管理员判断
            if(SysConfig.isSuperAdmin(claims.get("roleid").asString())){
                return null;
            }

            switch (RecordPermissionsType.valueOf(r)) {
                case C:
                    elseWhere = "c.id='" + claims.get("corporationid").asString() + "'";
                    break;
                case D:
                    elseWhere = "d.id='" + claims.get("departid").asString() + "'";
                    break;
                case U:
                    elseWhere = "u.id='" + claims.get("uid").asString() + "'";
                    break;
                default:
                    break;
            }
        }
        catch (Exception ex)
        {
            logger.error("rightRecordCondition",ex);
        }

        return elseWhere;
    }

    /**
     * 获获取记录权限
     * @param request
     * @param utService
     * @return
     */
    protected String rightRecordCondition(HttpServletRequest request, UsersTokenService utService) {

        String rightRecord = StringUtil.nullOrString(request.getParameter("rightRecord"));

        String where = request.getParameter("where");

        String jwt = StringUtil.nullOrString(request.getParameter("jwt"));

        String elseWhere = "";

        if (rightRecord != null) {
            rightRecord = SecurityUtil.decrypt(rightRecord, EncryptionType.BASE64);
        }

        if (rightRecord != null) {
            elseWhere = computeCondition(rightRecord, jwt, utService);
        }

        if (StringUtil.isNotBlank(elseWhere)) {
            if (StringUtil.isNotBlank(where)) {
                where += " and " + elseWhere;
            } else {
                where = elseWhere;
            }
        }

        return where;
    }
}
