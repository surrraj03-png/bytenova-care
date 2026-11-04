<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.bytenova.care.util.DBConnectionUtil" %>
<%
    request.setAttribute("pageTitle", "Database Status & Diagnostics – ByteNova Care");
    boolean connected = false;
    String dbProductName = "";
    String dbProductVersion = "";
    String driverName = "";
    String errorMessage = null;
    int userCount = 0, doctorCount = 0, patientCount = 0, apptCount = 0;

    try (Connection conn = DBConnectionUtil.getConnection()) {
        connected = true;
        DatabaseMetaData meta = conn.getMetaData();
        dbProductName = meta.getDatabaseProductName();
        dbProductVersion = meta.getDatabaseProductVersion();
        driverName = meta.getDriverName() + " " + meta.getDriverVersion();

        try (Statement st = conn.createStatement()) {
            try (ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM users")) {
                if (rs.next()) userCount = rs.getInt(1);
            }
            try (ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM doctors")) {
                if (rs.next()) doctorCount = rs.getInt(1);
            }
            try (ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM patients")) {
                if (rs.next()) patientCount = rs.getInt(1);
            }
            try (ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM appointments")) {
                if (rs.next()) apptCount = rs.getInt(1);
            }
        }
    } catch (SQLException e) {
        connected = false;
        errorMessage = e.getMessage() + " (SQLState: " + e.getSQLState() + ")";
    }
%>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="container section">
    <div class="section-header">
        <span class="section-tagline">Stage 2 Diagnostics</span>
        <h2 class="section-title">MySQL 8 Database Connection Status</h2>
        <p class="section-desc">
            Real-time JDBC connectivity status for ByteNova Care
        </p>
    </div>

    <div style="max-width: 800px; margin: 0 auto;">
        <% if (connected) { %>
            <div class="alert alert-success" style="font-size: 1rem; padding: 18px;">
                <span style="font-size: 1.5rem;">✔</span>
                <div>
                    <strong>Connected to MySQL Database!</strong>
                    <div>Successfully established live JDBC connection to <code><%= DBConnectionUtil.getUrl() %></code></div>
                </div>
            </div>

            <div class="panel-card" style="margin-top: 24px;">
                <div class="panel-header">
                    <h3>Connection &amp; Metadata Summary</h3>
                </div>
                <div class="panel-body">
                    <table class="custom-table">
                        <tr>
                            <th>Database Engine</th>
                            <td><%= dbProductName %> <%= dbProductVersion %></td>
                        </tr>
                        <tr>
                            <th>JDBC Driver</th>
                            <td><%= driverName %></td>
                        </tr>
                        <tr>
                            <th>Configured User</th>
                            <td><%= DBConnectionUtil.getUsername() %></td>
                        </tr>
                        <tr>
                            <th>Configured URL</th>
                            <td><code><%= DBConnectionUtil.getUrl() %></code></td>
                        </tr>
                    </table>

                    <h4 style="margin-top: 24px; margin-bottom: 12px; color: var(--color-navy);">Active Table Record Counts:</h4>
                    <div class="stats-row">
                        <div class="stat-card">
                            <div class="stat-info">
                                <h6>Users</h6>
                                <div class="stat-value"><%= userCount %></div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <h6>Doctors</h6>
                                <div class="stat-value"><%= doctorCount %></div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <h6>Patients</h6>
                                <div class="stat-value"><%= patientCount %></div>
                            </div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-info">
                                <h6>Appointments</h6>
                                <div class="stat-value"><%= apptCount %></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <% } else { %>
            <div class="alert alert-danger" style="font-size: 1rem; padding: 18px;">
                <span style="font-size: 1.5rem;">⚠</span>
                <div>
                    <strong>MySQL Database Connection Inactive</strong>
                    <div style="margin-top: 4px; font-size: 0.88rem;"><%= errorMessage %></div>
                </div>
            </div>

            <div class="panel-card" style="margin-top: 24px;">
                <div class="panel-header">
                    <h3>Configuration Checklist</h3>
                </div>
                <div class="panel-body">
                    <p style="margin-bottom: 14px;">To connect your local MySQL instance to ByteNova Care, follow these steps:</p>
                    <ol style="padding-left: 20px; line-height: 1.8; font-size: 0.92rem;">
                        <li>Open <strong>MySQL Workbench</strong> or MySQL CLI.</li>
                        <li>Run the script at <code>database/schema.sql</code> to create the <code>healthcare_db</code> database and tables.</li>
                        <li>Run the script at <code>database/seed_data.sql</code> to insert initial doctors, patients, and OPD records.</li>
                        <li>Create a <code>db.local.properties</code> file in the project root with your MySQL root password:
                            <pre style="background: #F1F5F9; padding: 10px; border-radius: 4px; margin: 8px 0; font-family: monospace;">db.password=YOUR_LOCAL_PASSWORD</pre>
                        </li>
                        <li>Refresh this page or run <code>test-db.bat</code> to verify the live connection!</li>
                    </ol>
                </div>
            </div>
        <% } %>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
