package com.mandal.util;

/**
 * Global app constants.
 * NOTE: Super admin credentials are intentionally hardcoded as requested.
 * For production, move these to an environment variable or a properly
 * hashed row in DB - hardcoding is fine only for a controlled internal tool.
 */
public class AppConstants {
    public static final String SUPERADMIN_USERNAME = "Admin@123";
    public static final String SUPERADMIN_PASSWORD = "Admin@123#512";

    public static final String UPLOAD_DIR = "uploads";
    public static final String RECEIPT_DIR = "receipts";
}
