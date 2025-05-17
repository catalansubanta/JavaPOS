package com.javapos.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtils {

    // Method to hash password using BCrypt
    public static String hash(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    // Method to check if the password matches the stored hashed password
    public static boolean checkPassword(String password, String hashedPassword) {
        return BCrypt.checkpw(password, hashedPassword);
    }
}
