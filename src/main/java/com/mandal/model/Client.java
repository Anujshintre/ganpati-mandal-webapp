package com.mandal.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Client {
    private int clientId;
    private String mandalName;
    private String symbolImage;
    private Date foundingDate;
    private String taluka;
    private String district;
    private String leaderName;
    private String accountNumber;
    private String ganpatiPhoto;
    private String adminUsername;
    private String adminPassword;
    private String status;
    private Timestamp createdAt;

    public int getClientId() { return clientId; }
    public void setClientId(int clientId) { this.clientId = clientId; }
    public String getMandalName() { return mandalName; }
    public void setMandalName(String mandalName) { this.mandalName = mandalName; }
    public String getSymbolImage() { return symbolImage; }
    public void setSymbolImage(String symbolImage) { this.symbolImage = symbolImage; }
    public Date getFoundingDate() { return foundingDate; }
    public void setFoundingDate(Date foundingDate) { this.foundingDate = foundingDate; }
    public String getTaluka() { return taluka; }
    public void setTaluka(String taluka) { this.taluka = taluka; }
    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }
    public String getLeaderName() { return leaderName; }
    public void setLeaderName(String leaderName) { this.leaderName = leaderName; }
    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }
    public String getGanpatiPhoto() { return ganpatiPhoto; }
    public void setGanpatiPhoto(String ganpatiPhoto) { this.ganpatiPhoto = ganpatiPhoto; }
    public String getAdminUsername() { return adminUsername; }
    public void setAdminUsername(String adminUsername) { this.adminUsername = adminUsername; }
    public String getAdminPassword() { return adminPassword; }
    public void setAdminPassword(String adminPassword) { this.adminPassword = adminPassword; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
