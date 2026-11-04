package com.bytenova.care.dao;

import com.bytenova.care.model.Patient;
import com.bytenova.care.util.DBConnectionUtil;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Patients with full JDBC CRUD operations.
 * ByteNova Care – Team ByteNova
 */
public class PatientDao {

    /**
     * READ: Retrieves all patients.
     */
    public List<Patient> findAll() {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT p.id, p.user_id, p.uhid, p.full_name, u.email, p.phone, p.gender, " +
                     "p.date_of_birth, p.blood_group, p.address, p.emergency_contact " +
                     "FROM patients p " +
                     "JOIN users u ON p.user_id = u.id " +
                     "ORDER BY p.id DESC";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("[PatientDao] findAll SQL Error: " + e.getMessage());
        }
        return list;
    }

    /**
     * READ: Finds patient by primary key ID.
     */
    public Patient findById(int id) {
        String sql = "SELECT p.id, p.user_id, p.uhid, p.full_name, u.email, p.phone, p.gender, " +
                     "p.date_of_birth, p.blood_group, p.address, p.emergency_contact " +
                     "FROM patients p " +
                     "JOIN users u ON p.user_id = u.id " +
                     "WHERE p.id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("[PatientDao] findById SQL Error: " + e.getMessage());
        }
        return null;
    }

    /**
     * READ: Finds patient by User Account ID.
     */
    public Patient findByUserId(int userId) {
        String sql = "SELECT p.id, p.user_id, p.uhid, p.full_name, u.email, p.phone, p.gender, " +
                     "p.date_of_birth, p.blood_group, p.address, p.emergency_contact " +
                     "FROM patients p " +
                     "JOIN users u ON p.user_id = u.id " +
                     "WHERE p.user_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("[PatientDao] findByUserId SQL Error: " + e.getMessage());
        }
        return null;
    }

    /**
     * READ: Finds patient by Unique Health Identifier (UHID).
     */
    public Patient findByUhid(String uhid) {
        String sql = "SELECT p.id, p.user_id, p.uhid, p.full_name, u.email, p.phone, p.gender, " +
                     "p.date_of_birth, p.blood_group, p.address, p.emergency_contact " +
                     "FROM patients p " +
                     "JOIN users u ON p.user_id = u.id " +
                     "WHERE p.uhid = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, uhid);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("[PatientDao] findByUhid SQL Error: " + e.getMessage());
        }
        return null;
    }

    /**
     * CREATE: Inserts a new patient record into the database.
     */
    public int save(Patient patient) {
        String sql = "INSERT INTO patients (user_id, uhid, full_name, phone, gender, date_of_birth, blood_group, address, emergency_contact) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, patient.getUserId());
            ps.setString(2, patient.getUhid());
            ps.setString(3, patient.getFullName());
            ps.setString(4, patient.getPhone());
            ps.setString(5, patient.getGender().name());
            ps.setDate(6, Date.valueOf(patient.getDateOfBirth()));
            ps.setString(7, patient.getBloodGroup());
            ps.setString(8, patient.getAddress());
            ps.setString(9, patient.getEmergencyContact());
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        patient.setId(rs.getInt(1));
                        return patient.getId();
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("[PatientDao] save failed: " + e.getMessage());
        }
        return -1;
    }

    /**
     * UPDATE: Updates an existing patient record.
     */
    public boolean update(Patient patient) {
        String sql = "UPDATE patients SET full_name = ?, phone = ?, gender = ?, date_of_birth = ?, " +
                     "blood_group = ?, address = ?, emergency_contact = ? WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, patient.getFullName());
            ps.setString(2, patient.getPhone());
            ps.setString(3, patient.getGender().name());
            ps.setDate(4, Date.valueOf(patient.getDateOfBirth()));
            ps.setString(5, patient.getBloodGroup());
            ps.setString(6, patient.getAddress());
            ps.setString(7, patient.getEmergencyContact());
            ps.setInt(8, patient.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[PatientDao] update failed: " + e.getMessage());
            return false;
        }
    }

    /**
     * DELETE: Deletes a patient by ID.
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM patients WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[PatientDao] delete failed: " + e.getMessage());
            return false;
        }
    }

    private Patient mapRow(ResultSet rs) throws SQLException {
        Patient p = new Patient();
        p.setId(rs.getInt("id"));
        p.setUserId(rs.getInt("user_id"));
        p.setUhid(rs.getString("uhid"));
        p.setFullName(rs.getString("full_name"));
        p.setEmail(rs.getString("email"));
        p.setPhone(rs.getString("phone"));
        p.setGender(Patient.Gender.valueOf(rs.getString("gender")));
        Date dob = rs.getDate("date_of_birth");
        if (dob != null) {
            p.setDateOfBirth(dob.toLocalDate());
        }
        p.setBloodGroup(rs.getString("blood_group"));
        p.setAddress(rs.getString("address"));
        p.setEmergencyContact(rs.getString("emergency_contact"));
        return p;
    }
}
