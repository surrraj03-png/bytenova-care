package com.bytenova.care.service;

import com.bytenova.care.dao.AppointmentDao;
import com.bytenova.care.dao.DepartmentDao;
import com.bytenova.care.dao.DoctorDao;
import com.bytenova.care.dao.PrescriptionDao;
import com.bytenova.care.model.Appointment;
import com.bytenova.care.model.Department;
import com.bytenova.care.model.Doctor;
import com.bytenova.care.model.Prescription;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Random;

/**
 * Service managing appointment scheduling, status updates, and prescription history.
 * ByteNova Care – Team ByteNova
 */
public class AppointmentService {

    private final AppointmentDao appointmentDao = new AppointmentDao();
    private final DoctorDao doctorDao = new DoctorDao();
    private final DepartmentDao departmentDao = new DepartmentDao();
    private final PrescriptionDao prescriptionDao = new PrescriptionDao();

    public List<Appointment> getAllAppointments() {
        return appointmentDao.findAll();
    }

    public List<Appointment> getPatientAppointments(int patientId) {
        return appointmentDao.findByPatientId(patientId);
    }

    public List<Appointment> getDoctorTodayAppointments(int doctorId) {
        return appointmentDao.findTodayAppointmentsByDoctor(doctorId);
    }

    public List<Prescription> getPatientPrescriptions(int patientId) {
        return prescriptionDao.findByPatientId(patientId);
    }

    public Appointment bookAppointment(int patientId, String patientName, String patientUhid,
                                       int doctorId, int departmentId, LocalDate date, 
                                       String timeSlot, String symptoms) {
        Doctor doctor = doctorDao.findById(doctorId);
        Department dept = departmentDao.findById(departmentId);

        Appointment appt = new Appointment();
        String datePart = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        appt.setAppointmentNumber("APT-" + datePart + "-" + String.format("%03d", new Random().nextInt(900) + 100));
        appt.setPatientId(patientId);
        appt.setPatientName(patientName);
        appt.setPatientUhid(patientUhid);
        appt.setDoctorId(doctorId);
        appt.setDoctorName(doctor != null ? doctor.getFullName() : "Dr. Rajesh Sharma");
        appt.setDepartmentId(departmentId);
        appt.setDepartmentName(dept != null ? dept.getName() : "General Medicine & OPD");
        appt.setAppointmentDate(date != null ? date : LocalDate.now().plusDays(1));
        appt.setTimeSlot(timeSlot != null ? timeSlot : "10:00 AM - 10:30 AM");
        appt.setTokenNumber(new Random().nextInt(15) + 1);
        appt.setSymptoms(symptoms);
        appt.setFeeAmount(dept != null ? dept.getConsultationFee() : new BigDecimal("500.00"));
        appt.setFeeStatus(Appointment.FeeStatus.PENDING_AT_COUNTER);
        appt.setStatus(Appointment.Status.CONFIRMED);

        appointmentDao.save(appt);
        return appt;
    }

    public boolean updateAppointmentStatus(int appointmentId, Appointment.Status status) {
        return appointmentDao.updateStatus(appointmentId, status);
    }

    public boolean issuePrescription(int appointmentId, int patientId, int doctorId,
                                     String diagnosis, String medicines, String tests, 
                                     String notes, LocalDate followUpDate) {
        Prescription p = new Prescription();
        p.setAppointmentId(appointmentId);
        p.setPatientId(patientId);
        p.setDoctorId(doctorId);
        p.setDiagnosis(diagnosis);
        p.setMedicines(medicines);
        p.setTestsRecommended(tests);
        p.setDoctorNotes(notes);
        p.setFollowUpDate(followUpDate);
        return prescriptionDao.save(p) > 0;
    }
}
