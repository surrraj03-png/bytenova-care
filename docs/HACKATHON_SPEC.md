# ByteNova Care – University Hackathon Specification

## 1. Project Title & Metadata
- **Project Name:** ByteNova Care – Healthcare Management System
- **Tagline:** Smart Healthcare. Better Care.
- **Development Team:** Team ByteNova
- **Academic Context:** B.Tech Computer Science & Engineering (3rd Semester)
- **Target Platform:** Java Web Application (Jakarta EE 10 / Tomcat 10.1 / MySQL 8)

---

## 2. Problem Statement
Public and community healthcare facilities in India (such as District Hospitals, Primary Health Centres, and Community Health Centres) handle overwhelming outpatient loads daily. Key bottlenecks include:
1. **Long Physical Queues:** Patients wait hours merely to receive paper OPD slips without knowing doctor availability.
2. **Missing Medical Records:** Physical prescription slips are frequently lost or illegible, preventing continuity of care.
3. **Lack of Transparent Pricing:** Patients are often unaware of OPD consultation and lab test charges beforehand.
4. **Administrative Overload:** Hospital staff struggle to reconcile daily patient attendance, doctor schedules, and cash counter receipts.

---

## 3. The ByteNova Care Solution
ByteNova Care delivers a practical, lightweight web application built to digitize outpatient workflows:
- **Instant Digital Token Allocation:** Patients book appointments online or at the OPD desk and receive a numbered token.
- **Unique Health Identifier (UHID):** Every patient gets a permanent digital identity (`BNC-2026-XXXX`) aligning with Indian digital health initiatives (ABHA / Ayushman Bharat).
- **Legible E-Prescriptions:** Doctors generate standardized medication orders with explicit dosages (Morning-Afternoon-Night schedule, after food).
- **Zero Framework Bloat:** Developed using foundational Java Servlets, JSP, JDBC, and standard CSS without heavy single-page application (SPA) runtime dependencies.

---

## 4. GUVI Java Web-Based Marking Criteria Compliance

| Marking Criteria | Weightage | Implementation Evidence in ByteNova Care |
| :--- | :---: | :--- |
| **System Architecture & Design** | 25% | Multi-tier MVC structure cleanly separated into `model`, `dao`, `service`, `servlet`, `filter`, and `util`. Full `web.xml` configuration for Jakarta EE. |
| **Database & Persistence** | 25% | Normalized MySQL 8 schema (`users`, `patients`, `doctors`, `departments`, `appointments`, `prescriptions`). Safe JDBC queries using `PreparedStatement`. |
| **Functional Completeness** | 25% | 6 fully operational pages: Public Home, Login, Patient Registration, Patient Dashboard, Doctor OPD Console, and Administrator Console. |
| **Code Quality & UI Consistency** | 25% | Authentic Indian healthcare UI (Navy/Teal theme, INR ₹ currency, DD-MM-YYYY dates, 10-digit mobile validation, responsive layouts). |

---

## 5. Future Scope & Roadmap (Stage 2)
1. **SMS Gateway Integration:** Dispatching token reminders via DLT-approved SMS gateways in India.
2. **Payment Gateway Integration:** Adding UPI QR code generation (PhonePe/GooglePay/BHIM) for instantaneous counterless OPD fee collection.
3. **ABHA (Ayushman Bharat Health Account) API Integration:** Linking patient records with the National Health Authority (NHA) ecosystem.
4. **Laboratory Report Upload:** Direct PDF upload for automated blood report attachments to patient UHIDs.
