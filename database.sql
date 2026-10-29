CREATE DATABASE templedb;

USE templedb;

CREATE TABLE IF NOT EXISTS donation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    donor_name VARCHAR(50),
    amount INT,
    purpose VARCHAR(100),
    donated_on DATE
);

SELECT * FROM donation;