<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setAttribute("pageTitle", "Patient Registration – ByteNova Care");
    String error = (String) request.getAttribute("errorMessage");
%>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<jsp:include page="/WEB-INF/views/includes/navbar.jsp" />

<div class="auth-page-wrapper">
    <div class="auth-container wide">
        <div class="auth-card">
            <div class="auth-header">
                <div class="logo-icon-box" style="margin: 0 auto 12px; width: 48px; height: 48px;">✚</div>
                <h2>Patient OPD Registration</h2>
                <p>Create your digital health account and obtain your Unique Health Identifier (UHID)</p>
            </div>

            <% if (error != null && !error.trim().isEmpty()) { %>
            <div class="alert alert-danger">
                <span>⚠</span>
                <span><%= error %></span>
            </div>
            <% } %>

            <form id="patientRegisterForm" action="${pageContext.request.contextPath}/register-action" method="POST">
                <!-- Row 1: Full Name & Email -->
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="regFullName">
                            Full Name <span class="required">*</span>
                        </label>
                        <input type="text" 
                               id="regFullName" 
                               name="fullName" 
                               class="form-control" 
                               placeholder="e.g. Rahul Verma" 
                               required>
                        <div class="form-feedback">Enter at least 3 characters</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="regEmail">
                            Email Address <span class="required">*</span>
                        </label>
                        <input type="email" 
                               id="regEmail" 
                               name="email" 
                               class="form-control" 
                               placeholder="e.g. rahul.verma@gmail.com" 
                               required>
                        <div class="form-feedback">Enter a valid email address</div>
                    </div>
                </div>

                <!-- Row 2: Mobile Number & Gender -->
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="regPhone">
                            Mobile Number (10-digit Indian) <span class="required">*</span>
                        </label>
                        <div style="display: flex; gap: 8px;">
                            <span style="display: flex; align-items: center; padding: 0 12px; background: #F1F5F9; border: 1px solid var(--color-border); border-radius: var(--radius-md); font-weight: 600; font-size: 0.88rem; color: #475569;">
                                +91
                            </span>
                            <input type="tel" 
                                   id="regPhone" 
                                   name="phone" 
                                   class="form-control" 
                                   placeholder="9876543210" 
                                   maxlength="10"
                                   required>
                        </div>
                        <div class="form-feedback">Enter a valid 10-digit mobile number starting with 6-9</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="regGender">
                            Gender <span class="required">*</span>
                        </label>
                        <select id="regGender" name="gender" class="form-control" required>
                            <option value="">Select Gender</option>
                            <option value="MALE">Male</option>
                            <option value="FEMALE">Female</option>
                            <option value="OTHER">Other</option>
                        </select>
                    </div>
                </div>

                <!-- Row 3: Date of Birth & Blood Group -->
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="regDob">
                            Date of Birth (DD-MM-YYYY) <span class="required">*</span>
                        </label>
                        <input type="date" 
                               id="regDob" 
                               name="dob" 
                               class="form-control" 
                               required>
                        <div class="form-feedback">Please select your date of birth</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="regBloodGroup">
                            Blood Group
                        </label>
                        <select id="regBloodGroup" name="bloodGroup" class="form-control">
                            <option value="B+">B+ (Positive)</option>
                            <option value="O+">O+ (Positive)</option>
                            <option value="A+">A+ (Positive)</option>
                            <option value="AB+">AB+ (Positive)</option>
                            <option value="B-">B- (Negative)</option>
                            <option value="O-">O- (Negative)</option>
                            <option value="A-">A- (Negative)</option>
                            <option value="AB-">AB- (Negative)</option>
                        </select>
                    </div>
                </div>

                <!-- Row 4: Password & Confirm Password -->
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="regPassword">
                            Create Password <span class="required">*</span>
                        </label>
                        <input type="password" 
                               id="regPassword" 
                               name="password" 
                               class="form-control" 
                               placeholder="Min 6 characters" 
                               required>
                        <div class="form-feedback">Password must be at least 6 characters</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="regConfirmPassword">
                            Confirm Password <span class="required">*</span>
                        </label>
                        <input type="password" 
                               id="regConfirmPassword" 
                               name="confirmPassword" 
                               class="form-control" 
                               placeholder="Re-type password" 
                               required>
                        <div class="form-feedback">Passwords do not match</div>
                    </div>
                </div>

                <!-- Terms and Declaration -->
                <div class="form-group" style="margin-top: 8px;">
                    <label style="display: flex; align-items: flex-start; gap: 8px; font-size: 0.82rem; color: var(--color-text-muted); cursor: pointer;">
                        <input type="checkbox" id="regTerms" name="terms" checked style="margin-top: 3px;">
                        <span>
                            I confirm that the details provided are correct for Indian Outpatient (OPD) registration and give consent for digital medical records creation in ByteNova Care.
                        </span>
                    </label>
                </div>

                <div style="margin-top: 24px;">
                    <button type="submit" class="btn btn-teal btn-block btn-lg">
                        Complete Registration &amp; Generate UHID &rarr;
                    </button>
                </div>
            </form>

            <div style="text-align: center; margin-top: 22px; font-size: 0.88rem; color: var(--color-text-muted);">
                Already have an account or UHID? 
                <a href="${pageContext.request.contextPath}/login.jsp" style="font-weight: 600; color: var(--color-navy);">
                    Sign in to Portal
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
