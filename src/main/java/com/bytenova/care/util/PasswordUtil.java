package com.bytenova.care.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Utility for hashing and verifying passwords using SHA-256.
 * Part of ByteNova Care – Team ByteNova
 */
public class PasswordUtil {

    /**
     * Hashes a raw password string using SHA-256.
     *
     * @param rawPassword the plain-text password
     * @return hex encoded SHA-256 hash
     */
    public static String hashPassword(String rawPassword) {
        if (rawPassword == null || rawPassword.trim().isEmpty()) {
            return null;
        }
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedHash = digest.digest(rawPassword.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : encodedHash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not available", e);
        }
    }

    /**
     * Checks if a plain password matches a stored hash.
     *
     * @param rawPassword plain-text password
     * @param storedHash stored SHA-256 hash
     * @return true if matches
     */
    public static boolean verifyPassword(String rawPassword, String storedHash) {
        if (rawPassword == null || storedHash == null) {
            return false;
        }
        String hashed = hashPassword(rawPassword);
        return hashed.equalsIgnoreCase(storedHash);
    }
}
