-- =========================================================
-- Ganpati Mandal Multi-Tenant Database Schema
-- Every data table carries client_id so all data is separated
-- mandal-wise (client 1, client 2, client 3 ...)
-- =========================================================

CREATE DATABASE IF NOT EXISTS ganpati_mandal_db;
USE ganpati_mandal_db;

-- ---------------------------------------------------------
-- 1. CLIENTS (each row = one Mandal / one tenant)
-- ---------------------------------------------------------
CREATE TABLE IF NOT EXISTS clients (
    client_id       INT AUTO_INCREMENT PRIMARY KEY,
    mandal_name     VARCHAR(150) NOT NULL,
    symbol_image    VARCHAR(255),           -- path to uploaded symbol/logo
    founding_date   DATE,
    taluka          VARCHAR(100),
    district        VARCHAR(100),
    leader_name     VARCHAR(150),
    account_number  VARCHAR(50),
    ganpati_photo   VARCHAR(255),           -- path to uploaded ganpati photo
    admin_username  VARCHAR(100),
    admin_password  VARCHAR(255),
    status          VARCHAR(20) DEFAULT 'ACTIVE',
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------
-- 2. OFFICE BEARERS (5 per client: adhyaksh, upadhyaksh,
--    khajindar + 2 other members)
-- ---------------------------------------------------------
CREATE TABLE IF NOT EXISTS office_bearers (
    bearer_id   INT AUTO_INCREMENT PRIMARY KEY,
    client_id   INT NOT NULL,
    role        VARCHAR(30) NOT NULL,   -- ADHYAKSH, UPADHYAKSH, KHAJINDAR, MEMBER1, MEMBER2
    name        VARCHAR(150) NOT NULL,
    contact_no  VARCHAR(20),
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- 3. VARGANI COLLECTIONS (day-wise donation entries recorded
--    manually by the mandal admin - the daily collection log)
-- ---------------------------------------------------------
CREATE TABLE IF NOT EXISTS vargani_collections (
    collection_id   INT AUTO_INCREMENT PRIMARY KEY,
    client_id       INT NOT NULL,
    collection_date DATE NOT NULL,
    donor_name      VARCHAR(150),
    amount          DECIMAL(10,2) NOT NULL,
    collected_by    VARCHAR(150),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- 4. PAYMENTS (online donations made via the public invoice /
--    QR page - this is what generates the PDF receipt)
-- ---------------------------------------------------------
CREATE TABLE IF NOT EXISTS payments (
    payment_id      INT AUTO_INCREMENT PRIMARY KEY,
    client_id       INT NOT NULL,
    donor_name      VARCHAR(150),
    whatsapp_number VARCHAR(20),
    amount          DECIMAL(10,2) NOT NULL,
    status          VARCHAR(20) DEFAULT 'PENDING',   -- PENDING / PAID / FAILED
    paid_at         TIMESTAMP NULL,
    receipt_path    VARCHAR(255),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------
-- Seed: first demo mandal (client_id = 1) so the invoice
-- template has real data to show immediately, as requested
-- ---------------------------------------------------------
INSERT INTO clients (mandal_name, symbol_image, founding_date, taluka, district, leader_name, account_number, ganpati_photo, admin_username, admin_password, status)
VALUES ('Shree Ganesh Mitra Mandal', 'uploads/default-symbol.png', '2001-08-15', 'Haveli', 'Pune', 'Ramesh Patil', '1234567890123', 'uploads/default-ganpati.jpg', 'mandal1admin', 'mandal123', 'ACTIVE');

INSERT INTO office_bearers (client_id, role, name, contact_no) VALUES
(1, 'ADHYAKSH', 'Ramesh Patil', '9900000001'),
(1, 'UPADHYAKSH', 'Suresh Jadhav', '9900000002'),
(1, 'KHAJINDAR', 'Mahesh Kulkarni', '9900000003'),
(1, 'MEMBER1', 'Ganesh More', '9900000004'),
(1, 'MEMBER2', 'Vitthal Shinde', '9900000005');
