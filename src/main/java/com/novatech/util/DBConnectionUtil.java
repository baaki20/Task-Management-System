package com.novatech.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnectionUtil {

    private static final String PROPERTIES_FILE = "db.properties";
    private static String driverClassName;
    private static String url;
    private static String username;
    private static String password;

    static {
        try (InputStream input = Thread.currentThread()
                .getContextClassLoader()
                .getResourceAsStream(PROPERTIES_FILE)) {
            if (input == null) {
                throw new RuntimeException("Cannot find " + PROPERTIES_FILE);
            }
            Properties prop = new Properties();
            prop.load(input);

            driverClassName = prop.getProperty("jdbc.driverClassName");
            url             = prop.getProperty("jdbc.url");
            username        = prop.getProperty("jdbc.username");
            password        = prop.getProperty("jdbc.password");

            Class.forName(driverClassName);
        } catch (IOException | ClassNotFoundException ex) {
            throw new ExceptionInInitializerError("DB config load failed: " + ex.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, username, password);
    }
}
