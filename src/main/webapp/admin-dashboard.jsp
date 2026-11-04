<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bytenova.care.model.Doctor" %>
<%@ page import="com.bytenova.care.model.Patient" %>
<%@ page import="com.bytenova.care.model.Appointment" %>
<%@ page import="com.bytenova.care.dao.DoctorDao" %>
<%@ page import="com.bytenova.care.dao.PatientDao" %>
<%@ page import="com.bytenova.care.dao.AppointmentDao" %>
<%@ page import="com.bytenova.care.util.DateUtil" %>
<%
    request.setAttribute("pageTitle", "Hospital Administrator Console – ByteNova Care");
    List<Doctor> doctors = DoctorDao.getFallbackDoctors();
    List<Patient> patients = PatientDao.getFallbackPatients();
    List<Appointment> appointments = AppointmentDao.getFallbackAppointments();
%>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<!-- Admin Header Bar -->
<header class="site-header" style="background-color: #0B2545; border-bottom: 2px solid #0D9488;">
    <div class="container" style="max-width: 100%; padding: 10px 24px;">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <a href="${pageContext.request.contextPath}/index.jsp" class="brand-logo">
                <div class="logo-icon-box" style="background-color: #133E87;">✚</div>
                <div class="brand-text">
                    <div class="brand-name" style="color: #FFFFFF;">ByteNova <span style="color: #5EEAD4;">Care</span></div>
                    <div class="brand-subtitle" style="color: #94A3B8;">Hospital Management &amp; Admin Console</div>
                </div>
            </a>

            <div style="display: flex; align-items: center; gap: 16px;">
                <span class="badge badge-active" style="padding: 6px 12px; font-size: 0.8rem;">
                    Administrator Mode
                </span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-sm" style="color: #FFFFFF; border-color: rgba(255,255,255,0.2);">
                    Log Out
                </a>
            </div>
        </div>
    </div>
</header>

<div class="dashboard-wrapper">
    <!-- Sidebar -->
    <aside class="dash-sidebar">
        <div class="dash-sidebar-header">
            <div class="user-profile-badge">
                <div class="user-avatar-sm">AD</div>
                <div class="info">
                    <h5>Admin ByteNova</h5>
                    <span>Hospital Medical Supdt.</span>
                </div>
            </div>
        </div>

        <ul class="dash-nav-menu">
            <li class="dash-nav-item">
                <a class="dash-nav-link active" onclick="switchDashTab('pane-admin-doctors', this)">
                    👨‍⚕️ Manage Doctors (<%= doctors.size() %>)
                </a>
            </li>
            <li class="dash-nav-item">
                <a class="dash-nav-link" onclick="switchDashTab('pane-admin-patients', this)">
                    👥 Manage Patients (<%= patients.size() %>)
                </a>
            </li>
            <li class="dash-nav-item">
                <a class="dash-nav-link" onclick="switchDashTab('pane-admin-appointments', this)">
                    📅 Manage Appointments (<%= appointments.size() %>)
                </a>
            </li>
            <li class="dash-nav-item" style="margin-top: 15px;">
                <a class="dash-nav-link" href="${pageContext.request.contextPath}/index.jsp">
                    🌐 Hospital Public Site
                </a>
            </li>
        </ul>

        <div class="dash-sidebar-footer">
            <button type="button" class="btn btn-teal btn-block btn-sm" onclick="openModal('addDoctorModal')">
                + Add New Doctor
            </button>
        </div>
    </aside>

    <!-- Main Content Area -->
    <main class="dash-content">
        <!-- Top Title Bar -->
        <div class="dash-topbar">
            <div class="dash-page-title">
                <h2>Hospital Administration Overview</h2>
                <p>Real-time operational dashboard for ByteNova Care Community Hospital</p>
            </div>
            <div class="dash-actions">
                <button type="button" class="btn btn-teal" onclick="openModal('addDoctorModal')">
                    + Register Doctor
                </button>
            </div>
        </div>

        <!-- Stat KPI Cards -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-info">
                    <h6>Total Registered Patients</h6>
                    <div class="stat-value">1,248</div>
                    <div class="stat-sub">+14 registered today</div>
                </div>
                <div class="stat-icon">👥</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h6>Active Doctors</h6>
                    <div class="stat-value">18</div>
                    <div class="stat-sub">Across 6 Specialties</div>
                </div>
                <div class="stat-icon">👨‍⚕️</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h6>Today's OPD Bookings</h6>
                    <div class="stat-value">42</div>
                    <div class="stat-sub">31 completed | 11 waiting</div>
                </div>
                <div class="stat-icon">📋</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h6>OPD Fee Collection</h6>
                    <div class="stat-value">₹21,000</div>
                    <div class="stat-sub">Today's counter revenue</div>
                </div>
                <div class="stat-icon">💰</div>
            </div>
        </div>

        <!-- Tab 1: Manage Doctors -->
        <div id="pane-admin-doctors" class="dash-tab-pane">
            <div class="panel-card">
                <div class="panel-header">
                    <h3>Hospital Doctor Directory</h3>
                    <button type="button" class="btn btn-outline btn-sm" onclick="openModal('addDoctorModal')">
                        + New Doctor Entry
                    </button>
                </div>
                <div class="table-responsive">
                    <table class="custom-table">
                        <thead>
                            <tr>
                                <th>Doctor ID / Reg</th>
                                <th>Doctor Name</th>
                                <th>Specialty Department</th>
                                <th>Qualifications</th>
                                <th>OPD Room</th>
                                <th>OPD Timings</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Doctor doc : doctors) { %>
                            <tr>
                                <td>
                                    <strong>#DOC-<%= doc.getId() %></strong>
                                    <div style="font-size: 0.72rem; color: var(--color-text-muted);">
                                        <%= doc.getDoctorRegNo() %>
                                    </div>
                                </td>
                                <td>
                                    <strong><%= doc.getFullName() %></strong>
                                    <div style="font-size: 0.74rem; color: var(--color-text-muted);">
                                        <%= doc.getPhone() %>
                                    </div>
                                </td>
                                <td>
                                    <span style="color: var(--color-teal); font-weight: 600;">
                                        <%= doc.getDepartmentName() %>
                                    </span>
                                </td>
                                <td><%= doc.getQualification() %></td>
                                <td><%= doc.getOpdRoomNo() %></td>
                                <td><%= doc.getOpdTimings() %></td>
                                <td>
                                    <span class="badge badge-active">Available</span>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-outline btn-sm" onclick="alert('Doctor Details:\n<%= doc.getFullName() %>\nSpecialty: <%= doc.getDepartmentName() %>\nRoom: <%= doc.getOpdRoomNo() %>\nContact: <%= doc.getPhone() %>')">
                                        View
                                    </button>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Tab 2: Manage Patients -->
        <div id="pane-admin-patients" class="dash-tab-pane" style="display: none;">
            <div class="panel-card">
                <div class="panel-header">
                    <h3>Registered Patients Directory</h3>
                    <span style="font-size: 0.82rem; color: var(--color-text-muted);">
                        Searchable by UHID and Phone Number
                    </span>
                </div>
                <div class="table-responsive">
                    <table class="custom-table">
                        <thead>
                            <tr>
                                <th>UHID</th>
                                <th>Patient Name</th>
                                <th>Contact Number</th>
                                <th>Gender / Age</th>
                                <th>Blood Group</th>
                                <th>Registered Address</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Patient p : patients) { %>
                            <tr>
                                <td>
                                    <strong style="color: var(--color-navy); font-family: monospace;">
                                        <%= p.getUhid() %>
                                    </strong>
                                </td>
                                <td>
                                    <strong><%= p.getFullName() %></strong>
                                    <div style="font-size: 0.74rem; color: var(--color-text-muted);"><%= p.getEmail() %></div>
                                </td>
                                <td><%= p.getPhone() %></td>
                                <td><%= p.getGender() %></td>
                                <td>
                                    <span class="badge badge-active"><%= p.getBloodGroup() %></span>
                                </td>
                                <td style="max-width: 200px; font-size: 0.82rem; color: var(--color-text-muted);">
                                    <%= p.getAddress() %>
                                </td>
                                <td>
                                    <span class="badge badge-confirmed">Active</span>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-outline btn-sm" onclick="alert('Patient Health Summary:\nUHID: <%= p.getUhid() %>\nName: <%= p.getFullName() %>\nPhone: <%= p.getPhone() %>\nBlood Group: <%= p.getBloodGroup() %>\nEmergency Contact: <%= p.getEmergencyContact() %>')">
                                        View Profile
                                    </button>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Tab 3: Manage Appointments -->
        <div id="pane-admin-appointments" class="dash-tab-pane" style="display: none;">
            <div class="panel-card">
                <div class="panel-header">
                    <h3>All Hospital OPD Appointments</h3>
                    <span style="font-size: 0.82rem; color: var(--color-text-muted);">
                        Centralized hospital booking control
                    </span>
                </div>
                <div class="table-responsive">
                    <table class="custom-table">
                        <thead>
                            <tr>
                                <th>Booking ID</th>
                                <th>Patient Name (UHID)</th>
                                <th>Doctor Name</th>
                                <th>Department</th>
                                <th>Date &amp; Slot</th>
                                <th>Token</th>
                                <th>Fee &amp; Payment</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Appointment a : appointments) { %>
                            <tr>
                                <td>
                                    <strong><%= a.getAppointmentNumber() %></strong>
                                </td>
                                <td>
                                    <strong><%= a.getPatientName() %></strong>
                                    <div style="font-size: 0.72rem; color: var(--color-text-muted); font-family: monospace;">
                                        <%= a.getPatientUhid() %>
                                    </div>
                                </td>
                                <td><%= a.getDoctorName() %></td>
                                <td><%= a.getDepartmentName() %></td>
                                <td>
                                    <div><strong><%= DateUtil.formatIndianDate(a.getAppointmentDate()) %></strong></div>
                                    <div style="font-size: 0.75rem; color: var(--color-text-muted);"><%= a.getTimeSlot() %></div>
                                </td>
                                <td>
                                    <span class="token-pill">#<%= a.getTokenNumber() %></span>
                                </td>
                                <td>
                                    ₹<%= a.getFeeAmount() %>
                                    <div style="font-size: 0.72rem; color: <%= a.getFeeStatus() == Appointment.FeeStatus.PAID ? "var(--color-success)" : "var(--color-warning)" %>;">
                                        <%= a.getFeeStatus() == Appointment.FeeStatus.PAID ? "Paid" : "Pending Counter" %>
                                    </div>
                                </td>
                                <td>
                                    <% if (a.getStatus() == Appointment.Status.CONFIRMED) { %>
                                        <span class="badge badge-confirmed">Confirmed</span>
                                    <% } else if (a.getStatus() == Appointment.Status.PENDING) { %>
                                        <span class="badge badge-pending">Pending</span>
                                    <% } else if (a.getStatus() == Appointment.Status.COMPLETED) { %>
                                        <span class="badge badge-completed">Completed</span>
                                    <% } else { %>
                                        <span class="badge badge-cancelled">Cancelled</span>
                                    <% } %>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-outline btn-sm" onclick="alert('Appointment Record:\nID: <%= a.getAppointmentNumber() %>\nPatient: <%= a.getPatientName() %>\nDoctor: <%= a.getDoctorName() %>\nStatus: <%= a.getStatus() %>')">
                                        Audit
                                    </button>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Modal: Add New Doctor -->
<div class="modal-overlay" id="addDoctorModal">
    <div class="modal-card">
        <div class="modal-header">
            <h4>Register New Medical Faculty</h4>
            <button type="button" class="modal-close-btn" onclick="closeModal('addDoctorModal')">&times;</button>
        </div>
        <form onsubmit="event.preventDefault(); alert('Doctor registered successfully and added to the hospital OPD schedule!'); closeModal('addDoctorModal'); location.reload();">
            <div class="modal-body">
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Doctor Full Name <span class="required">*</span></label>
                        <input type="text" class="form-control" placeholder="e.g. Dr. Kavita Deshmukh" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">MCI / State Council Reg No <span class="required">*</span></label>
                        <input type="text" class="form-control" placeholder="e.g. MMC-2018-49201" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Department Specialty <span class="required">*</span></label>
                        <select class="form-control" required>
                            <option>General Medicine &amp; OPD</option>
                            <option>Paediatrics &amp; Child Health</option>
                            <option>Obstetrics &amp; Gynaecology</option>
                            <option>Orthopaedics &amp; Joint Care</option>
                            <option>Cardiology &amp; Heart Care</option>
                            <option>Diagnostic Pathology &amp; Lab</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Medical Qualifications <span class="required">*</span></label>
                        <input type="text" class="form-control" placeholder="e.g. MBBS, MD, DNB" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Mobile Number <span class="required">*</span></label>
                        <input type="tel" class="form-control" placeholder="10-digit mobile" pattern="[6-9][0-9]{9}" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Official Email <span class="required">*</span></label>
                        <input type="email" class="form-control" placeholder="doctor@bytenovacare.in" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Assigned OPD Room <span class="required">*</span></label>
                        <input type="text" class="form-control" placeholder="e.g. OPD Room 112" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">OPD Timings <span class="required">*</span></label>
                        <input type="text" class="form-control" placeholder="e.g. Mon-Sat: 09:00 AM - 01:00 PM" required>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-outline" onclick="closeModal('addDoctorModal')">Cancel</button>
                <button type="submit" class="btn btn-teal">Add Doctor &rarr;</button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
