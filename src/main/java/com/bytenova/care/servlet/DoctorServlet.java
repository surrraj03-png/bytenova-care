package com.bytenova.care.servlet;

import com.bytenova.care.model.Appointment;
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
 * Controller servlet for Doctor actions, patient queue, and prescriptions.
 * ByteNova Care – Team ByteNova
 */
@WebServlet(name = "DoctorServlet", urlPatterns = {"/doctor/dashboard", "/doctor/update-status", "/doctor/prescribe"})
public class DoctorServlet extends HttpServlet {

    private final AppointmentService appointmentService = new AppointmentService();
    private final DoctorService doctorService = new DoctorService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int doctorId = 1; // Default demo doctor: Dr. Rajesh Sharma
        List<Appointment> todayQueue = appointmentService.getDoctorTodayAppointments(doctorId);

        request.setAttribute("todayQueue", todayQueue);
        request.setAttribute("doctorProfile", doctorService.getDoctorById(doctorId));

        request.getRequestDispatcher("/doctor-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/doctor/update-status".equals(path)) {
            try {
                int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
                String statusStr = request.getParameter("status");
                Appointment.Status status = Appointment.Status.valueOf(statusStr.toUpperCase());

                appointmentService.updateAppointmentStatus(appointmentId, status);
                response.sendRedirect(request.getContextPath() + "/doctor-dashboard.jsp?status=updated");
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/doctor-dashboard.jsp?error=update_failed");
            }
        } else if ("/doctor/prescribe".equals(path)) {
            try {
                int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
                int patientId = Integer.parseInt(request.getParameter("patientId"));
                int doctorId = 1;
                String diagnosis = request.getParameter("diagnosis");
                String medicines = request.getParameter("medicines");
                String tests = request.getParameter("tests");
                String notes = request.getParameter("notes");
                String followUpStr = request.getParameter("followUpDate");

                LocalDate followUp = DateUtil.parseIndianDate(followUpStr);

                appointmentService.issuePrescription(appointmentId, patientId, doctorId, diagnosis, medicines, tests, notes, followUp);
                appointmentService.updateAppointmentStatus(appointmentId, Appointment.Status.COMPLETED);

                response.sendRedirect(request.getContextPath() + "/doctor-dashboard.jsp?status=prescribed");
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/doctor-dashboard.jsp?error=prescribe_failed");
            }
        }
    }
}
