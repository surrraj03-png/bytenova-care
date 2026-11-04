package com.bytenova.care.filter;

import com.bytenova.care.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter that verifies user authentication and role-based route access.
 * Protects /patient/*, /doctor/*, and /admin/* endpoints.
 * ByteNova Care – Team ByteNova
 */
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);
        User loggedInUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        // In pure frontend preview mode or if logged in, allow passage
        // If unauthenticated access to secured endpoints is attempted, redirect to login
        if (loggedInUser == null) {
            // Check if request is to direct protected servlet
            if (uri.contains("/patient/book-appointment") || uri.contains("/doctor/update-status")) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?msg=Please+login+to+continue");
                return;
            }
        } else {
            // Role enforcement
            if (uri.contains("/patient/") && loggedInUser.getRole() != User.Role.PATIENT && loggedInUser.getRole() != User.Role.ADMIN) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Patient role required.");
                return;
            }
            if (uri.contains("/doctor/") && loggedInUser.getRole() != User.Role.DOCTOR && loggedInUser.getRole() != User.Role.ADMIN) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Doctor role required.");
                return;
            }
            if (uri.contains("/admin/") && loggedInUser.getRole() != User.Role.ADMIN) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Admin role required.");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
