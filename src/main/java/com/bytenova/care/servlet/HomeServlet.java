package com.bytenova.care.servlet;

import com.bytenova.care.model.Department;
import com.bytenova.care.model.Doctor;
import com.bytenova.care.service.DoctorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Controller servlet for the Home Page.
 * Loads departments, featured doctors, and forwards to index.jsp.
 * ByteNova Care – Team ByteNova
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    private final DoctorService doctorService = new DoctorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Department> departments = doctorService.getAllDepartments();
        List<Doctor> doctors = doctorService.getAllDoctors();

        request.setAttribute("departments", departments);
        request.setAttribute("doctors", doctors);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
