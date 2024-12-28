package utils;

import java.time.*;
import java.sql.*;
import java.util.List;

import dao.PaymentDAO;
import model.Payment;

import model.Resident;
import dao.ResidentDAO;

import model.Room;
import dao.RoomDAO;

import utils.EmailSender;

public class PaymentManager {
    private PaymentDAO paymentDAO= new PaymentDAO();
    private ResidentDAO residentDAO= new ResidentDAO();
    private RoomDAO roomDAO= new RoomDAO();


    public boolean generatePayment(){
        //return number of resident that received Payment

        try {
            if(!isPaymentsGeneratedForCurrentMonth()){

                try {

                    List<Resident> residents = residentDAO.getAllResidentsForPaymentGeneration();
                    residents.forEach(Res->{
                        try{
                            Room room = roomDAO.getRoomById(Res.getRoomId());
                            String dueDate= GetDate.getLDayOfMonthStr();

                            generatePayementByResident(Res,room,dueDate);
                            String residentName = Res.getFirstname() +" "+ Res.getLastname();  // Example: replace with actual resident name
                            float amountDue = room.getPrice();         // Example: replace with actual amount due
                            String paymentLink = Res.getEmail();  // Example: replace with actual payment link

                            String emailSubject = "Rent Payment Reminder - Due " + dueDate;

                            String emailBody = "Dear " + residentName + ",\n\n" +
                                    "This is a reminder that your rent payment of " + amountDue + " is due on " + dueDate + ".\n\n" +
                                    "Please ensure that the payment is made by the due date to avoid any late fees. "+
                                    "If you have already made the payment, please disregard this message.\n\n" +
                                    "Thank you!!";


                            EmailSender.sendEmail( Res.getEmail(),  emailSubject,  emailBody);


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


    private boolean generatePayementByResident(Resident Res,Room room ,String dueDate){
        try {
            Payment payment= new Payment(null,Res.getEmail(),Res.getRoomId(),room.getPrice(),0.0f,dueDate,null,"overdue");
            paymentDAO.createPayment(payment);
        }catch (SQLException e){
            e.printStackTrace();
            return false;

        }
        return true;
    }




    // Check if payments were generated for the current month
    private boolean isPaymentsGeneratedForCurrentMonth() throws SQLException {
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
