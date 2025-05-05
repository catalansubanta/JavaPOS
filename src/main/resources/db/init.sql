-- Create database if not exists
CREATE DATABASE IF NOT EXISTS pos;
USE pos;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    User_ID INT AUTO_INCREMENT PRIMARY KEY,
    Role ENUM('admin', 'cashier', 'waiter') NOT NULL,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Full_Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20)
);

-- Create items table
CREATE TABLE IF NOT EXISTS items (
    Item_ID INT AUTO_INCREMENT PRIMARY KEY,
    Item_Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(8,2),
    Category VARCHAR(50),
    Stock FLOAT DEFAULT 0,
    Unit VARCHAR(10)
);

-- Create table_no table
CREATE TABLE IF NOT EXISTS table_no (
    Table_ID INT AUTO_INCREMENT PRIMARY KEY,
    Table_Number INT NOT NULL UNIQUE,
    Table_Status ENUM('available', 'occupied', 'reserved') DEFAULT 'available'
);

-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT,
    Table_ID INT,
    Order_Type ENUM('dinein', 'takeaway') DEFAULT 'dinein',
    Order_Time DATETIME DEFAULT CURRENT_TIMESTAMP,
    Order_Status ENUM('pending', 'completed', 'cancelled') DEFAULT 'pending',
    Total_Price DECIMAL(8,2),
    FOREIGN KEY (User_ID) REFERENCES users(User_ID),
    FOREIGN KEY (Table_ID) REFERENCES table_no(Table_ID)
);

-- Create orderitems table
CREATE TABLE IF NOT EXISTS orderitems (
    OrderItem_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID INT,
    Item_ID INT,
    Quantity INT,
    Price DECIMAL(8,2),
    Subtotal DECIMAL(8,2),
    FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID),
    FOREIGN KEY (Item_ID) REFERENCES items(Item_ID)
);

-- Create cart table
CREATE TABLE IF NOT EXISTS cart (
    Cart_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT,
    Item_ID INT,
    Quantity INT,
    Created_At DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (User_ID) REFERENCES users(User_ID),
    FOREIGN KEY (Item_ID) REFERENCES items(Item_ID)
);

-- Create payment table
CREATE TABLE IF NOT EXISTS payment (
    Payment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID INT,
    Paid_Amount DECIMAL(8,2),
    Payment_Time DATETIME DEFAULT CURRENT_TIMESTAMP,
    Payment_Status ENUM('paid', 'unpaid', 'refunded') DEFAULT 'paid',
    FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID)
); 