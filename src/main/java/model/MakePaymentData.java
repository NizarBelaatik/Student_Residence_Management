package model;

import java.sql.Time;
import java.sql.Timestamp;

public class MakePaymentData {
    private String email;
    private String cardholderName;
    private String cardNumber;
    private String expiryDate;
    private String cvc;
    private String paymentId;
    private Timestamp payed_at;

    public MakePaymentData(String email, String cardholderName, String cardNumber, String expiryDate, String cvc, String paymentId) {
        this.email = email;
        this.cardholderName = cardholderName;
        this.cardNumber = cardNumber;
        this.expiryDate = expiryDate;
        this.cvc = cvc;
        this.paymentId = paymentId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // Getters and setters
    public String getCardholderName() {
        return cardholderName;
    }

    public void setCardholderName(String cardholderName) {
        this.cardholderName = cardholderName;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(String expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getCvc() {
        return cvc;
    }

    public void setCvc(String cvc) {
        this.cvc = cvc;
    }

    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public Timestamp getPayedDate() {
        return payed_at;
    }

    public void setPayedDate(Timestamp payed_at) {
        this.payed_at = payed_at;
    }
}
