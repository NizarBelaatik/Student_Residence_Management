package model;
import java.sql.Timestamp;

public class Notification {
    private int id;
    private String sender;
    private String receiver;
    private String subject;
    private String msg;
    private boolean status;
    private String type; //reminder danger
    private Timestamp sendDate;
    private Timestamp checkedDate;


    public Notification(int id, String sender, String receiver, String subject, String msg, boolean status, String type, Timestamp sendDate, Timestamp checkedDate) {
        this.id = id;
        this.sender = sender;
        this.receiver = receiver;
        this.subject = subject;
        this.msg = msg;
        this.status = status;
        this.type = type;
        this.sendDate = sendDate;
        this.checkedDate = checkedDate;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public boolean getStatus() {
        return status;
    }
    public void setStatus(boolean status) {
        this.status = status;
    }


    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }

    public Timestamp getSendDate() {
        return sendDate;
    }

    public void setSendDate(Timestamp sendDate) {
        this.sendDate = sendDate;
    }

    public Timestamp getCheckedDate() {
        return checkedDate;
    }

    public void setCheckedDate(Timestamp checkedDate) {
        this.checkedDate = checkedDate;
    }
}