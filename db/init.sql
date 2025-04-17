SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
CREATE TABLE `Cart` (
  `Cart_ID` int(11) NOT NULL,
  `User_ID` int(11) DEFAULT NULL,
  `Item_ID` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Created_At` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
(1, 3, 3, 1, '2025-04-13 17:47:32'),
(2, 3, 4, 2, '2025-04-13 17:47:32');
CREATE TABLE `Items` (
  `Item_ID` int(11) NOT NULL,
  `Item_Name` varchar(100) NOT NULL,
  `Description` text DEFAULT NULL,
  `Price` decimal(8,2) DEFAULT NULL,
  `Category` varchar(50) DEFAULT NULL,
  `Stock` float DEFAULT 0,
  `Unit` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
(1, 'Iced Latte', 'Chilled coffee with milk', 3.50, 'drink', 50, 'ml'),
(2, 'Veg Burger', 'Fresh bun with veg patty', 5.00, 'food', 20, 'pcs'),
(3, 'French Fries', 'Crispy golden fries', 2.50, 'food', 30, 'g'),
(4, 'Mango Smoothie', 'Fresh mango blended with ice', 4.00, 'drink', 15, 'ml');
CREATE TABLE `OrderItems` (
  `OrderItem_ID` int(11) NOT NULL,
  `Order_ID` int(11) DEFAULT NULL,
  `Item_ID` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Price` decimal(8,2) DEFAULT NULL,
  `Subtotal` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
(1, 1, 1, 2, 3.50, 7.00),
(2, 1, 2, 1, 5.00, 5.00);
CREATE TABLE `Payment` (
  `Payment_ID` int(11) NOT NULL,
  `Order_ID` int(11) DEFAULT NULL,
  `Paid_Amount` decimal(8,2) DEFAULT NULL,
  `Payment_Time` datetime DEFAULT current_timestamp(),
  `Status` enum('paid','unpaid','refunded') DEFAULT 'paid'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
(1, 1, 12.00, '2025-04-13 17:47:32', 'paid');
CREATE TABLE `Table_No` (
  `Table_ID` int(11) NOT NULL,
  `Table_Number` int(11) NOT NULL,
  `Status` enum('available','occupied','reserved') DEFAULT 'available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
(1, 1, 'available'),
(2, 2, 'occupied'),
(3, 3, 'reserved');
CREATE TABLE `Users` (
  `User_ID` int(11) NOT NULL,
  `Role` enum('admin','cashier','waiter') NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Full_Name` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
(1, 'admin', 'admin01', 'admin123', 'Admin User', 'admin@pos.com', '9800000000'),
(2, 'cashier', 'cashier01', 'cash123', 'Cashier some', 'cashier@pos.com', '9800000001'),
(3, 'waiter', 'waiter01', 'wait123', 'Waiter waiter', 'waiter@pos.com', '9800000002');
ALTER TABLE `Cart`
  ADD PRIMARY KEY (`Cart_ID`),
  ADD KEY `User_ID` (`User_ID`),
  ADD KEY `Item_ID` (`Item_ID`);
ALTER TABLE `Items`
  ADD PRIMARY KEY (`Item_ID`);
ALTER TABLE `OrderItems`
  ADD PRIMARY KEY (`OrderItem_ID`),
  ADD KEY `Order_ID` (`Order_ID`),
  ADD KEY `Item_ID` (`Item_ID`);
ALTER TABLE `Payment`
  ADD PRIMARY KEY (`Payment_ID`),
  ADD KEY `Order_ID` (`Order_ID`);
ALTER TABLE `Table_No`
  ADD PRIMARY KEY (`Table_ID`),
  ADD UNIQUE KEY `Table_Number` (`Table_Number`);
ALTER TABLE `Users`
  ADD PRIMARY KEY (`User_ID`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD UNIQUE KEY `Email` (`Email`);
ALTER TABLE `Cart`
  MODIFY `Cart_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
ALTER TABLE `Items`
  MODIFY `Item_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
ALTER TABLE `OrderItems`
  MODIFY `OrderItem_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
ALTER TABLE `Payment`
  MODIFY `Payment_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
ALTER TABLE `Table_No`
  MODIFY `Table_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `Users`
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `Cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `Users` (`User_ID`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`Item_ID`) REFERENCES `Items` (`Item_ID`);
ALTER TABLE `OrderItems`
  ADD CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`Order_ID`) REFERENCES `Orders` (`Order_ID`),
  ADD CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`Item_ID`) REFERENCES `Items` (`Item_ID`);
ALTER TABLE `Payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`Order_ID`) REFERENCES `Orders` (`Order_ID`);
COMMIT;