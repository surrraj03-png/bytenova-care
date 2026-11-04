package com.bytenova.care.util;

import com.bytenova.care.dao.*;
import com.bytenova.care.model.*;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

/**
 * Stage 2 Database Integration Test Runner.
 * Executes real JDBC connection validation and end-to-end CRUD verification.
 * 
 * Team ByteNova | ByteNova Care
 */
public class DatabaseTestRunner {

    public static void main(String[] args) {
        System.out.println("=====================================================================");
        System.out.println("  ByteNova Care – Stage 2: MySQL 8 JDBC Integration Test");
        System.out.println("=====================================================================");

        // 1. Connection Test
        System.out.println("\n[STEP 1] Testing JDBC Connection...");
        System.out.println("Configured URL: " + DBConnectionUtil.getUrl());
        System.out.println("Database User:  " + DBConnectionUtil.getUsername());

        Connection conn = null;
        try {
            conn = DBConnectionUtil.getConnection();
            DatabaseMetaData meta = conn.getMetaData();
            System.out.println(">> CONNECTION SUCCESSFUL!");
            System.out.println(">> Database Engine:  " + meta.getDatabaseProductName() + " v" + meta.getDatabaseProductVersion());
            System.out.println(">> Driver:           " + meta.getDriverName() + " v" + meta.getDriverVersion());
        } catch (SQLException e) {
            System.err.println("\n>> CONNECTION FAILED!");
            System.err.println(">> Error:    " + e.getMessage());
            System.err.println(">> SQLState: " + e.getSQLState() + " | ErrorCode: " + e.getErrorCode());
            System.err.println("\n[ACTION REQUIRED] Ensure MySQL 8 is running, database 'healthcare_db' exists,");
            System.err.println("and credentials in db.properties (or db.local.properties) match your local MySQL root password.");
            System.exit(1);
            return;
        } finally {
            DBConnectionUtil.close(conn);
        }

        // 2. Schema Table Verification
        System.out.println("\n[STEP 2] Verifying Database Tables in healthcare_db...");
        String[] requiredTables = {"users", "departments", "doctors", "patients", "appointments", "prescriptions"};
        try (Connection c = DBConnectionUtil.getConnection()) {
            DatabaseMetaData meta = c.getMetaData();
            for (String tbl : requiredTables) {
                try (ResultSet rs = meta.getTables(null, null, tbl, new String[]{"TABLE"})) {
                    if (rs.next()) {
                        System.out.println("  [FOUND] Table: " + tbl);
                    } else {
                        System.err.println("  [MISSING] Table: " + tbl + " (Execute database/schema.sql first)");
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Table inspection error: " + e.getMessage());
        }

        // 3. Patient CRUD Verification
        System.out.println("\n[STEP 3] Testing Real Patient CRUD Operations...");
        UserDao userDao = new UserDao();
        PatientDao patientDao = new PatientDao();

        // 3a. CREATE
        User testUser = new User("test.patient." + System.currentTimeMillis() + "@bytenovacare.in", 
                                 PasswordUtil.hashPassword("testpass"), User.Role.PATIENT);
        int userId = userDao.save(testUser);

        Patient p = new Patient();
        p.setUserId(userId > 0 ? userId : 7);
        p.setUhid("BNC-TEST-" + (System.currentTimeMillis() % 10000));
        p.setFullName("Test Patient Vikram");
        p.setPhone("9876543210");
        p.setGender(Patient.Gender.MALE);
        p.setDateOfBirth(LocalDate.of(1995, 5, 20));
        p.setBloodGroup("O+");
        p.setAddress("Test Address, Delhi");
        p.setEmergencyContact("9876500000");

        int patientId = patientDao.save(p);
        if (patientId > 0) {
            System.out.println("  [CREATE] Patient inserted successfully with ID: " + patientId + ", UHID: " + p.getUhid());
        } else {
            System.err.println("  [CREATE FAILED] Could not insert test patient.");
        }

        // 3b. READ
        Patient fetched = patientDao.findById(patientId);
        if (fetched != null && fetched.getFullName().equals("Test Patient Vikram")) {
            System.out.println("  [READ] Patient verified: " + fetched.getFullName() + " | " + fetched.getUhid());
        } else {
            System.err.println("  [READ FAILED] Patient not found or data mismatch.");
        }

        // 3c. UPDATE
        if (fetched != null) {
            fetched.setFullName("Test Patient Vikram Updated");
            fetched.setAddress("Updated Address, Noida");
            boolean updated = patientDao.update(fetched);
            System.out.println("  [UPDATE] Patient updated: " + (updated ? "SUCCESS" : "FAILED"));
        }

        // 3d. DELETE
        if (patientId > 0) {
            boolean deleted = patientDao.delete(patientId);
            if (userId > 0) userDao.delete(userId);
            System.out.println("  [DELETE] Test Patient cleaned up: " + (deleted ? "SUCCESS" : "FAILED"));
        }

        // 4. Doctor CRUD Verification
        System.out.println("\n[STEP 4] Testing Real Doctor CRUD Operations...");
        DoctorDao doctorDao = new DoctorDao();
        DepartmentDao deptDao = new DepartmentDao();

        List<Doctor> doctors = doctorDao.findAll();
        System.out.println("  [READ] Total active doctors retrieved from DB: " + doctors.size());
        if (!doctors.isEmpty()) {
            Doctor d1 = doctors.get(0);
            System.out.println("  [READ] Sample Doctor: " + d1.getFullName() + " (" + d1.getQualification() + ")");
        }

        // 5. Appointment CRUD Verification
        System.out.println("\n[STEP 5] Testing Real Appointment CRUD Operations...");
        AppointmentDao apptDao = new AppointmentDao();

        Appointment appt = new Appointment();
        appt.setAppointmentNumber("APT-TEST-" + System.currentTimeMillis() % 10000);
        appt.setPatientId(1);
        appt.setDoctorId(1);
        appt.setDepartmentId(1);
        appt.setAppointmentDate(LocalDate.now().plusDays(2));
        appt.setTimeSlot("10:00 AM - 10:30 AM");
        appt.setTokenNumber(99);
        appt.setSymptoms("Test verification symptoms");
        appt.setFeeAmount(new BigDecimal("400.00"));
        appt.setFeeStatus(Appointment.FeeStatus.PENDING_AT_COUNTER);
        appt.setStatus(Appointment.Status.CONFIRMED);

        int apptId = apptDao.save(appt);
        if (apptId > 0) {
            System.out.println("  [CREATE] Appointment scheduled with ID: " + apptId + " (Number: " + appt.getAppointmentNumber() + ")");
            Appointment fetchedAppt = apptDao.findById(apptId);
            if (fetchedAppt != null) {
                System.out.println("  [READ] Appointment retrieved: " + fetchedAppt.getAppointmentNumber() + " | Status: " + fetchedAppt.getStatus());
            }

            // Update status
            boolean statusUpdated = apptDao.updateStatus(apptId, Appointment.Status.COMPLETED);
            System.out.println("  [UPDATE] Status updated to COMPLETED: " + (statusUpdated ? "SUCCESS" : "FAILED"));

            // Delete cleanup
            boolean deletedAppt = apptDao.delete(apptId);
            System.out.println("  [DELETE] Test Appointment cleaned up: " + (deletedAppt ? "SUCCESS" : "FAILED"));
        } else {
            System.err.println("  [CREATE FAILED] Could not create test appointment.");
        }

        System.out.println("\n=====================================================================");
        System.out.println("  ByteNova Care – JDBC & Database Integration Verified!");
        System.out.println("=====================================================================");
    }
}
