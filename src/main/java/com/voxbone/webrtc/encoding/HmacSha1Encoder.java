package com.voxbone.webrtc.encoding;

import org.apache.commons.codec.binary.Base64;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.security.SignatureException;

/**
 * This class defines common routines for generating
 * authentication signatures for WebRTC requests.
 */
public class HmacSha1Encoder {
	private static final String HMAC_SHA1_ALGORITHM = "HmacSHA1";


	/**
	 * Computes RFC 2104-compliant HMAC signature.
	 * * @param data
	 * The data to be signed.
	 *
	 * @param key The signing key.
	 * @return The Base64-encoded RFC 2104-compliant HMAC signature.
	 * @throws java.security.SignatureException when signature generation fails
	 */
	public static String encode(String data, String key)
			throws SignatureException {
		String result;
		try {

			// get an hmac_sha1 key from the raw key bytes
			SecretKeySpec signingKey = new SecretKeySpec(key.getBytes(), HMAC_SHA1_ALGORITHM);
			// get an hmac_sha1 Mac instance and initialize with the signing key
			Mac mac = Mac.getInstance(HMAC_SHA1_ALGORITHM);
			mac.init(signingKey);
			// compute the hmac on input data bytes
			byte[] rawHmac = mac.doFinal(data.getBytes());
			// base64-encode the hmac
			result = Base64.encodeBase64String(rawHmac);

		} catch (Exception e) {
			throw new SignatureException("Failed to generate HMAC : " + e.getMessage());
		}
		return result;
	}
}