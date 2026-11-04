package com.bytenova.care.model;

import java.io.Serializable;

/**
 * Model representing doctors in ByteNova Care.
 * Team ByteNova | University Hackathon
 */
public class Doctor implements Serializable {
    private static final long serialVersionUID = 1L;

    public enum Status {
        AVAILABLE, ON_LEAVE, BUSY
    }

    private int id;
    private int userId;
    private int departmentId;
    private String departmentName;
    private String doctorRegNo; // Medical Council registration
    private String fullName;
    private String qualification;
    private int experienceYears;
    private String phone;
    private String email;
    private String opdRoomNo;
    private String opdTimings;
    private Status status;

    public Doctor() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getDoctorRegNo() {
        return doctorRegNo;
    }

    public void setDoctorRegNo(String doctorRegNo) {
        this.doctorRegNo = doctorRegNo;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public int getExperienceYears() {
        return experienceYears;
    }

    public void setExperienceYears(int experienceYears) {
        this.experienceYears = experienceYears;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOpdRoomNo() {
        return opdRoomNo;
    }

    public void setOpdRoomNo(String opdRoomNo) {
        this.opdRoomNo = opdRoomNo;
    }

    public String getOpdTimings() {
        return opdTimings;
    }

    public void setOpdTimings(String opdTimings) {
        this.opdTimings = opdTimings;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Doctor{" +
                "id=" + id +
                ", fullName='" + fullName + '\'' +
                ", departmentName='" + departmentName + '\'' +
                ", qualification='" + qualification + '\'' +
                ", status=" + status +
                '}';
    }
}
