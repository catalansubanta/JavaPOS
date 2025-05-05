

-- Insert Users
INSERT INTO `Users` (`User_ID`, `Role`, `Username`, `Password`, `Full_Name`, `Email`, `Phone`) VALUES
(1, 'admin', 'catalan', '1234', 'Catalan Subanta', 'admin@pos.com', '9800000000'),
(2, 'cashier', 'luke', '1234', 'Luke Skywalker', 'cashier@pos.com', '9800000001'),
(3, 'waiter', 'rick', '1234', 'Rick Guy', 'rickguy@pos.com', '98000543202'),
(4, 'admin', 'greg', '1234', 'Gegrory House', 'gegroryhouse@pos.com', '9800123002'),
(5, 'waiter', 'waiter2', '1234', 'Eric foremen', 'ericforemen@pos.com', '9800000002'),
(6, 'cashier', 'cuddy', '1234', 'Lisa Cuddy', 'lisacuddy@pos.com', '9800003302');

-- Insert Table Numbers
INSERT INTO `Table_No` (`Table_ID`, `Table_Number`, `Table_Status`) VALUES
(1, 1, 'available'),
(2, 2, 'available'),
(3, 3, 'available'),
(4, 4, 'available'),
(5, 5, 'occupied'),
(6, 6, 'reserved');

-- Insert Items (Menu)
INSERT INTO `Items` (`Item_ID`, `Item_Name`, `Description`, `Price`, `Category`, `Stock`, `Unit`) VALUES
(1, 'Iced Latte', 'Chilled coffee with milk', 350, 'drink', 50, 'ml'),
(2, 'Veg Burger', 'Fresh bun with veg patty', 500, 'food', 20, 'pcs'),
(3, 'French Fries', 'Crispy golden fries', 250, 'food', 30, 'g'),
(4, 'Mango Smoothie', 'Fresh mango blended with ice', 400, 'drink', 15, 'ml'),
(5, 'Luffy Mango Madness', 'A fruity blast of fresh mango', 200, 'drink', 15, 'ml'),
(6, 'Zoro Green Goodness', 'A cool minity mojito-style drink', 300, 'drink', 15, 'ml'),
(7, 'Classic Vanilla Milkshake', 'Smooth, creamy, and timeless classic', 250, 'drink', 15, 'ml'),
(8, 'Oreo Crush Milkshake', 'Cruncy Oreo blended into a creamy shake', 400, 'drink', 15, 'ml');

-- Insert Sample Order
INSERT INTO `Orders` (`Order_ID`, `User_ID`, `Table_ID`, `Order_Type`, `Order_Time`, `Order_Status`, `Total_Price`) VALUES
(1, 3, 1, 'dinein', '2025-04-13 17:47:32', 'completed', 1200),
(2, 5, 2, 'dinein', '2025-04-15 07:40:02', 'completed', 1000),
(3, 3, NULL, 'takeaway', '2025-04-19 11:44:31', 'completed', 1300),
(4, 5, 4, 'dinein', '2025-04-21 10:37:22', 'completed', 1500),
(5, 3, 5, 'dinein', '2025-04-23 09:30:00', 'completed', 1600),
(6, 5, 6, 'dinein', '2025-04-25 08:15:45', 'completed', 1700),
(7, 3, 1, 'dinein', '2025-04-27 07:00:00', 'completed', 1900),
(8, 5, 2, 'dinein', '2025-04-29 06:45:00', 'completed', 2000),
(9, 3, NULL, 'takeaway', '2025-04-30 05:30:00', 'completed', 1100),
(10, 5, NULL, 'takeaway', '2025-05-02 04:15:00', 'completed', 900);

-- Insert Order Items
INSERT INTO `OrderItems` (`OrderItem_ID`, `Order_ID`, `Item_ID`, `Quantity`, `Price`, `Subtotal`) VALUES
(1, 1, 1, 2, 350, 700),
(2, 5, 3, 1, 250, 250),
(3, 6, 2, 2, 500, 1000),
(4, 7, 4, 1, 400, 400),
(5, 8, 5, 2, 200, 400),
(6, 9, 6, 3, 300, 900),
(7, 10, 7, 1, 250, 250),
(8, 1, 8, 2, 400, 800),
(9, 2, 1, 1, 350, 350),
(10, 3, 2, 2, 500, 1000),
(11, 4, 3, 1, 250, 250),
(12, 5, 4, 2, 400, 800);

-- Insert Cart Data (for Waiter 3)
INSERT INTO `Cart` (`Cart_ID`, `User_ID`, `Item_ID`, `Quantity`, `Created_At`) VALUES
(1, 3, 3, 1, '2025-04-13 17:47:32'),
(2, 3, 4, 2, '2025-04-13 11:57:31'),
(3, 3, 5, 1, '2025-04-13 01:17:12'),
(4, 5, 4, 2, '2025-05-03 11:23:55'),
(5, 5, 5, 1, '2025-05-03 11:23:55'),
(6, 5, 6, 2, '2025-05-03 10:21:35'),
(7, 5, 7, 1, '2025-05-03 11:23:55');

-- Insert Payment
INSERT INTO `Payment` (`Payment_ID`, `Order_ID`, `Paid_Amount`, `Payment_Time`, `Payment_Status`) VALUES
(1, 1, 12.00, '2025-04-13 17:47:32', 'paid');

COMMIT;