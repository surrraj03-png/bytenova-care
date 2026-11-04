package com.bytenova.care.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

/**
 * Date utility for Indian date formatting (DD-MM-YYYY).
 * ByteNova Care – Team ByteNova
 */
public class DateUtil {

    public static final DateTimeFormatter INDIAN_DATE_FORMAT = DateTimeFormatter.ofPattern("dd-MM-yyyy");
    public static final DateTimeFormatter ISO_DATE_FORMAT = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    /**
     * Formats a LocalDate into DD-MM-YYYY Indian display string.
     */
    public static String formatIndianDate(LocalDate date) {
        if (date == null) {
            return "";
        }
        return date.format(INDIAN_DATE_FORMAT);
    }

    /**
     * Parses an Indian DD-MM-YYYY date string into a LocalDate.
     */
    public static LocalDate parseIndianDate(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return null;
        }
        try {
            return LocalDate.parse(dateStr.trim(), INDIAN_DATE_FORMAT);
        } catch (DateTimeParseException e) {
            // Fallback try ISO yyyy-MM-dd (standard HTML5 date input format)
            try {
                return LocalDate.parse(dateStr.trim(), ISO_DATE_FORMAT);
            } catch (DateTimeParseException ex) {
                return null;
            }
        }
    }
}
