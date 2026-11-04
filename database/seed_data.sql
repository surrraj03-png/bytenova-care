-- =====================================================================
-- ByteNova Care – Healthcare Management System
-- Seed / Sample Data for MySQL 8.x
-- Database Name: healthcare_db
-- Realistic Indian Healthcare Records
-- =====================================================================

USE healthcare_db;

-- Clear previous data in correct order
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE prescriptions;
TRUNCATE TABLE appointments;
TRUNCATE TABLE patients;
TRUNCATE TABLE doctors;
TRUNCATE TABLE departments;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. Insert Users (Password hashes are SHA-256 for 'password123' or 'admin123')
-- SHA-256 for 'admin123': 240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9
-- SHA-256 for 'password123': ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f
INSERT INTO users (id, email, password_hash, role, status) VALUES
(1, 'admin@bytenovacare.in', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN', 'ACTIVE'),
(2, 'dr.rajesh.sharma@bytenovacare.in', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'DOCTOR', 'ACTIVE'),
(3, 'dr.priya.nair@bytenovacare.in', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'DOCTOR', 'ACTIVE'),
(4, 'dr.ananya.mukherjee@bytenovacare.in', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'DOCTOR', 'ACTIVE'),
(5, 'dr.suresh.patel@bytenovacare.in', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'DOCTOR', 'ACTIVE'),
(6, 'dr.arvind.rao@bytenovacare.in', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'DOCTOR', 'ACTIVE'),
(7, 'rahul.verma@gmail.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'PATIENT', 'ACTIVE'),
(8, 'sneha.iyer@outlook.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'PATIENT', 'ACTIVE'),
(9, 'amit.kumar@yahoo.in', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'PATIENT', 'ACTIVE'),
(10, 'sunita.patil@rediffmail.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'PATIENT', 'ACTIVE');

-- 2. Insert Departments
INSERT INTO departments (id, name, code, description, consultation_fee) VALUES
(1, 'General Medicine & OPD', 'GEN-MED', 'Comprehensive primary adult care, acute viral illnesses, hypertension and diabetes management.', 400.00),
(2, 'Paediatrics & Child Health', 'PAED', 'Specialized medical care, growth monitoring, and immunization for infants, children, and adolescents.', 500.00),
(3, 'Obstetrics & Gynaecology', 'OBGYN', 'Antenatal care, women health screenings, maternal wellness, and fertility counselling.', 600.00),
(4, 'Orthopaedics & Joint Care', 'ORTHO', 'Treatment for bone fractures, arthritis, joint replacements, and sports injury rehabilitation.', 550.00),
(5, 'Cardiology', 'CARDIO', 'Preventive cardiac health, ECG analysis, hypertension control, and heart disease evaluations.', 750.00),
(6, 'Diagnostic Pathology & Lab', 'PATH', 'Routine blood counts, lipid panels, HbA1c testing, and automated biochemistry analyzers.', 300.00);

-- 3. Insert Doctors
INSERT INTO doctors (id, user_id, department_id, doctor_reg_no, full_name, qualification, experience_years, phone, opd_room_no, opd_timings, status) VALUES
(1, 2, 1, 'MCI-2012-48291', 'Dr. Rajesh Sharma', 'MBBS, MD (General Medicine)', 14, '+91 98112 34567', 'OPD Room 101', 'Mon-Sat: 09:00 AM - 01:00 PM', 'AVAILABLE'),
(2, 3, 3, 'KMC-2015-77219', 'Dr. Priya Nair', 'MBBS, MS (Obstetrics & Gynaecology)', 11, '+91 98450 12345', 'OPD Room 104', 'Mon-Fri: 10:00 AM - 02:00 PM', 'AVAILABLE'),
(3, 4, 2, 'WBMC-2017-38102', 'Dr. Ananya Mukherjee', 'MBBS, MD (Paediatrics), DCH', 9, '+91 98301 98765', 'OPD Room 202', 'Mon-Sat: 04:00 PM - 07:30 PM', 'AVAILABLE'),
(4, 5, 4, 'MMC-2010-91823', 'Dr. Suresh Patel', 'MBBS, MS (Orthopaedics), DNB', 16, '+91 98200 45678', 'OPD Room 108', 'Tue-Sat: 09:30 AM - 01:30 PM', 'AVAILABLE'),
(5, 6, 5, 'DMC-2008-61254', 'Dr. Arvind Rao', 'MBBS, MD, DM (Cardiology)', 18, '+91 98105 67890', 'Cardio OPD 301', 'Mon-Fri: 11:00 AM - 03:00 PM', 'AVAILABLE');

-- 4. Insert Patients
INSERT INTO patients (id, user_id, uhid, full_name, phone, gender, date_of_birth, blood_group, address, emergency_contact) VALUES
(1, 7, 'BNC-2026-0842', 'Rahul Verma', '+91 98765 43210', 'MALE', '1996-07-15', 'B+', 'Flat 402, Mayur Vihar Phase 1, Delhi', '+91 98765 00001'),
(2, 8, 'BNC-2026-0843', 'Sneha Iyer', '+91 98412 34567', 'FEMALE', '2001-03-22', 'O+', '12/4, 5th Cross, Indiranagar, Bengaluru', '+91 98412 00002'),
(3, 9, 'BNC-2026-0844', 'Amit Kumar', '+91 99341 87654', 'MALE', '1988-11-05', 'A+', 'Plot 88, Sector 15, Vasundhara, Ghaziabad', '+91 99341 00003'),
(4, 10, 'BNC-2026-0845', 'Sunita Patil', '+91 97654 32109', 'FEMALE', '1975-09-18', 'AB+', 'A-14, Shanti Nagar, Kothrud, Pune', '+91 97654 00004');

-- 5. Insert Appointments (Realistic dates in DD-MM-YYYY context)
INSERT INTO appointments (id, appointment_number, patient_id, doctor_id, department_id, appointment_date, time_slot, token_number, symptoms, fee_amount, fee_status, status) VALUES
(1, 'APT-20261104-001', 1, 1, 1, '2026-11-04', '09:30 AM - 10:00 AM', 1, 'Seasonal viral fever, body ache and mild dry cough for 3 days.', 400.00, 'PAID', 'COMPLETED'),
(2, 'APT-20261104-002', 2, 2, 3, '2026-11-04', '10:30 AM - 11:00 AM', 2, 'Routine second-trimester antenatal checkup & anomaly scan review.', 600.00, 'PAID', 'CONFIRMED'),
(3, 'APT-20261104-003', 3, 4, 4, '2026-11-04', '11:00 AM - 11:30 AM', 3, 'Left knee pain when climbing stairs; mild swelling after morning walk.', 550.00, 'PENDING_AT_COUNTER', 'CONFIRMED'),
(4, 'APT-20261104-004', 4, 5, 5, '2026-11-04', '12:00 PM - 12:30 PM', 4, 'Follow-up for essential hypertension; blood pressure review.', 750.00, 'PAID', 'CONFIRMED'),
(5, 'APT-20261105-001', 1, 5, 5, '2026-11-05', '11:30 AM - 12:00 PM', 1, 'Preventive heart checkup; lipid profile consultation.', 750.00, 'PENDING_AT_COUNTER', 'PENDING'),
(6, 'APT-20261106-001', 2, 3, 2, '2026-11-06', '04:30 PM - 05:00 PM', 1, 'Child immunisation advisory & booster dose scheduling.', 500.00, 'PENDING_AT_COUNTER', 'CONFIRMED');

-- 6. Insert Prescriptions
INSERT INTO prescriptions (id, appointment_id, patient_id, doctor_id, diagnosis, medicines, tests_recommended, doctor_notes, follow_up_date) VALUES
(1, 1, 1, 1, 'Acute Viral Upper Respiratory Infection (URI)', 
'1. Tab Dolo 650mg (Paracetamol) - 1 tablet three times a day after meals for 3 days if fever > 100°F\n2. Tab Cetirizine 10mg - 1 tablet at night for 5 days\n3. Cap Pantocid 40mg - 1 capsule once daily empty stomach in the morning for 5 days\n4. Steam inhalation twice daily with warm saline gargles', 
'CBC (Complete Blood Count) if fever persists beyond 5 days', 
'Adequate oral hydration (2.5L water/fluids daily). Rest well. Avoid chilled beverages.', 
'2026-11-09');
