package utils;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;

public class GetDate {
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

}
