package com.mandal.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class VarganiEntry {
    private int collectionId;
    private int clientId;
    private Date collectionDate;
    private String donorName;
    private BigDecimal amount;
    private String collectedBy;
    private Timestamp createdAt;

    public int getCollectionId() { return collectionId; }
    public void setCollectionId(int collectionId) { this.collectionId = collectionId; }
    public int getClientId() { return clientId; }
    public void setClientId(int clientId) { this.clientId = clientId; }
    public Date getCollectionDate() { return collectionDate; }
    public void setCollectionDate(Date collectionDate) { this.collectionDate = collectionDate; }
    public String getDonorName() { return donorName; }
    public void setDonorName(String donorName) { this.donorName = donorName; }
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public String getCollectedBy() { return collectedBy; }
    public void setCollectedBy(String collectedBy) { this.collectedBy = collectedBy; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
