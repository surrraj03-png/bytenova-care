# ByteNova Care – Architecture Documentation

## 1. Architectural Overview
ByteNova Care follows the classic **Model-View-Controller (MVC) Architecture** implemented on the Jakarta EE 10 specification for Apache Tomcat 10.1.

```
+-------------------------------------------------------------------------+
|                              Client Layer                               |
|       (Browser: HTML5, CSS3, Vanilla JS Form Validations & Modals)       |
+------------------------------------+------------------------------------+
                                     | HTTP Requests (GET/POST)
                                     v
+-------------------------------------------------------------------------+
|                              Filter Layer                               |
|        - EncodingFilter (UTF-8)                                         |
|        - AuthenticationFilter (Role Protection: /patient, /doctor, etc) |
+------------------------------------+------------------------------------+
                                     |
                                     v
+-------------------------------------------------------------------------+
|                            Controller Layer                             |
|                           (Jakarta Servlets)                            |
|    - HomeServlet       - AuthServlet        - PatientServlet            |
|    - DoctorServlet     - AdminServlet                                   |
+-----------------+----------------------------------+--------------------+
                  |                                  |
                  v                                  v
+-----------------------------------+  +----------------------------------+
|           Service Layer           |  |            View Layer            |
|   - AuthService                   |  |  (JSP 3.1 & JSTL 3.0 Rendering)  |
|   - DoctorService                 |  |  - index.jsp                     |
|   - AppointmentService            |  |  - login.jsp                     |
+-----------------+-----------------+  |  - register.jsp                  |
                  |                    |  - patient-dashboard.jsp         |
                  v                    |  - doctor-dashboard.jsp          |
+-----------------------------------+  |  - admin-dashboard.jsp           |
|             DAO Layer             |  +----------------------------------+
|  (Data Access Objects with JDBC)  |
|   - UserDao         - DoctorDao   |
|   - PatientDao      - ApptDao     |
|   - PrescriptionDao - DeptDao     |
+-----------------+-----------------+
                  |
                  v
+-------------------------------------------------------------------------+
|                            Persistence Layer                            |
|                     (MySQL 8.x InnoDB Database)                         |
+-------------------------------------------------------------------------+
```

## 2. Component Breakdown

### A. Model Layer (`com.bytenova.care.model`)
JavaBean classes representing core domain entities with encapsulation, getters, setters, and `Serializable` compliance:
- `User`: Base user identity with credentials, SHA-256 hash, and role enum (`PATIENT`, `DOCTOR`, `ADMIN`).
- `Patient`: Patient demographics including Unique Health Identifier (`UHID`), blood group, date of birth, and emergency contact.
- `Doctor`: Doctor credentials including Medical Council registration (`MCI`), specialty, room number, and OPD timings.
- `Department`: Medical department entity with consultation fee in ₹.
- `Appointment`: Outpatient scheduling entity tracking token numbers, appointment dates, slots, fee status, and triage status (`CONFIRMED`, `PENDING`, `COMPLETED`, `CANCELLED`).
- `Prescription`: Clinical documentation model storing structured medication dosages, diagnostic tests, doctor notes, and follow-up dates.

### B. DAO Layer (`com.bytenova.care.dao`)
Encapsulates all SQL statements and JDBC interactions:
- Employs `java.sql.PreparedStatement` to guarantee immunity against SQL injection vulnerabilities.
- Handles clean resource closing (`Connection`, `Statement`, `ResultSet`).
- Features a graceful fallback mock mechanism so the application remains demonstrable even before a live MySQL database instance is attached.

### C. Service Layer (`com.bytenova.care.service`)
Contains business rules and operational workflows:
- `AuthService`: Password hashing via SHA-256, credential verification, and automated UHID formatting (`BNC-2026-XXXX`).
- `AppointmentService`: Token number generation, conflict-free slot scheduling, and prescription issuing.
- `DoctorService`: Department-wise doctor filtering and availability tracking.

### D. Servlet Layer (`com.bytenova.care.servlet`)
Jakarta Servlets extending `HttpServlet`:
- Maps HTTP verbs (`doGet`, `doPost`).
- Extracts and sanitizes request parameters.
- Interacts with Services and populates request attributes for JSP forwarding or sends HTTP redirects.

### E. Filter Layer (`com.bytenova.care.filter`)
- `EncodingFilter`: Forces UTF-8 character encoding across all requests and responses.
- `AuthenticationFilter`: Intercepts secured URL patterns (`/patient/*`, `/doctor/*`, `/admin/*`) to verify active session presence and match user roles.

### F. Utility Layer (`com.bytenova.care.util`)
- `DBConnectionUtil`: Centralizes database connection pooling and configuration reading from `db.properties`.
- `PasswordUtil`: Generates standard SHA-256 digests.
- `DateUtil`: Converts between ISO HTML5 dates and standard Indian display formats (`DD-MM-YYYY`).

## 3. Database Schema Design (MySQL 8)
- 6 normalized relational tables with `InnoDB` engine and `utf8mb4` encoding.
- Foreign keys with `ON DELETE CASCADE` for dependent entities and `ON DELETE RESTRICT` for reference data.
- B-Tree indexes on `email`, `uhid`, `doctor_reg_no`, and `appointment_date` for sub-millisecond query execution.
