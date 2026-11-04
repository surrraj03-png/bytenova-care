<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bytenova.care.model.Appointment" %>
<%@ page import="com.bytenova.care.model.Doctor" %>
<%@ page import="com.bytenova.care.dao.AppointmentDao" %>
<%@ page import="com.bytenova.care.dao.DoctorDao" %>
<%@ page import="com.bytenova.care.util.DateUtil" %>
<%
    request.setAttribute("pageTitle", "Doctor OPD Console – ByteNova Care");
    List<Appointment> todayQueue = AppointmentDao.getFallbackTodayDoctorAppointments();
    Doctor doc = DoctorDao.getFallbackDoctors().get(0); // Dr. Rajesh Sharma
%>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<!-- Doctor Header Bar -->
<header class="site-header" style="background-color: #0B2545; border-bottom: 2px solid #0D9488;">
    <div class="container" style="max-width: 100%; padding: 10px 24px;">
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <a href="${pageContext.request.contextPath}/index.jsp" class="brand-logo">
                <div class="logo-icon-box" style="background-color: #133E87;">✚</div>
                <div class="brand-text">
                    <div class="brand-name" style="color: #FFFFFF;">ByteNova <span style="color: #5EEAD4;">Care</span></div>
                    <div class="brand-subtitle" style="color: #94A3B8;">Doctor Clinical OPD Console</div>
                </div>
            </a>

            <div style="display: flex; align-items: center; gap: 16px;">
                <span class="badge badge-active" style="padding: 6px 12px; font-size: 0.8rem;">
                    <%= doc.getOpdRoomNo() %> | Reg: <%= doc.getDoctorRegNo() %>
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
                <div class="user-avatar-sm">RS</div>
                <div class="info">
                    <h5><%= doc.getFullName() %></h5>
                    <span><%= doc.getQualification() %></span>
                </div>
            </div>
        </div>

        <ul class="dash-nav-menu">
            <li class="dash-nav-item">
                <a class="dash-nav-link active" onclick="switchDashTab('pane-doctor-queue', this)">
                    📋 Today's OPD Queue
                </a>
            </li>
            <li class="dash-nav-item">
                <a class="dash-nav-link" onclick="switchDashTab('pane-doctor-profile', this)">
                    👨‍⚕️ Clinical Profile
                </a>
            </li>
            <li class="dash-nav-item" style="margin-top: 15px;">
                <a class="dash-nav-link" href="${pageContext.request.contextPath}/index.jsp">
                    🌐 Hospital Website
                </a>
            </li>
        </ul>

        <div class="dash-sidebar-footer">
            <div style="font-size: 0.78rem; color: #94A3B8; text-align: center;">
                Duty Hours: 09:00 AM – 01:00 PM<br>
                Status: <span style="color: #5EEAD4; font-weight: 600;">ACTIVE IN OPD</span>
            </div>
        </div>
    </aside>

    <!-- Main Content Area -->
    <main class="dash-content">
        <!-- Top Title Bar -->
        <div class="dash-topbar">
            <div class="dash-page-title">
                <h2>OPD Clinic Session – <%= doc.getDepartmentName() %></h2>
                <p>Date: <%= DateUtil.formatIndianDate(java.time.LocalDate.now()) %> | Room: <%= doc.getOpdRoomNo() %></p>
            </div>
            <div class="dash-actions">
                <button type="button" class="btn btn-teal" onclick="alert('Queue refreshed with latest OPD tokens.')">
                    🔄 Refresh OPD Queue
                </button>
            </div>
        </div>

        <!-- Stat Cards -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-info">
                    <h6>Total Bookings Today</h6>
                    <div class="stat-value">8</div>
                    <div class="stat-sub">Registered OPD tokens</div>
                </div>
                <div class="stat-icon">👥</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h6>Consulted Patients</h6>
                    <div class="stat-value">5</div>
                    <div class="stat-sub">Completed &amp; Prescribed</div>
                </div>
                <div class="stat-icon">✔</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h6>Waiting in Lounge</h6>
                    <div class="stat-value">3</div>
                    <div class="stat-sub">Next Token: #2</div>
                </div>
                <div class="stat-icon">⏳</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h6>Average Consultation</h6>
                    <div class="stat-value">12 min</div>
                    <div class="stat-sub">Per patient session</div>
                </div>
                <div class="stat-icon">⏱</div>
            </div>
        </div>

        <!-- Tab 1: Doctor Today Queue -->
        <div id="pane-doctor-queue" class="dash-tab-pane">
            <div class="panel-card">
                <div class="panel-header">
                    <h3>Today's Patient Queue (Live OPD Sequence)</h3>
                    <span style="font-size: 0.82rem; color: var(--color-text-muted);">
                        Sorted by token number
                    </span>
                </div>
                <div class="table-responsive">
                    <table class="custom-table">
                        <thead>
                            <tr>
                                <th>Token</th>
                                <th>Patient Name</th>
                                <th>UHID</th>
                                <th>Slot</th>
                                <th>Chief Complaint / Symptoms</th>
                                <th>Status</th>
                                <th>Clinical Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Appointment appt : todayQueue) { %>
                            <tr>
                                <td>
                                    <span class="token-pill">Token #<%= appt.getTokenNumber() %></span>
                                </td>
                                <td>
                                    <strong><%= appt.getPatientName() %></strong>
                                </td>
                                <td>
                                    <span style="font-family: monospace; font-size: 0.82rem; color: var(--color-navy);">
                                        <%= appt.getPatientUhid() %>
                                    </span>
                                </td>
                                <td><%= appt.getTimeSlot() %></td>
                                <td>
                                    <span style="font-size: 0.85rem; color: #334155;">
                                        <%= appt.getSymptoms() %>
                                    </span>
                                </td>
                                <td>
                                    <% if (appt.getStatus() == Appointment.Status.COMPLETED) { %>
                                        <span class="badge badge-completed">Completed</span>
                                    <% } else if (appt.getStatus() == Appointment.Status.CONFIRMED) { %>
                                        <span class="badge badge-pending">Waiting</span>
                                    <% } else { %>
                                        <span class="badge badge-active">In Consultation</span>
                                    <% } %>
                                </td>
                                <td>
                                    <div style="display: flex; gap: 6px;">
                                        <% if (appt.getStatus() != Appointment.Status.COMPLETED) { %>
                                        <button type="button" class="btn btn-teal btn-sm" onclick="setupDoctorPrescribe('<%= appt.getId() %>', '<%= appt.getPatientName() %>', '<%= appt.getPatientId() %>', '<%= appt.getPatientUhid() %>', '<%= appt.getSymptoms() %>')">
                                            ✍ Write Rx
                                        </button>
                                        <button type="button" class="btn btn-outline btn-sm" onclick="alert('Calling Token #<%= appt.getTokenNumber() %>: <%= appt.getPatientName() %> to Room 101.')">
                                            Call
                                        </button>
                                        <% } else { %>
                                        <span style="font-size: 0.78rem; color: var(--color-success); font-weight: 600;">
                                            Prescribed ✔
                                        </span>
                                        <% } %>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Tab 2: Doctor Profile -->
        <div id="pane-doctor-profile" class="dash-tab-pane" style="display: none;">
            <div class="panel-card">
                <div class="panel-header">
                    <h3>Doctor Profile &amp; Hospital Credentials</h3>
                </div>
                <div class="panel-body">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Doctor Full Name</label>
                            <input type="text" class="form-control" value="<%= doc.getFullName() %>" readonly style="background-color: #F1F5F9;">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Medical Council Registration No</label>
                            <input type="text" class="form-control" value="<%= doc.getDoctorRegNo() %>" readonly style="background-color: #F1F5F9; font-weight: 700;">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Department / Specialty</label>
                            <input type="text" class="form-control" value="<%= doc.getDepartmentName() %>" readonly style="background-color: #F1F5F9;">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Medical Qualifications</label>
                            <input type="text" class="form-control" value="<%= doc.getQualification() %>" readonly style="background-color: #F1F5F9;">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Assigned OPD Room</label>
                            <input type="text" class="form-control" value="<%= doc.getOpdRoomNo() %>" readonly style="background-color: #F1F5F9;">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Clinical Experience</label>
                            <input type="text" class="form-control" value="<%= doc.getExperienceYears() %> Years of Active Practice" readonly style="background-color: #F1F5F9;">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">OPD Timing Schedule</label>
                        <input type="text" class="form-control" value="<%= doc.getOpdTimings() %>" readonly style="background-color: #F1F5F9;">
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Modal: Write Prescription -->
<div class="modal-overlay" id="prescribeModal">
    <div class="modal-card">
        <div class="modal-header">
            <h4>Clinical E-Prescription (Rx)</h4>
            <button type="button" class="modal-close-btn" onclick="closeModal('prescribeModal')">&times;</button>
        </div>
        <form action="${pageContext.request.contextPath}/doctor/prescribe" method="POST" onsubmit="event.preventDefault(); alert('Prescription issued successfully! Patient can view it on their portal.'); closeModal('prescribeModal'); location.reload();">
            <input type="hidden" name="appointmentId" id="prescribeApptId" value="">
            <input type="hidden" name="patientId" id="prescribePatientId" value="">

            <div class="modal-body">
                <div style="background-color: #F8FAFC; border: 1px solid var(--color-border); padding: 12px; border-radius: var(--radius-md); margin-bottom: 16px;">
                    <div style="font-size: 0.84rem; color: var(--color-text-muted);">Patient Details:</div>
                    <div style="font-size: 0.96rem; font-weight: 700; color: var(--color-navy);" id="modalPatientName">
                        Patient Name
                    </div>
                    <div style="font-size: 0.82rem; color: #475569; margin-top: 4px;">
                        Reported Symptoms: <span id="modalPatientSymptoms" style="font-weight: 500;"></span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Clinical Diagnosis <span class="required">*</span></label>
                    <input type="text" name="diagnosis" class="form-control" placeholder="e.g. Acute Gastritis / Viral Pyrexia / Lumbar Spondylosis" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Medicines &amp; Dosage (Standard Indian Schedule) <span class="required">*</span></label>
                    <textarea name="medicines" class="form-control" rows="4" placeholder="1. Tab Pan-40mg - 1-0-0 empty stomach 5 days&#10;2. Tab Dolo 650mg - 1-0-1 SOS after food&#10;3. Syp Gelusil - 2 tsp thrice daily" required></textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">Recommended Lab Tests / Diagnostics</label>
                    <input type="text" name="tests" class="form-control" placeholder="e.g. CBC, Serum Creatinine, Ultrasound Abdomen">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Next Follow-Up Date</label>
                        <input type="date" name="followUpDate" class="form-control">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Dietary &amp; Rest Advice</label>
                        <input type="text" name="notes" class="form-control" placeholder="e.g. Light bland diet, avoid spices, adequate hydration">
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-outline" onclick="closeModal('prescribeModal')">Cancel</button>
                <button type="submit" class="btn btn-teal">Sign &amp; Issue Prescription &rarr;</button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
