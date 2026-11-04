package com.bytenova.care.dao;

import com.bytenova.care.model.Department;
import com.bytenova.care.util.DBConnectionUtil;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Departments with JDBC operations.
 * ByteNova Care – Team ByteNova
 */
public class DepartmentDao {

    public List<Department> findAll() {
        List<Department> list = new ArrayList<>();
        String sql = "SELECT id, name, code, description, consultation_fee FROM departments ORDER BY id ASC";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("[DepartmentDao] findAll SQL Error: " + e.getMessage());
        }
        return list;
    }

    public Department findById(int id) {
        String sql = "SELECT id, name, code, description, consultation_fee FROM departments WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("[DepartmentDao] findById failed: " + e.getMessage());
        }
        return null;
    }

    public int save(Department d) {
        String sql = "INSERT INTO departments (name, code, description, consultation_fee) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, d.getName());
            ps.setString(2, d.getCode());
            ps.setString(3, d.getDescription());
            ps.setBigDecimal(4, d.getConsultationFee());
            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        d.setId(rs.getInt(1));
                        return d.getId();
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("[DepartmentDao] save failed: " + e.getMessage());
        }
        return -1;
    }

    private Department mapRow(ResultSet rs) throws SQLException {
        Department d = new Department();
        d.setId(rs.getInt("id"));
        d.setName(rs.getString("name"));
        d.setCode(rs.getString("code"));
        d.setDescription(rs.getString("description"));
        d.setConsultationFee(rs.getBigDecimal("consultation_fee"));
        return d;
    }
}
