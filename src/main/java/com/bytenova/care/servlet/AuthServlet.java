package com.bytenova.care.servlet;

import com.bytenova.care.model.Patient;
import com.bytenova.care.model.User;
import com.bytenova.care.service.AuthService;
import com.bytenova.care.util.DateUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;

/**
 * Controller servlet for Login, Registration, and Logout.
 * ByteNova Care – Team ByteNova
 */
@WebServlet(name = "AuthServlet", urlPatterns = {"/auth", "/login-action", "/register-action", "/logout"})
public class AuthServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("/logout".equals(path)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Logged+out+successfully");
            return;
        }
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/login-action".equals(path)) {
            handleLogin(request, response);
        } else if ("/register-action".equals(path)) {
            handleRegister(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = authService.login(email, password, role);

        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("currentUser", user);
            session.setAttribute("userRole", user.getRole().name());
            session.setAttribute("userEmail", user.getEmail());

            // Redirect based on role
            switch (user.getRole()) {
                case PATIENT -> response.sendRedirect(request.getContextPath() + "/patient-dashboard.jsp");
                case DOCTOR -> response.sendRedirect(request.getContextPath() + "/doctor-dashboard.jsp");
                case ADMIN -> response.sendRedirect(request.getContextPath() + "/admin-dashboard.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid email, password, or role selection.");
            request.setAttribute("enteredEmail", email);
            request.setAttribute("selectedRole", role);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");
        String bloodGroup = request.getParameter("bloodGroup");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (password == null || !password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        LocalDate dob = DateUtil.parseIndianDate(dobStr);
        if (dob == null) {
            dob = LocalDate.of(1998, 1, 1);
        }

        Patient newPatient = authService.registerPatient(fullName, email, phone, gender, dob, bloodGroup, password);

        if (newPatient != null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Registration+successful.+Your+UHID+is+" + newPatient.getUhid());
        } else {
            request.setAttribute("errorMessage", "Registration failed. Email might already be registered.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
