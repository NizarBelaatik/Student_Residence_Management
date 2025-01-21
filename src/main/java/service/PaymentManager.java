package service;

import java.time.*;
import java.sql.*;
import java.util.List;

import dao.*;
import model.Notification;
import model.Payment;

import model.Resident;

import model.Room;

import utils.DateUtils;

public class PaymentManager {
    private PaymentDAO paymentDAO= new PaymentDAO();
    private ResidentDAO residentDAO= new ResidentDAO();
    private RoomDAO roomDAO= new RoomDAO();
    private NotificationDAO notificationDAO= new NotificationDAO();


    public void sendReminder(Resident Res){
        try{
            Room room = roomDAO.getRoomById(Res.getRoomId());
            Timestamp dueDate= DateUtils.getLDayOfMonth();

            generatePayementByResident(Res,room,dueDate);
            String residentName = Res.getFirstname() +" "+ Res.getLastname();  // Example: replace with actual resident name
            float amountDue = room.getPrice();         // Example: replace with actual amount due

            EmailSender.sendReminderEmail(Res.getEmail(), residentName, amountDue, dueDate);

            String subject = "Payment Due: " + amountDue;
            String msg = "Reminder: Pay your due fees of " + amountDue + " before " + dueDate + ". Check your email for more details.";
            Notification notif = new Notification(1,"ADMIN",Res.getEmail(),subject,msg,false,"reminder",null,null);
            notificationDAO.add(notif);

        }catch (SQLException e){e.printStackTrace();}
    }

    public boolean generateMonthlyPayment(){
        //return number of resident that received Payment

        try {
            if(!isPaymentsGeneratedForCurrentMonth()){
                try {

                    List<Resident> residents = residentDAO.getAllResidentsForPaymentGeneration();
                    residents.forEach(Res->{
                        try{
                            Room room = roomDAO.getRoomById(Res.getRoomId());
                            Timestamp dueDate= DateUtils.getLDayOfMonth();

                            generatePayementByResident(Res,room,dueDate);
                            String residentName = Res.getFirstname() +" "+ Res.getLastname();  // Example: replace with actual resident name
                            float amountDue = room.getPrice();         // Example: replace with actual amount due

                            EmailSender.sendReminderEmail(Res.getEmail(), residentName, amountDue, dueDate);

                        }catch (SQLException e){e.printStackTrace();}

                    });

                    markPaymentsAsGeneratedForCurrentMonth();
                }catch (SQLException e){
                    e.printStackTrace();

                    return false;
                }
            }
            if(!isPaymentsGeneratedForCurrentMonth()){
                try{
                    markPaymentsAsGeneratedForCurrentMonth();
                }catch (SQLException e){e.printStackTrace();}

            }
        }catch (SQLException e){e.printStackTrace();return false;}


        return true;
    }


    private boolean generatePayementByResident(Resident Res,Room room ,Timestamp dueDate){
        try {
            Payment payment= new Payment(null,Res.getFullname(),Res.getEmail(),Res.getRoomId(),room.getPrice(),0.0f,dueDate,null,"pending");
            paymentDAO.createPayment(payment);
        }catch (SQLException e){
            e.printStackTrace();

            return false;

        }
        return true;
    }




    // Check if payments were generated for the current month
    public boolean isPaymentsGeneratedForCurrentMonth() throws SQLException {
        LocalDate today = LocalDate.now();
        int currentYear = today.getYear();
        int currentMonth = today.getMonthValue();

        String query = "SELECT status FROM payment_generation_status WHERE month_year = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            // Format the month_year as "YYYY-MM"
            String monthYear = currentYear + "-" + String.format("%02d", currentMonth); // e.g., "2024-12"

            stmt.setString(1, monthYear);  // Pass the formatted month_year

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String status = rs.getString("status");
                return "Generated".equals(status);  // Return true if status is "Generated"
            }
            return false;  // If no record exists, return false (i.e., payments not generated)
        }

    }

    // Mark payments as generated for the current month
    private void markPaymentsAsGeneratedForCurrentMonth() throws SQLException {
        LocalDate today = LocalDate.now();
        int currentYear = today.getYear();
        int currentMonth = today.getMonthValue();

        // Format the month_year as "YYYY-MM"
        String monthYear = currentYear + "-" + String.format("%02d", currentMonth);  // e.g., "2024-12"

        String query = "INSERT INTO payment_generation_status (month_year, status) " +
                "VALUES (?, ?) " +
                "ON DUPLICATE KEY UPDATE status = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, monthYear);  // Set the month_year (e.g., "2024-12")
            stmt.setString(2, "Generated");  // Mark as "Generated"
            stmt.setString(3, "Generated");  // Update to "Generated" if record already exists
            stmt.executeUpdate();
        }
    }

}
