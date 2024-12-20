package model;

import java.sql.Timestamp;

public class EmailVerification {

    private int verificationId;
    private String email;
    private String verificationToken;
    private Timestamp createdAt;
    private Timestamp expiresAt;
    private Timestamp verifiedAt;

    // Constructor
    public EmailVerification(String email, String verificationToken, Timestamp expiresAt) {
        this.email = email;
        this.verificationToken = verificationToken;
        this.createdAt = new Timestamp(System.currentTimeMillis()); // Current timestamp
        this.expiresAt = expiresAt;
    }

    // Getters and setters
    public int getVerificationId() {
        return verificationId;
    }

    public void setVerificationId(int verificationId) {
        this.verificationId = verificationId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getVerificationToken() {
        return verificationToken;
    }

    public void setVerificationToken(String verificationToken) {
        this.verificationToken = verificationToken;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(Timestamp expiresAt) {
        this.expiresAt = expiresAt;
    }

    public Timestamp getVerifiedAt() {
        return verifiedAt;
    }

    public void setVerifiedAt(Timestamp verifiedAt) {
        this.verifiedAt = verifiedAt;
    }
}
