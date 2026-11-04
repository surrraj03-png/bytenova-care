<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setAttribute("pageTitle", "Portal Login – ByteNova Care");
    String msg = request.getParameter("msg");
    String error = (String) request.getAttribute("errorMessage");
    if (error == null) {
        error = request.getParameter("error");
    }
    String enteredEmail = (String) request.getAttribute("enteredEmail");
    if (enteredEmail == null) {
        enteredEmail = "rahul.verma@gmail.com";
    }
%>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="auth-page-wrapper">
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <div class="logo-icon-box" style="margin: 0 auto 12px; width: 48px; height: 48px;">✚</div>
                <h2>Portal Login</h2>
                <p>Sign in to access your ByteNova Care health portal</p>
            </div>

            <!-- Notification Messages -->
            <% if (msg != null && !msg.trim().isEmpty()) { %>
            <div class="alert alert-success">
                <span>✔</span>
                <span><%= msg %></span>
            </div>
            <% } %>

            <% if (error != null && !error.trim().isEmpty()) { %>
            <div class="alert alert-danger">
                <span>⚠</span>
                <span><%= error %></span>
            </div>
            <% } %>

            <!-- Role Selector Tabs -->
            <div class="role-tabs">
                <button type="button" class="role-tab-btn active" data-role="PATIENT">
                    Patient
                </button>
                <button type="button" class="role-tab-btn" data-role="DOCTOR">
                    Doctor
                </button>
                <button type="button" class="role-tab-btn" data-role="ADMIN">
                    Admin
                </button>
            </div>

            <!-- Login Form -->
            <form id="loginForm" action="${pageContext.request.contextPath}/login-action" method="POST">
                <!-- Hidden input tracking selected role -->
                <input type="hidden" name="role" id="selectedRoleInput" value="PATIENT">

                <div class="form-group">
                    <label class="form-label" for="loginEmail">
                        Registered Email Address <span class="required">*</span>
                    </label>
                    <input type="email" 
                           id="loginEmail" 
                           name="email" 
                           class="form-control" 
                           placeholder="e.g. rahul.verma@gmail.com" 
                           value="<%= enteredEmail %>"
                           required>
                    <div class="form-feedback">Please enter a valid email address</div>
                </div>

                <div class="form-group">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px;">
                        <label class="form-label" for="loginPassword" style="margin-bottom: 0;">
                            Password <span class="required">*</span>
                        </label>
                        <a href="javascript:void(0)" onclick="alert('For testing: default password is password123 (or admin123 for Admin).')" style="font-size: 0.78rem;">
                            Forgot Password?
                        </a>
                    </div>
                    <input type="password" 
                           id="loginPassword" 
                           name="password" 
                           class="form-control" 
                           placeholder="Enter your account password" 
                           value="password123"
                           required>
                    <div class="form-feedback">Password is required</div>
                </div>

                <div class="form-group" style="display: flex; align-items: center; gap: 8px;">
                    <input type="checkbox" id="rememberMe" name="rememberMe" checked>
                    <label for="rememberMe" style="font-size: 0.85rem; color: var(--color-text-muted); cursor: pointer;">
                        Remember my login on this device
                    </label>
                </div>

                <button type="submit" class="btn btn-navy btn-primary btn-block">
                    Sign In to Portal &rarr;
                </button>
            </form>

            <div style="text-align: center; margin-top: 20px; font-size: 0.88rem; color: var(--color-text-muted);">
                New patient at ByteNova Care? 
                <a href="${pageContext.request.contextPath}/register.jsp" style="font-weight: 600; color: var(--color-teal);">
                    Register for OPD here
                </a>
            </div>

            <!-- Demo Credentials Guidance for Hackathon Evaluators -->
            <div class="demo-credentials-box">
                <h5>Evaluator Test Credentials:</h5>
                <p><strong>Patient:</strong> <code>rahul.verma@gmail.com</code> | <code>password123</code></p>
                <p><strong>Doctor:</strong> <code>dr.rajesh.sharma@bytenovacare.in</code> | <code>password123</code></p>
                <p><strong>Admin:</strong> <code>admin@bytenovacare.in</code> | <code>admin123</code></p>
                <p style="margin-top: 4px; font-size: 0.74rem; color: #64748B;">
                    <em>Click the role tabs above to auto-populate credentials.</em>
                </p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
