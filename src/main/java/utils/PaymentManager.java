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


    private boolean generatePayment(){
        //return number of resident that received Payment

        try {
            if(!isPaymentsGeneratedForCurrentMonth()){

                try {

                    List<Resident> residents = residentDAO.getAllResidentsForPaymentGeneration();
                    residents.forEach(Res->{
                        try{
                            Room room = roomDAO.getRoomById(Res.getRoomId());
                            String dueDate= GetDate.getLDayOfMonthStr();

                            boolean generatePay=generatePayementByResident(Res,room,dueDate);


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
                    if(generatePay){
                        try{
                            markPaymentsAsGeneratedForCurrentMonth();

                        }catch (SQLException e){e.printStackTrace();}

                    }

                }catch (SQLException e){
                    e.printStackTrace();
                    return false;
                }
            }
        }catch (SQLException e){e.printStackTrace();return false;}
        return true;

    }
    private boolean generatePayementByResident(Resident Res,Room room ,String dueDate){
        try {
            Payment payment= new Payment(null,Res.getEmail(),Res.getRoomId(),room.getPrice(),0.0f,dueDate,null,null);
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

        String query = "SELECT generated FROM payment_generation_status WHERE year = ? AND month = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, currentYear);
            stmt.setInt(2, currentMonth);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("generated");
            }
            return false;  // If no record exists, return false (i.e., payments not generated)
        }
    }

    // Mark payments as generated for the current month
    private void markPaymentsAsGeneratedForCurrentMonth() throws SQLException {
        LocalDate today = LocalDate.now();
        int currentYear = today.getYear();
        int currentMonth = today.getMonthValue();

        String query = "INSERT INTO payment_generation_status (year, month, generated) VALUES (?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE generated = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, currentYear);
            stmt.setInt(2, currentMonth);
            stmt.setBoolean(3, true);  // Mark as generated
            stmt.setBoolean(4, true);  // Update in case the record already exists
            stmt.executeUpdate();
        }
    }

}
