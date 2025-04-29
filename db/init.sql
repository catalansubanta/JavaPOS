
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+05:45";

-- USERS
CREATE TABLE `Users` (
  `User_ID` INT NOT NULL AUTO_INCREMENT,
  `Role` ENUM('admin','cashier','waiter') NOT NULL,
  `Username` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(255) NOT NULL,
  `Full_Name` VARCHAR(100) DEFAULT NULL,
  `Email` VARCHAR(100) DEFAULT NULL,
  `Phone` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`User_ID`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- TABLES (Physical restaurant tables)
CREATE TABLE `Table_No` (
  `Table_ID` INT NOT NULL AUTO_INCREMENT,
  `Table_Number` INT NOT NULL,
  `Table_Status` ENUM('available','occupied','reserved') DEFAULT 'available',
  PRIMARY KEY (`Table_ID`),
  UNIQUE KEY `Table_Number` (`Table_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ITEMS (Menu items)
CREATE TABLE `Items` (
  `Item_ID` INT NOT NULL AUTO_INCREMENT,
  `Item_Name` VARCHAR(100) NOT NULL,
  `Description` TEXT DEFAULT NULL,
  `Price` DECIMAL(8,2) DEFAULT NULL,
  `Category` VARCHAR(50) DEFAULT NULL,
  `Stock` FLOAT DEFAULT 0,
  `Unit` VARCHAR(10) DEFAULT NULL,
  PRIMARY KEY (`Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ORDERS
CREATE TABLE `Orders` (
  `Order_ID` INT NOT NULL AUTO_INCREMENT,
  `User_ID` INT DEFAULT NULL,
  `Table_ID` INT DEFAULT NULL,
  `Order_Type` ENUM('dinein','takeaway') DEFAULT 'dinein',
  `Order_Time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `Order_Status` ENUM('pending','completed','cancelled') DEFAULT 'pending',
  `Total_Price` DECIMAL(8,2),
  PRIMARY KEY (`Order_ID`),
  FOREIGN KEY (`User_ID`) REFERENCES `Users` (`User_ID`),
  FOREIGN KEY (`Table_ID`) REFERENCES `Table_No` (`Table_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ORDER ITEMS
CREATE TABLE `OrderItems` (
  `OrderItem_ID` INT NOT NULL AUTO_INCREMENT,
  `Order_ID` INT DEFAULT NULL,
  `Item_ID` INT DEFAULT NULL,
  `Quantity` INT DEFAULT NULL,
  `Price` DECIMAL(8,2) DEFAULT NULL,
  `Subtotal` DECIMAL(8,2) DEFAULT NULL,
  PRIMARY KEY (`OrderItem_ID`),
  KEY `Order_ID` (`Order_ID`),
  KEY `Item_ID` (`Item_ID`),
  FOREIGN KEY (`Order_ID`) REFERENCES `Orders` (`Order_ID`),
  FOREIGN KEY (`Item_ID`) REFERENCES `Items` (`Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- CART (temporary items before order is placed)
CREATE TABLE `Cart` (
  `Cart_ID` INT NOT NULL AUTO_INCREMENT,
  `User_ID` INT DEFAULT NULL,
  `Item_ID` INT DEFAULT NULL,
  `Quantity` INT DEFAULT NULL,
  `Created_At` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Cart_ID`),
  KEY `User_ID` (`User_ID`),
  KEY `Item_ID` (`Item_ID`),
  FOREIGN KEY (`User_ID`) REFERENCES `Users` (`User_ID`),
  FOREIGN KEY (`Item_ID`) REFERENCES `Items` (`Item_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- PAYMENTS
CREATE TABLE `Payment` (
  `Payment_ID` INT NOT NULL AUTO_INCREMENT,
  `Order_ID` INT DEFAULT NULL,
  `Paid_Amount` DECIMAL(8,2) DEFAULT NULL,
  `Payment_Time` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `Payment_Status` ENUM('paid','unpaid','refunded') DEFAULT 'paid',
  PRIMARY KEY (`Payment_ID`),
  KEY `Order_ID` (`Order_ID`),
  FOREIGN KEY (`Order_ID`) REFERENCES `Orders` (`Order_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

COMMIT;