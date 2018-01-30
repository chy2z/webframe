package com.springmvc.util;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;

/**
* @Title: JwtTokenUtil
* @Description: jwt操作类
* @author chy
* @date 2017/11/17 9:33
*/
public class JwtTokenUtil {

	protected static Logger logger = LoggerFactory.getLogger(JwtTokenUtil.class);

	public final static String alg = "HS256";

	public final static String typ = "JWT";

	public final static String secret = "#web-frame#";


	/**
	 * 创建token
	 * @param info
	 * @return
	 * @throws Exception
	 */
	public static String createToken(Map<String, String> info) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("alg", alg);
		map.put("typ", typ);
		// 创建token
		String token = JWT.create().withHeader(map)
				.withClaim("uid", info.get("uid"))
				.withClaim("loginName", info.get("loginName"))
				.withClaim("name", info.get("name"))
				.withClaim("departid", info.get("departid"))
				.withClaim("corporationid", info.get("corporationid"))
				.withClaim("roleid", info.get("roleid"))
				.withClaim("loginTime", info.get("loginTime"))
				.sign(Algorithm.HMAC256(secret));
		return token;
	}

	/**
	 * 解析token
	 * @param token
	 * @return
	 */
	public static Map<String, Claim> decodedToken(String token) throws Exception{
		JWTVerifier verifier = JWT.require(Algorithm.HMAC256(secret)).build();
		DecodedJWT jwt = verifier.verify(token);
		Map<String, Claim> claims = jwt.getClaims();
		logger.info("{}","===============解析token================");
		logger.info("{}:{}","uid",claims.get("uid").asString());
		logger.info("{}:{}","loginName",claims.get("loginName").asString());
		logger.info("{}:{}","name",claims.get("name").asString());
		logger.info("{}:{}","departid",claims.get("departid").asString());
		logger.info("{}:{}","corporationid",claims.get("corporationid").asString());
		logger.info("{}:{}","roleid",claims.get("roleid").asString());
		logger.info("{}:{}","loginTime",claims.get("loginTime").asString());
		return claims;
	}
}