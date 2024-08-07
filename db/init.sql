-- Create the database
CREATE DATABASE IF NOT EXISTS todoapp;

-- Enter the database
USE todoapp;

-- Creata a table inside the DB
CREATE TABLE IF NOT EXISTS tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    is_complete BOOLEAN DEFAULT false,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=INNODB;