package model;


public class UserAdminTInfo {
    private int id;
    private String email;
    private String firstname;
    private String lastname;
    private String phone;


    // Constructor
    public UserAdminTInfo(String email, String firstname, String lastname, String phone) {
        this.email = email;
        this.firstname = firstname;
        this.lastname = lastname;
        this.phone = phone;
    }


    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }


    public String getFirstname() {
        return firstname;
    }
    public void setFirstname(String firstname) {this.firstname = firstname;}

    public String getLastname() {
        return lastname;
    }
    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public String getFullname() { return  firstname + " "+ lastname; }


    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

}
