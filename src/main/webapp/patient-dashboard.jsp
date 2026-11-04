<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bytenova.care.model.Appointment" %>
<%@ page import="com.bytenova.care.model.Prescription" %>
<%@ page import="com.bytenova.care.model.Doctor" %>
<%@ page import="com.bytenova.care.model.Department" %>
<%@ page import="com.bytenova.care.dao.AppointmentDao" %>
<%@ page import="com.bytenova.care.dao.PrescriptionDao" %>
<%@ page import="com.bytenova.care.dao.DoctorDao" %>
<%@ page import="com.bytenova.care.dao.DepartmentDao" %>
<%@ page import="com.bytenova.care.util.DateUtil" %>
<%
    request.setAttribute("pageTitle", "Patient Dashboard – ByteNova Care");
    List<Appointment> appointments = AppointmentDao.getFallbackAppointments();
    List<Prescription> prescriptions = PrescriptionDao.getFallbackPrescriptions();
    List<Doctor> doctors = DoctorDao.getFallbackDoctors();
    List<Department> departments = DepartmentDao.getFallbackDepartments();
%>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<!-- Dashboard Header / Brand Bar -->
<header class="site-header" style="background-color: #0B2545; border-bottom: 2px solid #0D9488;">
    <div class="container" style="max-width: 100%; padding: 10px 24px;">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <a href="${pageContext.request.contextPath}/index.jsp" class="brand-logo">
                <div class="logo-icon-box" style="background-color: #133E87;">✚</div>
                <div class="brand-text">
                    <div class="brand-name" style="color: #FFFFFF;">ByteNova <span style="color: #5EEAD4;">Care</span></div>
                    <div class="brand-subtitle" style="color: #94A3B8;">Patient Outpatient Portal</div>
                </div>
            </a>

            <div style="display: flex; align-items: center; gap: 16px;">
                <span class="badge badge-active" style="padding: 6px 12px; font-size: 0.8rem;">
                    UHID: BNC-2026-0842
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
                <div class="user-avatar-sm">RV</div>
                <div class="info">
                    <h5>Rahul Verma</h5>
                    <span>Age: 30 yrs | Male</span>
                </div>
            </div>
        </div>

        <ul class="dash-nav-menu">
            <li class="dash-nav-item">
                <a class="dash-nav-link active" onclick="switchDashTab('pane-appointments', this)">
                    📅 My Appointments
                </a>
            </li>
            <li class="dash-nav-item">
                <a class="dash-nav-link" onclick="switchDashTab('pane-prescriptions', this)">
                    💊 My Prescriptions
                </a>
            </li>
            <li class="dash-nav-item">
                <a class="dash-nav-link" onclick="switchDashTab('pane-profile', this)">
                    👤 Health Profile
                </a>
            </li>
            <li class="dash-nav-item" style="margin-top: 15px;">
                <a class="dash-nav-link" href="${pageContext.request.contextPath}/index.jsp">
                    🌐 Hospital Website
                </a>
            </li>
        </ul>

        <div class="dash-sidebar-footer">
            <button type="button" class="btn btn-teal btn-block btn-sm" onclick="openModal('bookApptModal')">
                + Book New OPD
            </button>
        </div>
    </aside>

    <!-- Main Content Area -->
    <main class="dash-content">
        <!-- Top Title & Welcome -->
        <div class="dash-topbar">
            <div class="dash-page-title">
                <h2>Namaste, Rahul Verma 👋</h2>
                <p>Track your doctor appointments, digital OPD tokens, and electronic prescriptions</p>
            </div>
            <div class="dash-actions">
                <button type="button" class="btn btn-teal" onclick="openModal('bookApptModal')">
                    + Book Appointment
                </button>
            </div>
        </div>

        <!-- Stat Cards -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-info">
                    <h6>Upcoming Visits</h6>
                    <div class="stat-value">2</div>
                    <div class="stat-sub">Confirmed OPD bookings</div>
                </div>
                <div class="stat-icon">📅</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h6>Active Prescriptions</h6>
                    <div class="stat-value">1</div>
                    <div class="stat-sub">Valid until 09-11-2026</div>
                </div>
                <div class="stat-icon">💊</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h6>Registered UHID</h6>
                    <div class="stat-value" style="font-size: 1.15rem;">BNC-2026-0842</div>
                    <div class="stat-sub">Ayushman Bharat Ready</div>
                </div>
                <div class="stat-icon">🪪</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h6>Blood Group</h6>
                    <div class="stat-value">B+</div>
                    <div class="stat-sub">Donor registered</div>
                </div>
                <div class="stat-icon">🩸</div>
            </div>
        </div>

        <!-- Tab 1: Appointments List -->
        <div id="pane-appointments" class="dash-tab-pane">
            <div class="panel-card">
                <div class="panel-header">
                    <h3>My Outpatient (OPD) Appointments</h3>
                    <span style="font-size: 0.82rem; color: var(--color-text-muted);">
                        Showing current and previous visits
                    </span>
                </div>
                <div class="table-responsive">
                    <table class="custom-table">
                        <thead>
                            <tr>
                                <th>Token / ID</th>
                                <th>Appointment Date</th>
                                <th>Doctor Name</th>
                                <th>Department</th>
                                <th>Time Slot</th>
                                <th>Fee (₹)</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Appointment a : appointments) { %>
                            <tr>
                                <td>
                                    <span class="token-pill">Token #<%= a.getTokenNumber() %></span>
                                    <div style="font-size: 0.72rem; color: var(--color-text-muted); margin-top: 2px;">
                                        <%= a.getAppointmentNumber() %>
                                    </div>
                                </td>
                                <td>
                                    <strong><%= DateUtil.formatIndianDate(a.getAppointmentDate()) %></strong>
                                </td>
                                <td>
                                    <strong><%= a.getDoctorName() %></strong>
                                </td>
                                <td><%= a.getDepartmentName() %></td>
                                <td><%= a.getTimeSlot() %></td>
                                <td>
                                    ₹<%= a.getFeeAmount() %>
                                    <div style="font-size: 0.72rem; color: <%= a.getFeeStatus() == Appointment.FeeStatus.PAID ? "var(--color-success)" : "var(--color-warning)" %>;">
                                        <%= a.getFeeStatus() == Appointment.FeeStatus.PAID ? "Paid" : "Pay at Counter" %>
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
                                    <button type="button" class="btn btn-outline btn-sm" onclick="alert('Appointment Details:\nNumber: <%= a.getAppointmentNumber() %>\nDoctor: <%= a.getDoctorName() %>\nDate: <%= DateUtil.formatIndianDate(a.getAppointmentDate()) %>\nSlot: <%= a.getTimeSlot() %>\nToken: <%= a.getTokenNumber() %>\nPlease report 15 mins prior at OPD Room.')">
                                        View Slip
                                    </button>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Tab 2: Prescriptions -->
        <div id="pane-prescriptions" class="dash-tab-pane" style="display: none;">
            <div class="panel-card">
                <div class="panel-header">
                    <h3>Doctor Electronic Prescriptions (Rx)</h3>
                    <span style="font-size: 0.82rem; color: var(--color-text-muted);">
                        Digital medical advice &amp; dosages
                    </span>
                </div>
                <div class="panel-body">
                    <% for (Prescription p : prescriptions) { %>
                    <div class="prescription-item" id="rx-<%= p.getId() %>">
                        <div class="rx-header">
                            <div class="rx-doc-info">
                                <strong><%= p.getDoctorName() %></strong>
                                <span><%= p.getDoctorQualification() %> | <%= p.getDepartmentName() %></span>
                            </div>
                            <div style="text-align: right; font-size: 0.82rem;">
                                <div><strong>Date:</strong> 04-11-2026</div>
                                <div style="color: var(--color-text-muted);">UHID: <%= p.getPatientUhid() %></div>
                            </div>
                        </div>

                        <div style="margin-bottom: 12px; font-size: 0.9rem;">
                            <strong>Diagnosis:</strong> <span style="color: var(--color-navy);"><%= p.getDiagnosis() %></span>
                        </div>

                        <div class="rx-body" style="margin-bottom: 14px;">
                            <strong style="font-size: 0.85rem; color: var(--color-teal); display: block; margin-bottom: 6px;">
                                Prescribed Medications (Dosage &amp; Routine):
                            </strong>
                            <pre><%= p.getMedicines() %></pre>
                        </div>

                        <% if (p.getTestsRecommended() != null) { %>
                        <div style="font-size: 0.85rem; margin-bottom: 8px;">
                            <strong>Recommended Diagnostics / Tests:</strong> <%= p.getTestsRecommended() %>
                        </div>
                        <% } %>

                        <% if (p.getDoctorNotes() != null) { %>
                        <div style="font-size: 0.85rem; margin-bottom: 8px; color: var(--color-text-muted);">
                            <strong>Clinical Notes:</strong> <%= p.getDoctorNotes() %>
                        </div>
                        <% } %>

                        <div style="margin-top: 14px; padding-top: 10px; border-top: 1px solid var(--color-border); display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 10px;">
                            <div style="font-size: 0.82rem; color: var(--color-teal); font-weight: 600;">
                                Follow-up Visit: <%= DateUtil.formatIndianDate(p.getFollowUpDate()) %>
                            </div>
                            <button type="button" class="btn btn-outline btn-sm" onclick="printPrescription('rx-<%= p.getId() %>')">
                                🖨 Print / Save Prescription
                            </button>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Tab 3: Health Profile -->
        <div id="pane-profile" class="dash-tab-pane" style="display: none;">
            <div class="panel-card">
                <div class="panel-header">
                    <h3>Patient Demographics &amp; Health Profile</h3>
                </div>
                <div class="panel-body">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Unique Health ID (UHID)</label>
                            <input type="text" class="form-control" value="BNC-2026-0842" readonly style="background-color: #F1F5F9; font-weight: 700;">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" value="Rahul Verma" readonly style="background-color: #F1F5F9;">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Registered Mobile Number</label>
                            <input type="text" class="form-control" value="+91 98765 43210" readonly style="background-color: #F1F5F9;">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email Address</label>
                            <input type="text" class="form-control" value="rahul.verma@gmail.com" readonly style="background-color: #F1F5F9;">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Date of Birth</label>
                            <input type="text" class="form-control" value="15-07-1996 (Age: 30)" readonly style="background-color: #F1F5F9;">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Blood Group</label>
                            <input type="text" class="form-control" value="B+ (Positive)" readonly style="background-color: #F1F5F9;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Residential Address</label>
                        <input type="text" class="form-control" value="Flat 402, Mayur Vihar Phase 1, Delhi – 110091" readonly style="background-color: #F1F5F9;">
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Modal: Book OPD Appointment -->
<div class="modal-overlay" id="bookApptModal">
    <div class="modal-card">
        <div class="modal-header">
            <h4>Book OPD Consultation</h4>
            <button type="button" class="modal-close-btn" onclick="closeModal('bookApptModal')">&times;</button>
        </div>
        <form action="${pageContext.request.contextPath}/patient/book-appointment" method="POST" onsubmit="event.preventDefault(); alert('Appointment booked successfully! Your generated token is #6. You will receive an SMS confirmation.'); closeModal('bookApptModal'); location.reload();">
            <input type="hidden" name="patientName" value="Rahul Verma">
            <input type="hidden" name="uhid" value="BNC-2026-0842">

            <div class="modal-body">
                <div class="form-group">
                    <label class="form-label">Select Department <span class="required">*</span></label>
                    <select name="departmentId" id="modalDeptSelect" class="form-control" required>
                        <% for (Department d : departments) { %>
                        <option value="<%= d.getId() %>"><%= d.getName() %> (₹<%= d.getConsultationFee() %>)</option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label">Select Doctor <span class="required">*</span></label>
                    <select name="doctorId" id="modalDocSelect" class="form-control" required>
                        <% for (Doctor doc : doctors) { %>
                        <option value="<%= doc.getId() %>"><%= doc.getFullName() %> – <%= doc.getDepartmentName() %></option>
                        <% } %>
                    </select>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Preferred Date <span class="required">*</span></label>
                        <input type="date" name="appointmentDate" id="appointmentDate" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Time Slot <span class="required">*</span></label>
                        <select name="timeSlot" class="form-control" required>
                            <option>09:00 AM – 09:30 AM</option>
                            <option selected>10:00 AM – 10:30 AM</option>
                            <option>11:30 AM – 12:00 PM</option>
                            <option>04:30 PM – 05:00 PM</option>
                            <option>06:00 PM – 06:30 PM</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Symptoms / Reason for Visit</label>
                    <textarea name="symptoms" class="form-control" rows="3" placeholder="Describe symptoms e.g. mild headache, sore throat, blood pressure review..."></textarea>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-outline" onclick="closeModal('bookApptModal')">Cancel</button>
                <button type="submit" class="btn btn-teal">Confirm &amp; Generate Token &rarr;</button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
