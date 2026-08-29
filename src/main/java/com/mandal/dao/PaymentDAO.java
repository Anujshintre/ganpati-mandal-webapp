package com.mandal.dao;

import com.mandal.model.Payment;
import com.mandal.util.DBConnection;

import java.sql.*;

public class PaymentDAO {

    public int createPending(Payment p) throws SQLException {
        String sql = "INSERT INTO payments (client_id, donor_name, whatsapp_number, amount, status) VALUES (?,?,?,?,'PENDING')";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, p.getClientId());
            ps.setString(2, p.getDonorName());
            ps.setString(3, p.getWhatsappNumber());
            ps.setBigDecimal(4, p.getAmount());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return -1;
    }

    public Payment getById(int paymentId) throws SQLException {
        String sql = "SELECT * FROM payments WHERE payment_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, paymentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public void markPaid(int paymentId, String receiptPath) throws SQLException {
        String sql = "UPDATE payments SET status='PAID', paid_at=NOW(), receipt_path=? WHERE payment_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, receiptPath);
            ps.setInt(2, paymentId);
            ps.executeUpdate();
        }
    }

    private Payment mapRow(ResultSet rs) throws SQLException {
        Payment p = new Payment();
        p.setPaymentId(rs.getInt("payment_id"));
        p.setClientId(rs.getInt("client_id"));
        p.setDonorName(rs.getString("donor_name"));
        p.setWhatsappNumber(rs.getString("whatsapp_number"));
        p.setAmount(rs.getBigDecimal("amount"));
        p.setStatus(rs.getString("status"));
        p.setPaidAt(rs.getTimestamp("paid_at"));
        p.setReceiptPath(rs.getString("receipt_path"));
        return p;
    }
}
