package utils;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;

public class DateUtils {
    public static LocalDate getFDayOfMonth() {
        // Get the current date and adjust it to the first day of the month
        LocalDate today = LocalDate.now();
        return today.with(TemporalAdjusters.firstDayOfMonth());
    }



    public static Timestamp getLDayOfMonth() {
        // Get the current date and adjust it to the last day of the month
        LocalDate today = LocalDate.now();
        LocalDate lastDayOfMonth = today.with(TemporalAdjusters.lastDayOfMonth());

        // Convert LocalDate to LocalDateTime at midnight (00:00) to get a full timestamp
        LocalDateTime lastDayOfMonthDateTime = lastDayOfMonth.atStartOfDay();

        // Convert LocalDateTime to Timestamp
        return Timestamp.valueOf(lastDayOfMonthDateTime);
    }

    public static String getFDayOfMonthStr() {
        // Get the current date and adjust it to the first day of the month
        LocalDate today = LocalDate.now();
        LocalDate firstDayOfMonth = today.with(TemporalAdjusters.firstDayOfMonth());

        // Format the date to "yyyy-MM-dd"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return firstDayOfMonth.format(formatter);
    }

    // Function to get the last day of the current month as a formatted string
    public static String getLDayOfMonthStr() {
        // Get the current date and adjust it to the last day of the month
        LocalDate today = LocalDate.now();
        LocalDate lastDayOfMonth = today.with(TemporalAdjusters.lastDayOfMonth());

        // Format the date to "yyyy-MM-dd"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return lastDayOfMonth.format(formatter);
    }


    public static Timestamp convertToTimestamp(String dateString) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            java.util.Date date = sdf.parse(dateString);
            return new Timestamp(date.getTime());
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Method to convert a String to LocalDate
    public static LocalDate convertToLocalDate(String dateStr) {
        DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE; // e.g., "2024-08-01"
        return LocalDate.parse(dateStr, formatter);
    }

    // Method to format a Timestamp to a string in "dd MMMM yyyy" format (e.g., "10 January 2024")
    public static String formatTimestampToDate(Timestamp timestamp) {
        // Format the Timestamp to "dd MMMM yyyy"
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy");
        return sdf.format(timestamp);
    }

}
