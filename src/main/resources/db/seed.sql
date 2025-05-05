-- Insert users
INSERT INTO users (Role, Username, Password, Full_Name, Email, Phone) VALUES
('admin', 'catalan', '1234', 'Catalan Subanta', 'admin@pos.com', '9800000000'),
('cashier', 'luke', '1234', 'Luke Skywalker', 'cashier@pos.com', '9800000001'),
('waiter', 'rick', '1234', 'Rick Guy', 'rickguy@pos.com', '98000543202'),
('admin', 'greg', '1234', 'Gegrory House', 'gegroryhouse@pos.com', '9800123002'),
('waiter', 'waiter2', '1234', 'Eric foremen', 'ericforemen@pos.com', '9800000002'),
('cashier', 'cuddy', '1234', 'Lisa Cuddy', 'lisacuddy@pos.com', '9800003302');

-- Insert items
INSERT INTO items (Item_Name, Description, Price, Category, Stock, Unit) VALUES
('Iced Latte', 'Chilled coffee with milk', 350.00, 'drink', 50, 'ml'),
('Veg Burger', 'Fresh bun with veg patty', 500.00, 'food', 20, 'pcs'),
('French Fries', 'Crispy golden fries', 250.00, 'food', 30, 'g'),
('Mango Smoothie', 'Fresh mango blended with ice', 400.00, 'drink', 15, 'ml'),
('Luffy Mango Madness', 'A fruity blast of fresh mango', 200.00, 'drink', 15, 'ml'),
('Zoro Green Goodness', 'A cool minity mojito-style drink', 300.00, 'drink', 15, 'ml'),
('Classic Vanilla Milkshake', 'Smooth, creamy, and timeless classic', 250.00, 'drink', 15, 'ml'),
('Oreo Crush Milkshake', 'Cruncy Oreo blended into a creamy shake', 400.00, 'drink', 15, 'ml');

-- Insert tables
INSERT INTO table_no (Table_Number, Table_Status) VALUES
(1, 'available'),
(2, 'available'),
(3, 'available'),
(4, 'available'),
(5, 'occupied'),
(6, 'reserved');

-- Insert orders
INSERT INTO orders (User_ID, Table_ID, Order_Type, Order_Time, Order_Status, Total_Price) VALUES
(3, 1, 'dinein', '2025-04-13 17:47:32', 'completed', 1200.00),
(5, 2, 'dinein', '2025-04-15 07:40:02', 'completed', 1000.00),
(3, NULL, 'takeaway', '2025-04-19 11:44:31', 'completed', 1300.00),
(5, 4, 'dinein', '2025-04-21 10:37:22', 'completed', 1500.00),
(3, 5, 'dinein', '2025-04-23 09:30:00', 'completed', 1600.00),
(5, 6, 'dinein', '2025-04-25 08:15:45', 'completed', 1700.00),
(3, 1, 'dinein', '2025-04-27 07:00:00', 'completed', 1900.00),
(5, 2, 'dinein', '2025-04-29 06:45:00', 'completed', 2000.00),
(3, NULL, 'takeaway', '2025-04-30 05:30:00', 'completed', 1100.00),
(5, NULL, 'takeaway', '2025-05-02 04:15:00', 'completed', 900.00);

-- Insert order items
INSERT INTO orderitems (Order_ID, Item_ID, Quantity, Price, Subtotal) VALUES
(1, 1, 2, 350.00, 700.00),
(5, 3, 1, 250.00, 250.00),
(6, 2, 2, 500.00, 1000.00),
(7, 4, 1, 400.00, 400.00),
(8, 5, 2, 200.00, 400.00),
(9, 6, 3, 300.00, 900.00),
(10, 7, 1, 250.00, 250.00),
(1, 8, 2, 400.00, 800.00),
(2, 1, 1, 350.00, 350.00),
(3, 2, 2, 500.00, 1000.00),
(4, 3, 1, 250.00, 250.00),
(5, 4, 2, 400.00, 800.00);

-- Insert cart items
INSERT INTO cart (User_ID, Item_ID, Quantity, Created_At) VALUES
(3, 3, 1, '2025-04-13 17:47:32'),
(3, 4, 2, '2025-04-13 11:57:31'),
(3, 5, 1, '2025-04-13 01:17:12'),
(5, 4, 2, '2025-05-03 11:23:55'),
(5, 5, 1, '2025-05-03 11:23:55'),
(5, 6, 2, '2025-05-03 10:21:35'),
(5, 7, 1, '2025-05-03 11:23:55');

-- Insert payment
INSERT INTO payment (Order_ID, Paid_Amount, Payment_Time, Payment_Status) VALUES
(1, 12.00, '2025-04-13 17:47:32', 'paid'); 