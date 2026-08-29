package com.mandal.model;

public class OfficeBearer {
    private int bearerId;
    private int clientId;
    private String role;   // ADHYAKSH, UPADHYAKSH, KHAJINDAR, MEMBER1, MEMBER2
    private String name;
    private String contactNo;

    public int getBearerId() { return bearerId; }
    public void setBearerId(int bearerId) { this.bearerId = bearerId; }
    public int getClientId() { return clientId; }
    public void setClientId(int clientId) { this.clientId = clientId; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getContactNo() { return contactNo; }
    public void setContactNo(String contactNo) { this.contactNo = contactNo; }
}
