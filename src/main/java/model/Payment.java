package model;

public class Payment {
    private String paymentId;
    private String email;
    private float amountDue;
    private float amountPaid;
    private String dueDate;
    private String paymentDate;
    private String status;

    public Payment(String paymentId,String email,float amountDue,float amountPaid,String dueDate, String paymentDate,String status){
        this.paymentId = paymentId;
        this.email = email;
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

    public String getDueDate() {
        return dueDate;
    }
    public void setDuetDate(String dueDate) {
        this.dueDate = dueDate;
    }

    public String getPaymentDate() {
        return paymentDate;
    }
    public void setPaymentDate(String paymentDate) {
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
