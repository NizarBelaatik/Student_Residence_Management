/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

/**
 *
 * @author night
 */
public class EmailSender {
    public static void sendEmail(String toEmail, String subject, String body) {
        // SMTP server configuration
        String host = "smtp.gmail.com";  // Change to your SMTP server
        final String fromEmail = "codenight03@gmail.com";  // Your email
        final String password = "qcqy lqrx olql cauv";  // Your email password
        // Set properties for the mail session
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");  // Use TLS
        properties.put("mail.smtp.ssl.trust", host);  // Trust the server
        
        // Create a session with the email properties
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });
        
        try {
            // Create a MimeMessage object
            Message message = new MimeMessage(session);
            
            // Set from, to, subject, and body of the email
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(body);
            
            // Send the email
            Transport.send(message);
            System.out.println("Email sent successfully!");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
    
    public static void sendEmailWithAttachment(String toEmail, String subject, String body, String attachmentPath) {
        // SMTP configuration (same as before)
        String host = "smtp.gmail.com";
        final String fromEmail = "your-email@gmail.com";
        final String password = "your-email-password";

        // Set up the mail session
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // Create a MimeMessage
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            // Create the email body
            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setText(body);

            // Attach file
            MimeBodyPart attachmentPart = new MimeBodyPart();
            attachmentPart.attachFile(attachmentPath);

            // Combine the text and the attachment
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(textPart);
            multipart.addBodyPart(attachmentPart);

            // Set the message content
            message.setContent(multipart);

            // Send the email
            Transport.send(message);
            System.out.println("Email sent successfully with attachment!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        // Example usage
        String toEmail = "recipient@example.com";
        String subject = "Test Email";
        String body = "Hello, this is a test email sent from Java!";
        
        sendEmail(toEmail, subject, body);
    }
}
