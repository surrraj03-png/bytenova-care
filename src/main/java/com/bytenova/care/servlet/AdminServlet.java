package com.bytenova.care.servlet;

import com.bytenova.care.dao.PatientDao;
import com.bytenova.care.model.Appointment;
import com.bytenova.care.model.Doctor;
import com.bytenova.care.model.Patient;
import com.bytenova.care.service.AppointmentService;
import com.bytenova.care.service.DoctorService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Controller servlet for Hospital Administrator dashboard.
 * ByteNova Care – Team ByteNova
 */
@WebServlet(name = "AdminServlet", urlPatterns = {"/admin/dashboard", "/admin/manage-doctors", "/admin/manage-appointments"})
public class AdminServlet extends HttpServlet {

    private final DoctorService doctorService = new DoctorService();
    private final AppointmentService appointmentService = new AppointmentService();
    private final PatientDao patientDao = new PatientDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Doctor> doctors = doctorService.getAllDoctors();
        List<Patient> patients = patientDao.findAll();
        List<Appointment> appointments = appointmentService.getAllAppointments();

        request.setAttribute("doctors", doctors);
        request.setAttribute("patients", patients);
        request.setAttribute("appointments", appointments);

        request.setAttribute("totalPatients", 1248);
        request.setAttribute("totalDoctors", doctors.size());
        request.setAttribute("totalAppointmentsToday", 42);
        request.setAttribute("totalRevenueToday", "₹21,000");

        request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
    }
}
