package com.bytenova.care.dao;

import com.bytenova.care.model.Doctor;
import com.bytenova.care.util.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Doctors with full JDBC CRUD operations.
 * ByteNova Care – Team ByteNova
 */
public class DoctorDao {

    /**
     * READ: Retrieves all doctors with department details.
     */
    public List<Doctor> findAll() {
        List<Doctor> list = new ArrayList<>();
        String sql = "SELECT d.id, d.user_id, d.department_id, dep.name AS department_name, d.doctor_reg_no, " +
                     "d.full_name, d.qualification, d.experience_years, d.phone, u.email, d.opd_room_no, " +
                     "d.opd_timings, d.status " +
                     "FROM doctors d " +
                     "JOIN departments dep ON d.department_id = dep.id " +
                     "JOIN users u ON d.user_id = u.id " +
                     "ORDER BY d.full_name ASC";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("[DoctorDao] findAll SQL Error: " + e.getMessage());
        }
        return list;
    }

    /**
     * READ: Finds doctor by primary key ID.
     */
    public Doctor findById(int id) {
        String sql = "SELECT d.id, d.user_id, d.department_id, dep.name AS department_name, d.doctor_reg_no, " +
                     "d.full_name, d.qualification, d.experience_years, d.phone, u.email, d.opd_room_no, " +
                     "d.opd_timings, d.status " +
                     "FROM doctors d " +
                     "JOIN departments dep ON d.department_id = dep.id " +
                     "JOIN users u ON d.user_id = u.id " +
                     "WHERE d.id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("[DoctorDao] findById SQL Error: " + e.getMessage());
        }
        return null;
    }

    /**
     * READ: Finds doctor by linked User ID.
     */
    public Doctor findByUserId(int userId) {
        String sql = "SELECT d.id, d.user_id, d.department_id, dep.name AS department_name, d.doctor_reg_no, " +
                     "d.full_name, d.qualification, d.experience_years, d.phone, u.email, d.opd_room_no, " +
                     "d.opd_timings, d.status " +
                     "FROM doctors d " +
                     "JOIN departments dep ON d.department_id = dep.id " +
                     "JOIN users u ON d.user_id = u.id " +
                     "WHERE d.user_id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("[DoctorDao] findByUserId SQL Error: " + e.getMessage());
        }
        return null;
    }

    /**
     * CREATE: Inserts a new doctor into the database.
     */
    public int save(Doctor doc) {
        String sql = "INSERT INTO doctors (user_id, department_id, doctor_reg_no, full_name, qualification, " +
                     "experience_years, phone, opd_room_no, opd_timings, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, doc.getUserId());
            ps.setInt(2, doc.getDepartmentId());
            ps.setString(3, doc.getDoctorRegNo());
            ps.setString(4, doc.getFullName());
            ps.setString(5, doc.getQualification());
            ps.setInt(6, doc.getExperienceYears());
            ps.setString(7, doc.getPhone());
            ps.setString(8, doc.getOpdRoomNo());
            ps.setString(9, doc.getOpdTimings());
            ps.setString(10, doc.getStatus() != null ? doc.getStatus().name() : "AVAILABLE");
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        doc.setId(rs.getInt(1));
                        return doc.getId();
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("[DoctorDao] save failed: " + e.getMessage());
        }
        return -1;
    }

    /**
     * UPDATE: Updates doctor details.
     */
    public boolean update(Doctor doc) {
        String sql = "UPDATE doctors SET department_id = ?, full_name = ?, qualification = ?, " +
                     "experience_years = ?, phone = ?, opd_room_no = ?, opd_timings = ?, status = ? " +
                     "WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, doc.getDepartmentId());
            ps.setString(2, doc.getFullName());
            ps.setString(3, doc.getQualification());
            ps.setInt(4, doc.getExperienceYears());
            ps.setString(5, doc.getPhone());
            ps.setString(6, doc.getOpdRoomNo());
            ps.setString(7, doc.getOpdTimings());
            ps.setString(8, doc.getStatus() != null ? doc.getStatus().name() : "AVAILABLE");
            ps.setInt(9, doc.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[DoctorDao] update failed: " + e.getMessage());
            return false;
        }
    }

    /**
     * DELETE: Deletes doctor record by ID.
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM doctors WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[DoctorDao] delete failed: " + e.getMessage());
            return false;
        }
    }

    private Doctor mapRow(ResultSet rs) throws SQLException {
        Doctor doc = new Doctor();
        doc.setId(rs.getInt("id"));
        doc.setUserId(rs.getInt("user_id"));
        doc.setDepartmentId(rs.getInt("department_id"));
        doc.setDepartmentName(rs.getString("department_name"));
        doc.setDoctorRegNo(rs.getString("doctor_reg_no"));
        doc.setFullName(rs.getString("full_name"));
        doc.setQualification(rs.getString("qualification"));
        doc.setExperienceYears(rs.getInt("experience_years"));
        doc.setPhone(rs.getString("phone"));
        doc.setEmail(rs.getString("email"));
        doc.setOpdRoomNo(rs.getString("opd_room_no"));
        doc.setOpdTimings(rs.getString("opd_timings"));
        doc.setStatus(Doctor.Status.valueOf(rs.getString("status")));
        return doc;
    }
}
