/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.util.Random;
import java.util.UUID;

import java.security.SecureRandom;
import java.math.BigInteger;

/**
 *
 * @author night
 */
public class GenerateRandomString {
        public static String generateUniqueId() {
            int length = 10;
            String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            Random random = new Random();
            StringBuilder randomString = new StringBuilder();

            // Loop to generate a random string
            for (int i = 0; i < length; i++) {
                int randomIndex = random.nextInt(characters.length());
                randomString.append(characters.charAt(randomIndex));
            }

            return randomString.toString();
        }
        
        
        public static String generateTokenUUID() {
            return UUID.randomUUID().toString();
        }
        public static String generateToken(int length) {
            SecureRandom random = new SecureRandom();
            return new BigInteger(length * 5, random).toString(32); // Generates a base32 string
        }
        
        public static String generatePassword() {
            SecureRandom random = new SecureRandom();
            return new BigInteger(12 * 5, random).toString(32); // Generates a base32 string
        }
}
