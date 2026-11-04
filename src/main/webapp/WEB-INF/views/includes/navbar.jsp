<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Top Emergency & OPD Helpline Bar -->
<div class="top-notice-bar">
    <div class="container">
        <div class="notice-contact-item">
            <span>🚨 24x7 Emergency & Trauma:</span>
            <span class="highlight">108 / +91 11-2659-8800</span>
        </div>
        <div class="notice-contact-item">
            <span>OPD Timings:</span>
            <span class="highlight">Mon – Sat (08:00 AM – 08:00 PM)</span>
            <span style="margin-left: 12px;">| ABHA & Ayushman Bharat Supported</span>
        </div>
    </div>
</div>

<!-- Main Sticky Site Header -->
<header class="site-header">
    <div class="container">
        <nav class="site-navbar">
            <!-- Brand Logo -->
            <a href="${pageContext.request.contextPath}/index.jsp" class="brand-logo">
                <div class="logo-icon-box">✚</div>
                <div class="brand-text">
                    <div class="brand-name">ByteNova <span>Care</span></div>
                    <div class="brand-subtitle">Healthcare Management System</div>
                </div>
            </a>

            <!-- Mobile Hamburger Toggle -->
            <button class="mobile-toggle" id="mobileToggle" aria-label="Toggle navigation">
                ☰
            </button>

            <!-- Navigation Links -->
            <ul class="nav-menu" id="navMenu">
                <li><a href="${pageContext.request.contextPath}/index.jsp#home" class="nav-link active">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/index.jsp#about" class="nav-link">About</a></li>
                <li><a href="${pageContext.request.contextPath}/index.jsp#services" class="nav-link">Services</a></li>
                <li><a href="${pageContext.request.contextPath}/index.jsp#doctors" class="nav-link">Doctors</a></li>
                <li><a href="${pageContext.request.contextPath}/index.jsp#contact" class="nav-link">Contact</a></li>
                <li class="nav-auth-buttons">
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline btn-sm">Portal Login</a>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-teal btn-sm">Register OPD</a>
                </li>
            </ul>
        </nav>
    </div>
</header>
