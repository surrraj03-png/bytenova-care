package com.bytenova.care.dao;

import com.bytenova.care.model.Prescription;
import com.bytenova.care.util.DBConnectionUtil;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Prescriptions with JDBC operations.
 * ByteNova Care – Team ByteNova
 */
public class PrescriptionDao {

    public List<Prescription> findByPatientId(int patientId) {
        List<Prescription> list = new ArrayList<>();
        String sql = "SELECT pr.id, pr.appointment_id, pr.patient_id, p.full_name AS patient_name, p.uhid AS patient_uhid, " +
                     "pr.doctor_id, d.full_name AS doctor_name, d.qualification AS doctor_qualification, " +
                     "dep.name AS department_name, pr.diagnosis, pr.medicines, pr.tests_recommended, " +
                     "pr.doctor_notes, pr.follow_up_date, pr.created_at " +
                     "FROM prescriptions pr " +
                     "JOIN patients p ON pr.patient_id = p.id " +
                     "JOIN doctors d ON pr.doctor_id = d.id " +
                     "JOIN departments dep ON d.department_id = dep.id " +
                     "WHERE pr.patient_id = ? " +
                     "ORDER BY pr.created_at DESC";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("[PrescriptionDao] findByPatientId SQL Error: " + e.getMessage());
        }
        return list;
    }

    public Prescription findById(int id) {
        String sql = "SELECT pr.id, pr.appointment_id, pr.patient_id, p.full_name AS patient_name, p.uhid AS patient_uhid, " +
                     "pr.doctor_id, d.full_name AS doctor_name, d.qualification AS doctor_qualification, " +
                     "dep.name AS department_name, pr.diagnosis, pr.medicines, pr.tests_recommended, " +
                     "pr.doctor_notes, pr.follow_up_date, pr.created_at " +
                     "FROM prescriptions pr " +
                     "JOIN patients p ON pr.patient_id = p.id " +
                     "JOIN doctors d ON pr.doctor_id = d.id " +
                     "JOIN departments dep ON d.department_id = dep.id " +
                     "WHERE pr.id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("[PrescriptionDao] findById SQL Error: " + e.getMessage());
        }
        return null;
    }

    public int save(Prescription p) {
        String sql = "INSERT INTO prescriptions (appointment_id, patient_id, doctor_id, diagnosis, medicines, tests_recommended, doctor_notes, follow_up_date) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, p.getAppointmentId());
            ps.setInt(2, p.getPatientId());
            ps.setInt(3, p.getDoctorId());
            ps.setString(4, p.getDiagnosis());
            ps.setString(5, p.getMedicines());
            ps.setString(6, p.getTestsRecommended());
            ps.setString(7, p.getDoctorNotes());
            if (p.getFollowUpDate() != null) {
                ps.setDate(8, Date.valueOf(p.getFollowUpDate()));
            } else {
                ps.setNull(8, Types.DATE);
            }
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        p.setId(rs.getInt(1));
                        return p.getId();
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("[PrescriptionDao] save failed: " + e.getMessage());
        }
        return -1;
    }

    public boolean delete(int id) {
        String sql = "DELETE FROM prescriptions WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[PrescriptionDao] delete failed: " + e.getMessage());
            return false;
        }
    }

    private Prescription mapRow(ResultSet rs) throws SQLException {
        Prescription p = new Prescription();
        p.setId(rs.getInt("id"));
        p.setAppointmentId(rs.getInt("appointment_id"));
        p.setPatientId(rs.getInt("patient_id"));
        p.setPatientName(rs.getString("patient_name"));
        p.setPatientUhid(rs.getString("patient_uhid"));
        p.setDoctorId(rs.getInt("doctor_id"));
        p.setDoctorName(rs.getString("doctor_name"));
        p.setDoctorQualification(rs.getString("doctor_qualification"));
        p.setDepartmentName(rs.getString("department_name"));
        p.setDiagnosis(rs.getString("diagnosis"));
        p.setMedicines(rs.getString("medicines"));
        p.setTestsRecommended(rs.getString("tests_recommended"));
        p.setDoctorNotes(rs.getString("doctor_notes"));
        Date fDate = rs.getDate("follow_up_date");
        if (fDate != null) p.setFollowUpDate(fDate.toLocalDate());
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) p.setCreatedAt(ts.toLocalDateTime());
        return p;
    }
}
