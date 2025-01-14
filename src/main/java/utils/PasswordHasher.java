/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

/**
 *
 * @author night
 */
import org.mindrot.jbcrypt.BCrypt;

public class PasswordHasher {

    public static String hashPassword(String plainPassword) {
        // Generate a salt and hash the password using bcrypt
        String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt(12)); // 12 is the strength factor
        return hashedPassword;
    }

    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        // Check if the plain password matches the hashed password
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }

    public static void main(String[] args) {
        String plainPassword = "mySecurePassword123";
        
        // Hash the password
        String hashedPassword = hashPassword(plainPassword);

        // Now you can store the hashed password in your database
        
        // Verify the password during login (for example)
        boolean isCorrect = checkPassword("mySecurePassword123", hashedPassword);
    }
}