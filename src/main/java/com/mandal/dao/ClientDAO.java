package com.mandal.dao;

import com.mandal.model.Client;
import com.mandal.model.OfficeBearer;
import com.mandal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClientDAO {

    public List<Client> getAllClients() throws SQLException {
        List<Client> list = new ArrayList<>();
        String sql = "SELECT * FROM clients ORDER BY client_id ASC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        }
        return list;
    }

    public Client getClientById(int clientId) throws SQLException {
        String sql = "SELECT * FROM clients WHERE client_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, clientId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    /**
     * Used by LoginServlet to authenticate a mandal's own admin login
     * (admin_username / admin_password columns, set during registration).
     * Only matches ACTIVE clients. Returns null if no match.
     */
    public Client getClientByAdminCredentials(String adminUsername, String adminPassword) throws SQLException {
        String sql = "SELECT * FROM clients WHERE admin_username = ? AND admin_password = ? AND status = 'ACTIVE'";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, adminUsername);
            ps.setString(2, adminPassword);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    /** Used by the invoice template before client-wise routing is wired in - shows the first registered mandal. */
    public Client getFirstClient() throws SQLException {
        String sql = "SELECT * FROM clients ORDER BY client_id ASC LIMIT 1";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    public int insertClient(Client c) throws SQLException {
        String sql = "INSERT INTO clients (mandal_name, symbol_image, founding_date, taluka, district, " +
                "leader_name, account_number, ganpati_photo, admin_username, admin_password, status) " +
                "VALUES (?,?,?,?,?,?,?,?,?,?,'ACTIVE')";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, c.getMandalName());
            ps.setString(2, c.getSymbolImage());
            ps.setDate(3, c.getFoundingDate());
            ps.setString(4, c.getTaluka());
            ps.setString(5, c.getDistrict());
            ps.setString(6, c.getLeaderName());
            ps.setString(7, c.getAccountNumber());
            ps.setString(8, c.getGanpatiPhoto());
            ps.setString(9, c.getAdminUsername());
            ps.setString(10, c.getAdminPassword());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return -1;
    }

    public void insertOfficeBearer(OfficeBearer ob) throws SQLException {
        String sql = "INSERT INTO office_bearers (client_id, role, name, contact_no) VALUES (?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, ob.getClientId());
            ps.setString(2, ob.getRole());
            ps.setString(3, ob.getName());
            ps.setString(4, ob.getContactNo());
            ps.executeUpdate();
        }
    }

    public List<OfficeBearer> getOfficeBearersByClient(int clientId) throws SQLException {
        List<OfficeBearer> list = new ArrayList<>();
        String sql = "SELECT * FROM office_bearers WHERE client_id = ? ORDER BY bearer_id ASC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, clientId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OfficeBearer ob = new OfficeBearer();
                    ob.setBearerId(rs.getInt("bearer_id"));
                    ob.setClientId(rs.getInt("client_id"));
                    ob.setRole(rs.getString("role"));
                    ob.setName(rs.getString("name"));
                    ob.setContactNo(rs.getString("contact_no"));
                    list.add(ob);
                }
            }
        }
        return list;
    }

    private Client mapRow(ResultSet rs) throws SQLException {
        Client c = new Client();
        c.setClientId(rs.getInt("client_id"));
        c.setMandalName(rs.getString("mandal_name"));
        c.setSymbolImage(rs.getString("symbol_image"));
        c.setFoundingDate(rs.getDate("founding_date"));
        c.setTaluka(rs.getString("taluka"));
        c.setDistrict(rs.getString("district"));
        c.setLeaderName(rs.getString("leader_name"));
        c.setAccountNumber(rs.getString("account_number"));
        c.setGanpatiPhoto(rs.getString("ganpati_photo"));
        c.setAdminUsername(rs.getString("admin_username"));
        c.setAdminPassword(rs.getString("admin_password"));
        c.setStatus(rs.getString("status"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        return c;
    }
}