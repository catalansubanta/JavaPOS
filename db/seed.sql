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


