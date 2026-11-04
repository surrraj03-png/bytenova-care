package com.bytenova.care.servlet;

import com.bytenova.care.model.Appointment;
import com.bytenova.care.model.Department;
import com.bytenova.care.model.Doctor;
import com.bytenova.care.model.Prescription;
import com.bytenova.care.service.AppointmentService;
import com.bytenova.care.service.DoctorService;
import com.bytenova.care.util.DateUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

/**
 * Controller servlet for Patient actions and dashboard routing.
 * ByteNova Care – Team ByteNova
 */
@WebServlet(name = "PatientServlet", urlPatterns = {"/patient/dashboard", "/patient/book-appointment"})
public class PatientServlet extends HttpServlet {

    private final AppointmentService appointmentService = new AppointmentService();
    private final DoctorService doctorService = new DoctorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int patientId = 1; // Default demo patient (Rahul Verma)
        List<Appointment> appointments = appointmentService.getPatientAppointments(patientId);
        List<Prescription> prescriptions = appointmentService.getPatientPrescriptions(patientId);
        List<Doctor> doctors = doctorService.getAllDoctors();
        List<Department> departments = doctorService.getAllDepartments();

        request.setAttribute("appointments", appointments);
        request.setAttribute("prescriptions", prescriptions);
        request.setAttribute("doctors", doctors);
        request.setAttribute("departments", departments);

        request.getRequestDispatcher("/patient-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/patient/book-appointment".equals(path)) {
            try {
                int patientId = 1;
                String patientName = request.getParameter("patientName");
                String uhid = request.getParameter("uhid");
                int doctorId = Integer.parseInt(request.getParameter("doctorId"));
                int departmentId = Integer.parseInt(request.getParameter("departmentId"));
                String dateStr = request.getParameter("appointmentDate");
                String slot = request.getParameter("timeSlot");
                String symptoms = request.getParameter("symptoms");

                LocalDate date = DateUtil.parseIndianDate(dateStr);

                appointmentService.bookAppointment(
                        patientId,
                        patientName != null ? patientName : "Rahul Verma",
                        uhid != null ? uhid : "BNC-2026-0842",
                        doctorId,
                        departmentId,
                        date,
                        slot,
                        symptoms
                );

                response.sendRedirect(request.getContextPath() + "/patient-dashboard.jsp?status=booked");
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/patient-dashboard.jsp?error=booking_failed");
            }
        }
    }
}
