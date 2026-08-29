package com.mandal.dao;

import com.mandal.model.VarganiEntry;
import com.mandal.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VarganiDAO {

    public void addEntry(VarganiEntry e) throws SQLException {
        String sql = "INSERT INTO vargani_collections (client_id, collection_date, donor_name, amount, collected_by) " +
                "VALUES (?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, e.getClientId());
            ps.setDate(2, e.getCollectionDate());
            ps.setString(3, e.getDonorName());
            ps.setBigDecimal(4, e.getAmount());
            ps.setString(5, e.getCollectedBy());
            ps.executeUpdate();
        }
    }

    /** All entries for a client, most recent first - used for the day-wise table. */
    public List<VarganiEntry> getEntriesByClient(int clientId) throws SQLException {
        List<VarganiEntry> list = new ArrayList<>();
        String sql = "SELECT * FROM vargani_collections WHERE client_id = ? ORDER BY collection_date DESC, collection_id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, clientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    public BigDecimal getTodayTotal(int clientId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(amount),0) AS total FROM vargani_collections " +
                "WHERE client_id = ? AND collection_date = CURDATE()";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, clientId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getBigDecimal("total");
            }
        }
        return BigDecimal.ZERO;
    }

    public BigDecimal getGrandTotal(int clientId) throws SQLException {
        String sql = "SELECT COALESCE(SUM(amount),0) AS total FROM vargani_collections WHERE client_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, clientId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getBigDecimal("total");
            }
        }
        return BigDecimal.ZERO;
    }

    private VarganiEntry mapRow(ResultSet rs) throws SQLException {
        VarganiEntry e = new VarganiEntry();
        e.setCollectionId(rs.getInt("collection_id"));
        e.setClientId(rs.getInt("client_id"));
        e.setCollectionDate(rs.getDate("collection_date"));
        e.setDonorName(rs.getString("donor_name"));
        e.setAmount(rs.getBigDecimal("amount"));
        e.setCollectedBy(rs.getString("collected_by"));
        e.setCreatedAt(rs.getTimestamp("created_at"));
        return e;
    }
}
