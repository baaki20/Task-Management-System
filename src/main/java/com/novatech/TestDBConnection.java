package com.novatech;

import com.novatech.util.DBConnectionUtil;
import java.sql.Connection;

public class TestDBConnection {
    public static void main(String[] args) {
        try (Connection conn = DBConnectionUtil.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ Connection successful!");
            } else {
                System.out.println("❌ Connection failed!");
            }
        } catch (Exception e) {
            System.out.println("❌ Exception: " + e.getMessage());
        }
    }
}
