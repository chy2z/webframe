package com.springmvc.util;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;

public class JwtToken {

	protected static Logger logger = LoggerFactory.getLogger(JwtToken.class);

	public final static String alg = "HS256";

	public final static String typ = "JWT";

	public final static String secret = "sgspringmvc";

	public final static String superAdmin = "adminmvc";

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
		String token = JWT.create().withHeader(map) // header
				.withClaim("name", info.get("name")) // payload
				.withClaim("role", info.get("role"))
				.withClaim("loginTime", info.get("loginTime")).sign(Algorithm.HMAC256(secret)); // 创建token
		return token;
	}

	/**
	 * 验证token
	 * @param token
	 * @return
	 * @throws Exception
	 */
	public static boolean verifyToken(String token) throws Exception {
		JWTVerifier verifier = JWT.require(Algorithm.HMAC256(secret)).build();
		DecodedJWT jwt = verifier.verify(token);
		Map<String, Claim> claims = jwt.getClaims();
		logger.info("{}:{}","name",claims.get("name").asString());
		logger.info("{}:{}","loginTime",claims.get("loginTime").asString());
		if (claims.get("name").asString().equals(superAdmin)) {
			return true;
		}
		return false;
	}
}
