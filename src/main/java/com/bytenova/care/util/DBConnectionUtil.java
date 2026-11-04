package com.bytenova.care.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Enhanced Database Connection Utility for MySQL 8.
 * Supports credential resolution with the following priority:
 * 1. Environment variables (DB_URL, DB_USERNAME, DB_PASSWORD / MYSQL_*)
 * 2. Local config file excluded from Git (db.local.properties)
 * 3. Classpath db.properties
 * 
 * ByteNova Care – Team ByteNova
 */
public class DBConnectionUtil {

    private static final Properties properties = new Properties();
    private static boolean driverLoaded = false;

    static {
        loadConfiguration();
    }

    /**
     * Loads database configuration following the precedence hierarchy.
     */
    public static synchronized void loadConfiguration() {
        properties.clear();

        // 1. Load from classpath db.properties as baseline
        try (InputStream input = DBConnectionUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input != null) {
                properties.load(input);
            }
        } catch (IOException e) {
            System.err.println("[ByteNova Care] Warning: Failed to load classpath db.properties: " + e.getMessage());
        }

        // 2. Check for local external override: db.local.properties (ignored in Git)
        // First check classpath (e.g. src/main/resources/db.local.properties or WEB-INF/classes)
        try (InputStream localInput = DBConnectionUtil.class.getClassLoader().getResourceAsStream("db.local.properties")) {
            if (localInput != null) {
                properties.load(localInput);
                System.out.println("[ByteNova Care] Loaded local credentials override from classpath: db.local.properties");
            }
        } catch (IOException ignored) {
        }

        // Next check file system locations (project root, working dir, Tomcat conf)
        String catalinaBase = System.getProperty("catalina.base");
        File[] candidateFiles = new File[] {
            new File("db.local.properties"),
            new File("C:/Users/suryy/.gemini/antigravity/scratch/bytenova-care/db.local.properties"),
            new File("../bytenova-care/db.local.properties"),
            new File("../../bytenova-care/db.local.properties"),
            catalinaBase != null ? new File(catalinaBase, "conf/db.local.properties") : null,
            catalinaBase != null ? new File(catalinaBase, "../../bytenova-care/db.local.properties") : null,
            new File("config/db.local.properties")
        };

        for (File f : candidateFiles) {
            if (f != null && f.exists() && f.isFile()) {
                try (FileInputStream fis = new FileInputStream(f)) {
                    properties.load(fis);
                    System.out.println("[ByteNova Care] Loaded local credentials override from file: " + f.getAbsolutePath());
                    break;
                } catch (IOException e) {
                    System.err.println("[ByteNova Care] Warning: Failed to read " + f.getName() + ": " + e.getMessage());
                }
            }
        }

        // 3. Environment Variables (Highest priority)
        overrideFromEnv("DB_DRIVER", "db.driver");
        overrideFromEnv("DB_URL", "db.url");
        overrideFromEnv("MYSQL_URL", "db.url");
        overrideFromEnv("DB_USERNAME", "db.username");
        overrideFromEnv("DB_USER", "db.username");
        overrideFromEnv("MYSQL_USER", "db.username");
        overrideFromEnv("DB_PASSWORD", "db.password");
        overrideFromEnv("DB_PASS", "db.password");
        overrideFromEnv("MYSQL_PASSWORD", "db.password");

        // Register driver
        String driver = getDriver();
        try {
            Class.forName(driver);
            driverLoaded = true;
        } catch (ClassNotFoundException e) {
            driverLoaded = false;
            System.err.println("[ByteNova Care] Error: MySQL JDBC Driver class not found: " + driver);
        }
    }

    private static void overrideFromEnv(String envVar, String propKey) {
        String val = System.getenv(envVar);
        if (val != null && !val.trim().isEmpty()) {
            properties.setProperty(propKey, val.trim());
        }
    }

    public static String getUrl() {
        return properties.getProperty("db.url", "jdbc:mysql://localhost:3306/healthcare_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata&characterEncoding=UTF-8");
    }

    public static String getUsername() {
        return properties.getProperty("db.username", "root");
    }

    public static String getPassword() {
        return properties.getProperty("db.password", "root");
    }

    public static String getDriver() {
        return properties.getProperty("db.driver", "com.mysql.cj.jdbc.Driver");
    }

    /**
     * Obtains a live JDBC Connection to the configured MySQL database.
     * Throws SQLException if connection cannot be established.
     */
    public static Connection getConnection() throws SQLException {
        if (!driverLoaded) {
            loadConfiguration();
        }
        return DriverManager.getConnection(getUrl(), getUsername(), getPassword());
    }

    /**
     * Tests connectivity to the database and prints diagnostic details.
     */
    public static boolean testConnection() {
        System.out.println("--- Testing ByteNova Care JDBC Connection ---");
        System.out.println("JDBC Driver: " + getDriver());
        System.out.println("Connection URL: " + getUrl());
        System.out.println("Database User: " + getUsername());

        try (Connection conn = getConnection()) {
            DatabaseMetaData meta = conn.getMetaData();
            System.out.println("[SUCCESS] Connected to MySQL database successfully!");
            System.out.println("Database Product: " + meta.getDatabaseProductName() + " " + meta.getDatabaseProductVersion());
            System.out.println("JDBC Driver Version: " + meta.getDriverName() + " " + meta.getDriverVersion());
            return true;
        } catch (SQLException e) {
            System.err.println("[FAIL] Connection failed: " + e.getMessage());
            System.err.println("SQLState: " + e.getSQLState() + " | ErrorCode: " + e.getErrorCode());
            return false;
        }
    }

    /**
     * Safely closes an AutoCloseable resource.
     */
    public static void close(AutoCloseable closeable) {
        if (closeable != null) {
            try {
                closeable.close();
            } catch (Exception ignored) {
            }
        }
    }
}
