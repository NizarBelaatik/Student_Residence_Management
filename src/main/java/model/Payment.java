package model;
import java.sql.Timestamp;


public class Payment {
    private String paymentId;
    private String email;
    private String roomId;
    private float amountDue;
    private float amountPaid;
    private Timestamp dueDate;
    private Timestamp paymentDate;
    private String status;

    public Payment(String paymentId,String email,String roomId,float amountDue,float amountPaid,Timestamp dueDate, Timestamp paymentDate,String status ){
        this.paymentId = paymentId;
        this.email = email;
        this.roomId = roomId;
        this.amountDue = amountDue;
        this.amountPaid = amountPaid;
        this.dueDate = dueDate;
        this.paymentDate = paymentDate;
        this.status =status ;

    }


    // Getters and Setters
    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getRoomId() {
        return roomId;
    }
    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public float getAmountDue() {
        return amountDue;
    }
    public void setAmountDue(float amountDue) {
        this.amountDue = amountDue;
    }

    public float getAmountPaid() {
        return amountPaid;
    }
    public void setAmountPaid(float amountPaid) {
        this.amountPaid = amountPaid;
    }

    public Timestamp getDueDate() {
        return dueDate;
    }
    public void setDuetDate(Timestamp dueDate) {
        this.dueDate = dueDate;
    }

    public Timestamp getPaymentDate() {
        return paymentDate;
    }
    public void setPaymentDate(Timestamp paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    // Helper Methods
    public boolean isPaymentComplete() {
        return amountPaid >= amountDue;
    }
}
