package com.bytenova.care.model;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * Model representing hospital departments (OPD, Cardiology, etc.).
 * Team ByteNova | ByteNova Care
 */
public class Department implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String code;
    private String description;
    private BigDecimal consultationFee;

    public Department() {
    }

    public Department(int id, String name, String code, String description, BigDecimal consultationFee) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.description = description;
        this.consultationFee = consultationFee;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getConsultationFee() {
        return consultationFee;
    }

    public void setConsultationFee(BigDecimal consultationFee) {
        this.consultationFee = consultationFee;
    }

    @Override
    public String toString() {
        return "Department{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", code='" + code + '\'' +
                ", consultationFee=" + consultationFee +
                '}';
    }
}
