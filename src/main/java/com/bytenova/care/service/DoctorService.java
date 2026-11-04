package com.bytenova.care.service;

import com.bytenova.care.dao.DepartmentDao;
import com.bytenova.care.dao.DoctorDao;
import com.bytenova.care.model.Department;
import com.bytenova.care.model.Doctor;

import java.util.List;

/**
 * Service managing doctor listings and department data.
 * ByteNova Care – Team ByteNova
 */
public class DoctorService {

    private final DoctorDao doctorDao = new DoctorDao();
    private final DepartmentDao departmentDao = new DepartmentDao();

    public List<Doctor> getAllDoctors() {
        return doctorDao.findAll();
    }

    public Doctor getDoctorById(int id) {
        return doctorDao.findById(id);
    }

    public Doctor getDoctorByUserId(int userId) {
        return doctorDao.findByUserId(userId);
    }

    public List<Department> getAllDepartments() {
        return departmentDao.findAll();
    }
}
