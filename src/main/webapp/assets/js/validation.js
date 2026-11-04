/**
 * ByteNova Care – Form Validation & UI Utility
 * Team ByteNova | University Hackathon
 * Authentic client-side Indian healthcare form validation
 */

document.addEventListener('DOMContentLoaded', function () {
    // 1. Mobile Navigation Toggle
    const mobileToggle = document.getElementById('mobileToggle');
    const navMenu = document.getElementById('navMenu');
    if (mobileToggle && navMenu) {
        mobileToggle.addEventListener('click', function () {
            navMenu.classList.toggle('open');
        });
    }

    // 2. Patient Registration Form Validation
    const registerForm = document.getElementById('patientRegisterForm');
    if (registerForm) {
        registerForm.addEventListener('submit', function (e) {
            let isValid = true;

            // Full Name Validation
            const fullName = document.getElementById('regFullName');
            if (fullName && fullName.value.trim().length < 3) {
                showError(fullName, 'Please enter a valid full name (minimum 3 characters)');
                isValid = false;
            } else if (fullName) {
                clearError(fullName);
            }

            // Email Validation
            const email = document.getElementById('regEmail');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (email && !emailRegex.test(email.value.trim())) {
                showError(email, 'Please enter a valid email address');
                isValid = false;
            } else if (email) {
                clearError(email);
            }

            // Indian Mobile Number (10 digits starting with 6-9)
            const phone = document.getElementById('regPhone');
            const phoneRegex = /^[6-9]\d{9}$/;
            const cleanPhone = phone ? phone.value.replace(/[\s\-+]/g, '').slice(-10) : '';
            if (phone && !phoneRegex.test(cleanPhone)) {
                showError(phone, 'Enter a valid 10-digit Indian mobile number (e.g. 9876543210)');
                isValid = false;
            } else if (phone) {
                clearError(phone);
            }

            // Date of Birth Validation
            const dob = document.getElementById('regDob');
            if (dob && !dob.value) {
                showError(dob, 'Please select your Date of Birth');
                isValid = false;
            } else if (dob) {
                const selectedDate = new Date(dob.value);
                const today = new Date();
                if (selectedDate >= today) {
                    showError(dob, 'Date of birth cannot be in the future');
                    isValid = false;
                } else {
                    clearError(dob);
                }
            }

            // Password Validation
            const password = document.getElementById('regPassword');
            const confirmPassword = document.getElementById('regConfirmPassword');
            if (password && password.value.length < 6) {
                showError(password, 'Password must be at least 6 characters long');
                isValid = false;
            } else if (password) {
                clearError(password);
            }

            if (confirmPassword && confirmPassword.value !== password.value) {
                showError(confirmPassword, 'Passwords do not match');
                isValid = false;
            } else if (confirmPassword) {
                clearError(confirmPassword);
            }

            // Terms checkbox
            const terms = document.getElementById('regTerms');
            if (terms && !terms.checked) {
                alert('Please accept the hospital OPD registration terms to proceed.');
                isValid = false;
            }

            if (!isValid) {
                e.preventDefault();
            }
        });
    }

    // 3. Login Form Validation & Role Tabs
    const loginForm = document.getElementById('loginForm');
    const roleTabs = document.querySelectorAll('.role-tab-btn');
    const roleInput = document.getElementById('selectedRoleInput');

    if (roleTabs.length > 0 && roleInput) {
        roleTabs.forEach(function (tab) {
            tab.addEventListener('click', function () {
                roleTabs.forEach(t => t.classList.remove('active'));
                this.classList.add('active');
                const role = this.getAttribute('data-role');
                roleInput.value = role;

                // Update placeholder guidance for demo evaluator
                const emailInput = document.getElementById('loginEmail');
                const passInput = document.getElementById('loginPassword');
                if (emailInput && passInput) {
                    if (role === 'PATIENT') {
                        emailInput.value = 'rahul.verma@gmail.com';
                        passInput.value = 'password123';
                    } else if (role === 'DOCTOR') {
                        emailInput.value = 'dr.rajesh.sharma@bytenovacare.in';
                        passInput.value = 'password123';
                    } else if (role === 'ADMIN') {
                        emailInput.value = 'admin@bytenovacare.in';
                        passInput.value = 'admin123';
                    }
                }
            });
        });
    }

    if (loginForm) {
        loginForm.addEventListener('submit', function (e) {
            let isValid = true;
            const email = document.getElementById('loginEmail');
            const pass = document.getElementById('loginPassword');

            if (email && email.value.trim() === '') {
                showError(email, 'Email is required');
                isValid = false;
            } else if (email) {
                clearError(email);
            }

            if (pass && pass.value === '') {
                showError(pass, 'Password is required');
                isValid = false;
            } else if (pass) {
                clearError(pass);
            }

            if (!isValid) {
                e.preventDefault();
            }
        });
    }

    // 4. Appointment Booking Date Validation
    const apptDateInput = document.getElementById('appointmentDate');
    if (apptDateInput) {
        // Minimum date is today
        const todayStr = new Date().toISOString().split('T')[0];
        apptDateInput.setAttribute('min', todayStr);
    }

    // Helper functions
    function showError(inputElement, message) {
        inputElement.classList.add('is-invalid');
        let feedback = inputElement.parentElement.querySelector('.form-feedback');
        if (!feedback) {
            feedback = document.createElement('div');
            feedback.className = 'form-feedback';
            inputElement.parentElement.appendChild(feedback);
        }
        feedback.textContent = message;
        feedback.style.display = 'block';
    }

    function clearError(inputElement) {
        inputElement.classList.remove('is-invalid');
        const feedback = inputElement.parentElement.querySelector('.form-feedback');
        if (feedback) {
            feedback.style.display = 'none';
        }
    }
});
