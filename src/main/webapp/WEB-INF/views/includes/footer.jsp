<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Site Footer -->
<footer class="site-footer">
    <div class="container">
        <div class="footer-grid">
            <!-- Brand & Mission -->
            <div class="footer-col">
                <div class="brand-logo" style="margin-bottom: 14px;">
                    <div class="logo-icon-box" style="background-color: #133E87;">✚</div>
                    <div class="brand-text">
                        <div class="brand-name" style="color: #FFFFFF;">ByteNova <span style="color: #5EEAD4;">Care</span></div>
                        <div class="brand-subtitle" style="color: #94A3B8;">Healthcare Management System</div>
                    </div>
                </div>
                <p>
                    ByteNova Care is a streamlined Indian healthcare management portal engineered for university OPD clinics, district community hospitals, and digital health records.
                </p>
                <div style="font-size: 0.85rem; color: #5EEAD4; font-weight: 600;">
                    Tagline: Smart Healthcare. Better Care.
                </div>
            </div>

            <!-- Quick Links -->
            <div class="footer-col">
                <h4>Quick Navigation</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/index.jsp#home">Home Page</a></li>
                    <li><a href="${pageContext.request.contextPath}/index.jsp#services">OPD Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/index.jsp#doctors">Our Doctors</a></li>
                    <li><a href="${pageContext.request.contextPath}/login.jsp">Patient Portal</a></li>
                    <li><a href="${pageContext.request.contextPath}/register.jsp">New Patient Registration</a></li>
                </ul>
            </div>

            <!-- Portals & Roles -->
            <div class="footer-col">
                <h4>Hospital Portals</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/patient-dashboard.jsp">Patient Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/doctor-dashboard.jsp">Doctor OPD Console</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin-dashboard.jsp">Administrator Panel</a></li>
                    <li><a href="${pageContext.request.contextPath}/index.jsp#contact">Emergency & Helpdesk</a></li>
                </ul>
            </div>

            <!-- Hospital Address & Hours -->
            <div class="footer-col">
                <h4>Hospital Location & Hours</h4>
                <p style="margin-bottom: 8px;">
                    <strong>ByteNova Care Community Hospital</strong><br>
                    Plot 18, Institutional Area, Knowledge Park III,<br>
                    Greater Noida, Uttar Pradesh – 201310
                </p>
                <p style="font-size: 0.82rem; color: #CBD5E1;">
                    <strong>OPD Consultations:</strong> Mon – Sat: 08:00 AM – 08:00 PM<br>
                    <strong>Emergency & Trauma:</strong> 24 Hours / 7 Days Open
                </p>
            </div>
        </div>

        <div class="footer-bottom">
            <div>
                &copy; <%= java.time.Year.now().getValue() %> ByteNova Care. All rights reserved.
            </div>
            <div class="team-badge">
                Developed by Team ByteNova
            </div>
            <div>
                B.Tech CSE University Hackathon Edition | Built with Java Jakarta Servlets &amp; JSP
            </div>
        </div>
    </div>
</footer>

<!-- JavaScript Files -->
<script src="${pageContext.request.contextPath}/assets/js/validation.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/dashboard.js"></script>
</body>
</html>
