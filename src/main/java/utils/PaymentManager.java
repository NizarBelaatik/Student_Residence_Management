package utils;

import java.util.concurrent.*;
import java.time.*;
import java.time.temporal.ChronoUnit;
import java.sql.*;
import java.util.List;

import utils.GetData;

import dao.PaymentDAO;
import model.Payment;

import model.Resident;
import dao.ResidentDAO;

import model.Room;
import dao.RoomDAO;



public class PaymentManager {
    private PaymentDAO paymentDAO= new PaymentDAO();
    private ResidentDAO residentDAO= new ResidentDAO();
    private RoomDAO roomDAO= new RoomDAO();


    private boolean generatePayment(){
        try {
            if(!isPaymentsGeneratedForCurrentMonth()){
                try {
                    List<Resident> residents = residentDAO.getAllResidentsForPaymentGeneration();
                    residents.forEach(Res->{
                        boolean generatePayment=generatePayementByResident(Res);
                        if(generatePayment){
                            try{
                                markPaymentsAsGeneratedForCurrentMonth();
                            }catch (SQLException e){e.printStackTrace();}

                        }
                    });
                }catch (SQLException e){
                    e.printStackTrace();
                    return false;
                }
            }
        }catch (SQLException e){e.printStackTrace();return false;}
        return true;

    }
    private boolean generatePayementByResident(Resident Res){
        try {
            Room room = roomDAO.getRoomById(Res.getRoomId());
            String dueDate=GetData.getFDayOfMonthStr();

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
