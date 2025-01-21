package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // Database connection details from configuration (can be moved to an external file like properties)
    private static final String URL = "jdbc:mysql://localhost:3306/SRM_DB";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Private constructor to prevent instantiation
    private DatabaseConnection() {}

    // Get connection method
    public static Connection getConnection() throws SQLException {
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("MySQL JDBC Driver not found.");
        }
    }
}
