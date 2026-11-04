-- =====================================================================
-- ByteNova Care – Healthcare Management System
-- Database Schema for MySQL 8.x
-- Database Name: healthcare_db
-- University Hackathon Project | Team ByteNova
-- =====================================================================

CREATE DATABASE IF NOT EXISTS healthcare_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE healthcare_db;

-- 1. Users Table (Core authentication entity for all roles)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('PATIENT', 'DOCTOR', 'ADMIN') NOT NULL DEFAULT 'PATIENT',
    status ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED') NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_user_email (email),
    INDEX idx_user_role (role)
) ENGINE=InnoDB;

-- 2. Departments Table (Hospital specialties)
CREATE TABLE IF NOT EXISTS departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    code VARCHAR(20) NOT NULL UNIQUE,
    description TEXT,
    consultation_fee DECIMAL(10, 2) NOT NULL DEFAULT 500.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 3. Doctors Table
CREATE TABLE IF NOT EXISTS doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    department_id INT NOT NULL,
    doctor_reg_no VARCHAR(50) NOT NULL UNIQUE, -- MCI / State Medical Council Registration No
    full_name VARCHAR(120) NOT NULL,
    qualification VARCHAR(100) NOT NULL, -- e.g., MBBS, MD (General Medicine)
    experience_years INT NOT NULL DEFAULT 0,
    phone VARCHAR(15) NOT NULL,
    opd_room_no VARCHAR(20) NOT NULL,
    opd_timings VARCHAR(100) NOT NULL, -- e.g., "Mon-Sat: 09:00 AM - 01:00 PM"
    status ENUM('AVAILABLE', 'ON_LEAVE', 'BUSY') NOT NULL DEFAULT 'AVAILABLE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE RESTRICT,
    INDEX idx_doctor_department (department_id),
    INDEX idx_doctor_reg (doctor_reg_no)
) ENGINE=InnoDB;

-- 4. Patients Table (Extended profile for patients)
CREATE TABLE IF NOT EXISTS patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    uhid VARCHAR(30) NOT NULL UNIQUE, -- Unique Health Identifier, e.g., BNC-2026-0001
    full_name VARCHAR(120) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    gender ENUM('MALE', 'FEMALE', 'OTHER') NOT NULL,
    date_of_birth DATE NOT NULL,
    blood_group ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'),
    address VARCHAR(255),
    emergency_contact VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_patient_uhid (uhid),
    INDEX idx_patient_phone (phone)
) ENGINE=InnoDB;

-- 5. Appointments Table (OPD bookings)
CREATE TABLE IF NOT EXISTS appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_number VARCHAR(30) NOT NULL UNIQUE, -- e.g., APT-20261104-001
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    department_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    time_slot VARCHAR(30) NOT NULL, -- e.g., "09:30 AM - 10:00 AM"
    token_number INT NOT NULL,
    symptoms TEXT,
    fee_amount DECIMAL(10, 2) NOT NULL DEFAULT 500.00,
    fee_status ENUM('PAID', 'PENDING_AT_COUNTER', 'WAIVED') NOT NULL DEFAULT 'PENDING_AT_COUNTER',
    status ENUM('CONFIRMED', 'PENDING', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'CONFIRMED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments(id) ON DELETE RESTRICT,
    INDEX idx_appt_date (appointment_date),
    INDEX idx_appt_status (status),
    INDEX idx_appt_doctor (doctor_id, appointment_date)
) ENGINE=InnoDB;

-- 6. Prescriptions Table
CREATE TABLE IF NOT EXISTS prescriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL UNIQUE,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    diagnosis VARCHAR(255) NOT NULL,
    medicines TEXT NOT NULL, -- Formatted instructions of medicines, dosage, schedule
    tests_recommended TEXT,
    doctor_notes TEXT,
    follow_up_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE
) ENGINE=InnoDB;
