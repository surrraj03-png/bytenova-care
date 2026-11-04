<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.bytenova.care.model.Doctor" %>
<%@ page import="com.bytenova.care.model.Department" %>
<%@ page import="com.bytenova.care.dao.DoctorDao" %>
<%@ page import="com.bytenova.care.dao.DepartmentDao" %>
<%
    request.setAttribute("pageTitle", "ByteNova Care – Smart Healthcare. Better Care.");
    List<Doctor> doctors = DoctorDao.getFallbackDoctors();
    List<Department> departments = DepartmentDao.getFallbackDepartments();
%>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<!-- Hero Section -->
<section class="hero-section" id="home">
    <div class="container">
        <div class="hero-grid">
            <div class="hero-content">
                <div class="hero-badge">
                    <span>★</span> Indian Healthcare Management System
                </div>
                <h1 class="hero-title">
                    Smart Healthcare. <span>Better Care.</span>
                </h1>
                <p class="hero-lead">
                    Welcome to <strong>ByteNova Care</strong> — an accessible, paperless hospital management platform designed for OPD clinics, primary healthcare centers, and multi-specialty community hospitals across India.
                </p>
                <div class="hero-cta-group">
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-teal btn-lg">
                        Book OPD Appointment
                    </a>
                    <a href="#services" class="btn btn-outline btn-lg">
                        Explore Specialties
                    </a>
                </div>

                <div class="hero-highlights">
                    <div class="hero-highlight-item">
                        <h4>₹400</h4>
                        <p>Affordable OPD Consultation from</p>
                    </div>
                    <div class="hero-highlight-item">
                        <h4>100%</h4>
                        <p>Paperless Digital Prescriptions</p>
                    </div>
                    <div class="hero-highlight-item">
                        <h4>24x7</h4>
                        <p>Emergency &amp; Trauma Support</p>
                    </div>
                </div>
            </div>

            <!-- Hero Quick Info Card -->
            <div class="hero-card-col">
                <div class="hero-quick-card">
                    <div class="quick-card-header">
                        <h3>Hospital OPD Timings</h3>
                        <p>Walk-in OPD &amp; Online Appointment Schedule</p>
                    </div>

                    <div class="timing-row">
                        <span class="label">Morning OPD:</span>
                        <span class="val">08:30 AM – 01:30 PM</span>
                    </div>
                    <div class="timing-row">
                        <span class="label">Evening OPD:</span>
                        <span class="val">04:30 PM – 08:00 PM</span>
                    </div>
                    <div class="timing-row">
                        <span class="label">Sunday Emergency:</span>
                        <span class="val">24 Hours (Casualty Only)</span>
                    </div>
                    <div class="timing-row">
                        <span class="label">Pathology Lab:</span>
                        <span class="val">07:00 AM – 09:00 PM</span>
                    </div>
                    <div class="timing-row">
                        <span class="label">Digital Health ID:</span>
                        <span class="val">ABHA / UHID Integrated</span>
                    </div>

                    <div class="emergency-strip">
                        <div>
                            <div style="font-size: 0.78rem; text-transform: uppercase; color: #991B1B; font-weight: 700;">
                                Emergency Casualty Line
                            </div>
                            <div class="phone">108 / +91 11-2659-8800</div>
                        </div>
                    </div>

                    <div style="margin-top: 18px;">
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary btn-block">
                            Access Patient / Doctor Portal &rarr;
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- About Section -->
<section class="section" id="about">
    <div class="container">
        <div class="about-grid">
            <div class="about-text">
                <span class="section-tagline">About ByteNova Care</span>
                <h3 class="section-title">Bridging Patients, Clinicians and Quality Healthcare</h3>
                <p>
                    ByteNova Care is built to solve everyday OPD congestion and lost medical files in Indian healthcare facilities. We bring simplicity, transparent pricing, and instant digital token allocation to outpatient departments.
                </p>
                <p>
                    Designed by students of Computer Science and Engineering for university evaluation and hackathon innovation, this project demonstrates real-world application of Java Servlet architecture, JDBC transaction safety, and clean human-centered UI.
                </p>

                <ul class="features-list">
                    <li>
                        <span class="bullet">✔</span>
                        <div><strong>Unique Health Identifier (UHID):</strong> Permanent digital identity for every patient to track multi-department treatment history.</div>
                    </li>
                    <li>
                        <span class="bullet">✔</span>
                        <div><strong>Transparent Pricing in ₹:</strong> Clearly published OPD consultation fees without hidden hospital charges.</div>
                    </li>
                    <li>
                        <span class="bullet">✔</span>
                        <div><strong>Standardized E-Prescriptions:</strong> Legible, structured medication dosages formatted for Indian pharmacy standards.</div>
                    </li>
                </ul>
            </div>

            <div class="about-card-box">
                <h4 style="color: var(--color-navy); font-size: 1.25rem; font-weight: 600; margin-bottom: 8px;">
                    Indian Healthcare Standards
                </h4>
                <p style="font-size: 0.9rem; color: var(--color-text-muted);">
                    Aligned with standard clinical workflows observed in Indian District Hospitals and Community Health Centres (CHCs).
                </p>

                <div class="about-stat-row">
                    <div class="stat-box">
                        <div class="num">18+</div>
                        <div class="txt">Senior Specialist Consultants</div>
                    </div>
                    <div class="stat-box">
                        <div class="num">6</div>
                        <div class="txt">Clinical OPD Specialties</div>
                    </div>
                    <div class="stat-box">
                        <div class="num">&lt; 15 min</div>
                        <div class="txt">Average OPD Queue Time</div>
                    </div>
                    <div class="stat-box">
                        <div class="num">100%</div>
                        <div class="txt">Secure Jakarta Servlet Stack</div>
                    </div>
                </div>

                <div style="margin-top: 24px; padding: 14px; background: #FFFFFF; border-radius: var(--radius-md); border: 1px solid var(--color-border); font-size: 0.84rem; color: var(--color-text-muted);">
                    <strong>Hackathon Note:</strong> Developed by Team ByteNova. Focused on accessibility, responsive typography, and authentic Indian healthcare data.
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Healthcare Services Section -->
<section class="section section-grey" id="services">
    <div class="container">
        <div class="section-header">
            <span class="section-tagline">Clinical Specialties</span>
            <h2 class="section-title">Comprehensive Healthcare Services</h2>
            <p class="section-desc">
                Dedicated outpatient and diagnostic services staffed by certified medical professionals adhering to standard Indian clinical protocols.
            </p>
        </div>

        <div class="services-grid">
            <!-- 1. General Medicine -->
            <div class="service-card">
                <div class="service-icon-box">🩺</div>
                <h3>General Medicine &amp; OPD</h3>
                <p>
                    Primary adult consultations, viral fevers (Dengue, Malaria, Typhoid), seasonal allergies, hypertension monitoring, and chronic disease checkups.
                </p>
                <div class="service-meta">
                    <span>OPD Consultation:</span>
                    <span class="service-fee">₹400</span>
                </div>
            </div>

            <!-- 2. Paediatrics -->
            <div class="service-card">
                <div class="service-icon-box">👶</div>
                <h3>Paediatrics &amp; Child Health</h3>
                <p>
                    Neonatal care, comprehensive pediatric wellness, UIP (Universal Immunisation Programme) vaccine schedules, and child developmental screening.
                </p>
                <div class="service-meta">
                    <span>OPD Consultation:</span>
                    <span class="service-fee">₹500</span>
                </div>
            </div>

            <!-- 3. Obstetrics & Gynaecology -->
            <div class="service-card">
                <div class="service-icon-box">🤰</div>
                <h3>Obstetrics &amp; Gynaecology</h3>
                <p>
                    Antenatal maternal checkups, trimester anomaly scan reviews, PCOS/PCOD management, adolescent health, and safe post-natal wellness counseling.
                </p>
                <div class="service-meta">
                    <span>OPD Consultation:</span>
                    <span class="service-fee">₹600</span>
                </div>
            </div>

            <!-- 4. Orthopaedics -->
            <div class="service-card">
                <div class="service-icon-box">🦴</div>
                <h3>Orthopaedics &amp; Joint Care</h3>
                <p>
                    Evaluation of bone fractures, degenerative arthritis, cervical spondylosis, post-trauma recovery, and non-invasive pain management.
                </p>
                <div class="service-meta">
                    <span>OPD Consultation:</span>
                    <span class="service-fee">₹550</span>
                </div>
            </div>

            <!-- 5. Cardiology -->
            <div class="service-card">
                <div class="service-icon-box">🫀</div>
                <h3>Cardiology &amp; Heart Care</h3>
                <p>
                    Preventive cardiac health screenings, 12-lead ECG analysis, blood pressure optimization, cholesterol management, and lifestyle guidance.
                </p>
                <div class="service-meta">
                    <span>OPD Consultation:</span>
                    <span class="service-fee">₹750</span>
                </div>
            </div>

            <!-- 6. Diagnostic Pathology -->
            <div class="service-card">
                <div class="service-icon-box">🔬</div>
                <h3>Diagnostic Pathology &amp; Lab</h3>
                <p>
                    Automated biochemistry, complete hemogram (CBC), HbA1c diabetic markers, lipid profiles, thyroid panels, and rapid digital report delivery.
                </p>
                <div class="service-meta">
                    <span>Tests starting from:</span>
                    <span class="service-fee">₹300</span>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Doctor Information Section -->
<section class="section" id="doctors">
    <div class="container">
        <div class="section-header">
            <span class="section-tagline">Medical Council Registered Faculty</span>
            <h2 class="section-title">Meet Our Senior Doctors</h2>
            <p class="section-desc">
                Experienced clinicians providing evidence-based healthcare with dedicated daily OPD consultation hours.
            </p>
        </div>

        <div class="doctors-grid">
            <% for (Doctor doc : doctors) { %>
            <div class="doctor-card">
                <div class="doctor-avatar-circle">
                    <%= doc.getFullName().replace("Dr. ", "").substring(0, 1) %>
                </div>
                <h4><%= doc.getFullName() %></h4>
                <div class="doctor-specialty"><%= doc.getDepartmentName() %></div>
                <div class="doctor-qualification"><%= doc.getQualification() %></div>

                <ul class="doctor-detail-list">
                    <li>
                        <span>📋</span>
                        <span>Reg: <strong><%= doc.getDoctorRegNo() %></strong></span>
                    </li>
                    <li>
                        <span>⏳</span>
                        <span>Experience: <%= doc.getExperienceYears() %> Years</span>
                    </li>
                    <li>
                        <span>📍</span>
                        <span><%= doc.getOpdRoomNo() %></span>
                    </li>
                    <li>
                        <span>🕒</span>
                        <span><%= doc.getOpdTimings() %></span>
                    </li>
                </ul>

                <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-outline-teal btn-sm">
                    Book Consultation
                </a>
            </div>
            <% } %>
        </div>
    </div>
</section>

<!-- Contact & Enquiry Section -->
<section class="section section-grey" id="contact">
    <div class="container">
        <div class="section-header">
            <span class="section-tagline">Get In Touch</span>
            <h2 class="section-title">Contact &amp; Hospital Helpdesk</h2>
            <p class="section-desc">
                Have questions regarding doctor availability, OPD token schedule, or lab tests? We are here to help.
            </p>
        </div>

        <div class="contact-grid">
            <!-- Contact Card -->
            <div class="contact-info-card">
                <h3>ByteNova Care Helpdesk</h3>
                <p>
                    Reach our hospital reception for appointment queries, test timings, and patient assistance.
                </p>

                <ul class="contact-info-items">
                    <li>
                        <span>📍</span>
                        <div>
                            <strong>Campus Location</strong>
                            ByteNova Care Community Hospital, Plot 18, Institutional Area, Knowledge Park III, Greater Noida, UP – 201310
                        </div>
                    </li>
                    <li>
                        <span>📞</span>
                        <div>
                            <strong>Helpline Phone</strong>
                            +91 98765 43210 / 0120-232-4000
                        </div>
                    </li>
                    <li>
                        <span>🚨</span>
                        <div>
                            <strong>24x7 Ambulance &amp; Trauma</strong>
                            Emergency Toll-Free: 108 / +91 11-2659-8800
                        </div>
                    </li>
                    <li>
                        <span>✉</span>
                        <div>
                            <strong>Official Email</strong>
                            helpdesk@bytenovacare.in
                        </div>
                    </li>
                </ul>
            </div>

            <!-- Quick Inquiry Form -->
            <div class="form-card">
                <h3 style="color: var(--color-navy); font-size: 1.25rem; font-weight: 600; margin-bottom: 6px;">
                    Send an OPD Enquiry
                </h3>
                <p style="font-size: 0.85rem; color: var(--color-text-muted); margin-bottom: 20px;">
                    Fill out the form below and our OPD desk will confirm doctor availability.
                </p>

                <form onsubmit="event.preventDefault(); alert('Thank you! Your enquiry has been received. Our OPD desk will contact you shortly.'); this.reset();">
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Full Name <span class="required">*</span></label>
                            <input type="text" class="form-control" placeholder="e.g. Ramesh Kumar" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Mobile Number <span class="required">*</span></label>
                            <input type="tel" class="form-control" placeholder="10-digit mobile number" pattern="[6-9][0-9]{9}" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Department</label>
                            <select class="form-control">
                                <option>General Medicine &amp; OPD</option>
                                <option>Paediatrics &amp; Child Health</option>
                                <option>Obstetrics &amp; Gynaecology</option>
                                <option>Orthopaedics &amp; Joint Care</option>
                                <option>Cardiology &amp; Heart Care</option>
                                <option>Diagnostic Pathology &amp; Lab</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Preferred Date</label>
                            <input type="date" class="form-control">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Message / Symptoms Overview</label>
                        <textarea class="form-control" rows="3" placeholder="Briefly describe your health query or symptoms..."></textarea>
                    </div>

                    <button type="submit" class="btn btn-teal">
                        Submit Enquiry
                    </button>
                </form>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
