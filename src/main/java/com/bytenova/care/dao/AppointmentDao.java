package com.bytenova.care.dao;

import com.bytenova.care.model.Appointment;
import com.bytenova.care.util.DBConnectionUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for OPD Appointments with full JDBC CRUD operations.
 * ByteNova Care – Team ByteNova
 */
public class AppointmentDao {

    /**
     * READ: Retrieves all appointments with patient and doctor details.
     */
    public List<Appointment> findAll() {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.id, a.appointment_number, a.patient_id, p.full_name AS patient_name, p.uhid AS patient_uhid, " +
                     "a.doctor_id, d.full_name AS doctor_name, a.department_id, dep.name AS department_name, " +
                     "a.appointment_date, a.time_slot, a.token_number, a.symptoms, a.fee_amount, a.fee_status, a.status, a.created_at " +
                     "FROM appointments a " +
                     "JOIN patients p ON a.patient_id = p.id " +
                     "JOIN doctors d ON a.doctor_id = d.id " +
                     "JOIN departments dep ON a.department_id = dep.id " +
                     "ORDER BY a.appointment_date DESC, a.token_number ASC";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("[AppointmentDao] findAll SQL Error: " + e.getMessage());
        }
        return list;
    }

    /**
     * READ: Finds appointment by ID.
     */
    public Appointment findById(int id) {
        String sql = "SELECT a.id, a.appointment_number, a.patient_id, p.full_name AS patient_name, p.uhid AS patient_uhid, " +
                     "a.doctor_id, d.full_name AS doctor_name, a.department_id, dep.name AS department_name, " +
                     "a.appointment_date, a.time_slot, a.token_number, a.symptoms, a.fee_amount, a.fee_status, a.status, a.created_at " +
                     "FROM appointments a " +
                     "JOIN patients p ON a.patient_id = p.id " +
                     "JOIN doctors d ON a.doctor_id = d.id " +
                     "JOIN departments dep ON a.department_id = dep.id " +
                     "WHERE a.id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("[AppointmentDao] findById SQL Error: " + e.getMessage());
        }
        return null;
    }

    /**
     * READ: Finds appointments by Patient ID.
     */
    public List<Appointment> findByPatientId(int patientId) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.id, a.appointment_number, a.patient_id, p.full_name AS patient_name, p.uhid AS patient_uhid, " +
                     "a.doctor_id, d.full_name AS doctor_name, a.department_id, dep.name AS department_name, " +
                     "a.appointment_date, a.time_slot, a.token_number, a.symptoms, a.fee_amount, a.fee_status, a.status, a.created_at " +
                     "FROM appointments a " +
                     "JOIN patients p ON a.patient_id = p.id " +
                     "JOIN doctors d ON a.doctor_id = d.id " +
                     "JOIN departments dep ON a.department_id = dep.id " +
                     "WHERE a.patient_id = ? " +
                     "ORDER BY a.appointment_date DESC, a.token_number ASC";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("[AppointmentDao] findByPatientId SQL Error: " + e.getMessage());
        }
        return list;
    }

    /**
     * READ: Finds today's queue for a Doctor.
     */
    public List<Appointment> findTodayAppointmentsByDoctor(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.id, a.appointment_number, a.patient_id, p.full_name AS patient_name, p.uhid AS patient_uhid, " +
                     "a.doctor_id, d.full_name AS doctor_name, a.department_id, dep.name AS department_name, " +
                     "a.appointment_date, a.time_slot, a.token_number, a.symptoms, a.fee_amount, a.fee_status, a.status, a.created_at " +
                     "FROM appointments a " +
                     "JOIN patients p ON a.patient_id = p.id " +
                     "JOIN doctors d ON a.doctor_id = d.id " +
                     "JOIN departments dep ON a.department_id = dep.id " +
                     "WHERE a.doctor_id = ? AND a.appointment_date = CURDATE() " +
                     "ORDER BY a.token_number ASC";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("[AppointmentDao] findTodayAppointmentsByDoctor SQL Error: " + e.getMessage());
        }
        return list;
    }

    /**
     * CREATE: Schedules a new appointment.
     */
    public int save(Appointment appt) {
        String sql = "INSERT INTO appointments (appointment_number, patient_id, doctor_id, department_id, " +
                     "appointment_date, time_slot, token_number, symptoms, fee_amount, fee_status, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, appt.getAppointmentNumber());
            ps.setInt(2, appt.getPatientId());
            ps.setInt(3, appt.getDoctorId());
            ps.setInt(4, appt.getDepartmentId());
            ps.setDate(5, Date.valueOf(appt.getAppointmentDate()));
            ps.setString(6, appt.getTimeSlot());
            ps.setInt(7, appt.getTokenNumber());
            ps.setString(8, appt.getSymptoms());
            ps.setBigDecimal(9, appt.getFeeAmount());
            ps.setString(10, appt.getFeeStatus() != null ? appt.getFeeStatus().name() : "PENDING_AT_COUNTER");
            ps.setString(11, appt.getStatus() != null ? appt.getStatus().name() : "CONFIRMED");
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        appt.setId(rs.getInt(1));
                        return appt.getId();
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("[AppointmentDao] save failed: " + e.getMessage());
        }
        return -1;
    }

    /**
     * UPDATE: Updates appointment status.
     */
    public boolean updateStatus(int appointmentId, Appointment.Status newStatus) {
        String sql = "UPDATE appointments SET status = ? WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus.name());
            ps.setInt(2, appointmentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[AppointmentDao] updateStatus failed: " + e.getMessage());
            return false;
        }
    }

    /**
     * UPDATE: Updates general appointment record.
     */
    public boolean update(Appointment appt) {
        String sql = "UPDATE appointments SET appointment_date = ?, time_slot = ?, symptoms = ?, " +
                     "fee_amount = ?, fee_status = ?, status = ? WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, Date.valueOf(appt.getAppointmentDate()));
            ps.setString(2, appt.getTimeSlot());
            ps.setString(3, appt.getSymptoms());
            ps.setBigDecimal(4, appt.getFeeAmount());
            ps.setString(5, appt.getFeeStatus().name());
            ps.setString(6, appt.getStatus().name());
            ps.setInt(7, appt.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[AppointmentDao] update failed: " + e.getMessage());
            return false;
        }
    }

    /**
     * DELETE: Deletes appointment by ID.
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM appointments WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("[AppointmentDao] delete failed: " + e.getMessage());
            return false;
        }
    }

    private Appointment mapRow(ResultSet rs) throws SQLException {
        Appointment a = new Appointment();
        a.setId(rs.getInt("id"));
        a.setAppointmentNumber(rs.getString("appointment_number"));
        a.setPatientId(rs.getInt("patient_id"));
        a.setPatientName(rs.getString("patient_name"));
        a.setPatientUhid(rs.getString("patient_uhid"));
        a.setDoctorId(rs.getInt("doctor_id"));
        a.setDoctorName(rs.getString("doctor_name"));
        a.setDepartmentId(rs.getInt("department_id"));
        a.setDepartmentName(rs.getString("department_name"));
        Date d = rs.getDate("appointment_date");
        if (d != null) a.setAppointmentDate(d.toLocalDate());
        a.setTimeSlot(rs.getString("time_slot"));
        a.setTokenNumber(rs.getInt("token_number"));
        a.setSymptoms(rs.getString("symptoms"));
        a.setFeeAmount(rs.getBigDecimal("fee_amount"));
        a.setFeeStatus(Appointment.FeeStatus.valueOf(rs.getString("fee_status")));
        a.setStatus(Appointment.Status.valueOf(rs.getString("status")));
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) a.setCreatedAt(ts.toLocalDateTime());
        return a;
    }
}
