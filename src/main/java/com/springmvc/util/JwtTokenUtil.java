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
				.withClaim("id", info.get("id"))
				.withClaim("loginName", info.get("loginName"))
				.withClaim("name", info.get("name"))
				.withClaim("depart", info.get("depart"))
				.withClaim("corporationId", info.get("corporationId"))
				.withClaim("role", info.get("role"))
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
		logger.info("{}:{}","id",claims.get("id").asString());
		logger.info("{}:{}","loginName",claims.get("loginName").asString());
		logger.info("{}:{}","name",claims.get("name").asString());
		logger.info("{}:{}","depart",claims.get("depart").asString());
		logger.info("{}:{}","corporationId",claims.get("corporationId").asString());
		logger.info("{}:{}","role",claims.get("role").asString());
		logger.info("{}:{}","loginTime",claims.get("loginTime").asString());
		return claims;
	}
}