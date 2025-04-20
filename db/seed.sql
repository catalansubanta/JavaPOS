

-- Insert Users
INSERT INTO `Users` (`User_ID`, `Role`, `Username`, `Password`, `Full_Name`, `Email`, `Phone`) VALUES
(1, 'admin', 'admin01', 'admin123', 'Admin User', 'admin@pos.com', '9800000000'),
(2, 'cashier', 'cashier01', 'cash123', 'Cashier Some', 'cashier@pos.com', '9800000001'),
(3, 'waiter', 'waiter01', 'wait123', 'Waiter Guy', 'waiter@pos.com', '9800000002');

-- Insert Table Numbers
INSERT INTO `Table_No` (`Table_ID`, `Table_Number`, `Status`) VALUES
(1, 1, 'available'),
(2, 2, 'occupied'),
(3, 3, 'reserved');

-- Insert Items (Menu)
INSERT INTO `Items` (`Item_ID`, `Item_Name`, `Description`, `Price`, `Category`, `Stock`, `Unit`) VALUES
(1, 'Iced Latte', 'Chilled coffee with milk', 3.50, 'drink', 50, 'ml'),
(2, 'Veg Burger', 'Fresh bun with veg patty', 5.00, 'food', 20, 'pcs'),
(3, 'French Fries', 'Crispy golden fries', 2.50, 'food', 30, 'g'),
(4, 'Mango Smoothie', 'Fresh mango blended with ice', 4.00, 'drink', 15, 'ml');

-- Insert Sample Order
INSERT INTO `Orders` (`Order_ID`, `User_ID`, `Table_ID`, `Order_Type`, `Order_Time`, `Order_Status`, `Total_Price`) VALUES
(1, 3, 2, 'dinein', '2025-04-13 17:47:32', 'completed', 12.00);

-- Insert Order Items
INSERT INTO `OrderItems` (`OrderItem_ID`, `Order_ID`, `Item_ID`, `Quantity`, `Price`, `Subtotal`) VALUES
(1, 1, 1, 2, 3.50, 7.00),
(2, 1, 2, 1, 5.00, 5.00);

-- Insert Cart Data (for Waiter 3)
INSERT INTO `Cart` (`Cart_ID`, `User_ID`, `Item_ID`, `Quantity`, `Created_At`) VALUES
(1, 3, 3, 1, '2025-04-13 17:47:32'),
(2, 3, 4, 2, '2025-04-13 17:47:32');

-- Insert Payment
INSERT INTO `Payment` (`Payment_ID`, `Order_ID`, `Paid_Amount`, `Payment_Time`, `Status`) VALUES
(1, 1, 12.00, '2025-04-13 17:47:32', 'paid');

COMMIT;
