CREATE DATABASE L1_AyshamRashid_222924U_project_script;
USE L1_AyshamRashid_222924U_project_script;
-- drop database L1_AyshamRashid_222924U_project_script;

CREATE TABLE Role (
    roleID INT PRIMARY KEY AUTO_INCREMENT,
    roleName VARCHAR(50) NOT NULL
);

CREATE TABLE User (
    userID INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    roleID INT NOT NULL,
    FOREIGN KEY (roleID) REFERENCES Role(roleID)
);

CREATE TABLE Status (
    statusID INT PRIMARY KEY AUTO_INCREMENT,
    statusType VARCHAR(40) NOT NULL
);

CREATE TABLE Mobile (
    mobileID INT PRIMARY KEY AUTO_INCREMENT,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL
);

CREATE TABLE Broadband (
    broadbandID INT PRIMARY KEY AUTO_INCREMENT,
    brandbandName VARCHAR(50) NOT NULL,
    speed VARCHAR(50) NOT NULL
);

CREATE TABLE Plan (
    planID INT PRIMARY KEY AUTO_INCREMENT,
    planName VARCHAR(100) NOT NULL,
    datalimit INT NOT NULL,
    planPrice DECIMAL(10,2) NOT NULL,
    mobileID INT,
    broadbandID INT,
    FOREIGN KEY (mobileID) REFERENCES Mobile(mobileID),
    FOREIGN KEY (broadbandID) REFERENCES Broadband(broadbandID)
);

CREATE TABLE Device (
    deviceID INT PRIMARY KEY AUTO_INCREMENT,
    deviceName VARCHAR(45) NOT NULL,
    devicePrice DECIMAL(10,2) NOT NULL
);

CREATE TABLE Service (
    serviceID INT PRIMARY KEY AUTO_INCREMENT,
    serviceName VARCHAR(45) NOT NULL,
    serviceDesc VARCHAR(200) NOT NULL
);

CREATE TABLE InventoryAvailability (
    inventoryAvailabilityID INT PRIMARY KEY AUTO_INCREMENT,
    inventoryAvailabilityType VARCHAR(50) NOT NULL
);

CREATE TABLE Inventory (
    inventoryID INT PRIMARY KEY AUTO_INCREMENT,
    inventoryName VARCHAR(50) NOT NULL,
    description VARCHAR(200) NOT NULL,
    inventoryAvailabilityID INT NOT NULL,
    planID INT,
    deviceID INT,
    serviceID INT,
    FOREIGN KEY (inventoryAvailabilityID) REFERENCES InventoryAvailability(inventoryAvailabilityID),
    FOREIGN KEY (planID) REFERENCES Plan(planID),
    FOREIGN KEY (deviceID) REFERENCES Device(deviceID),
    FOREIGN KEY (serviceID) REFERENCES Service(serviceID)
);

CREATE TABLE Booking (
    bookingID INT PRIMARY KEY AUTO_INCREMENT,
    userID INT NOT NULL,
    inventoryID INT NOT NULL,
    bookingdate DATE NOT NULL,
    statusID INT NOT NULL,
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (inventoryID) REFERENCES Inventory(inventoryID),
    FOREIGN KEY (statusID) REFERENCES Status(statusID)
);

CREATE TABLE Payment (
    paymentID INT PRIMARY KEY AUTO_INCREMENT,
    bookingID INT NOT NULL,
    amountPaid DECIMAL(10,2) NOT NULL,
    paymentDate DATE NOT NULL,
    paymentMethod VARCHAR(50) NOT NULL,
    FOREIGN KEY (bookingID) REFERENCES Booking(bookingID)
);

CREATE TABLE eBill (
    billID INT PRIMARY KEY AUTO_INCREMENT,
    paymentID INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    billDate DATE NOT NULL,
    FOREIGN KEY (paymentID) REFERENCES Payment(paymentID)
);

CREATE TABLE Feedback (
    feedbackID INT PRIMARY KEY AUTO_INCREMENT,
    feedbackText VARCHAR(255) NOT NULL,
    feedbackDate DATE NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    bookingID INT NOT NULL,
    FOREIGN KEY (bookingID) REFERENCES Booking(bookingID)
);

CREATE TABLE Callback (
    callbackID INT PRIMARY KEY AUTO_INCREMENT,
    bookingID INT NOT NULL,
    callbackDate DATE NOT NULL,
    serviceID INT NOT NULL,
    FOREIGN KEY (bookingID) REFERENCES Booking(bookingID),
    FOREIGN KEY (serviceID) REFERENCES Service(serviceID)
);

ALTER TABLE Service ADD COLUMN callbackID INT, 
ADD FOREIGN KEY (callbackID) REFERENCES Callback(callbackID);
-- altered later to resolve foreign id dependecies

-- select * from role;
-- select * from User;
-- select * from Inventory;
-- select * from Mobile;
-- select * from Broadband;
-- select * from Plan;
-- select * from Booking;
-- select * from Payment;
-- select * from eBill;
-- select * from Feedback;
-- select * from Callback;

-- Insert roles
INSERT INTO Role (roleName) VALUES 
('Admin'),
('User'),
('Manager');

INSERT INTO Mobile (brand, model) VALUES 
('Apple', 'iPhone 14'),
('Samsung', 'Galaxy S23'),
('OnePlus', 'OnePlus 11');

INSERT INTO Broadband (brandbandName, speed) VALUES 
('FiberX', '100 Mbps'),
('SpeedNet', '250 Mbps'),
('UltraConnect', '1 Gbps');

INSERT INTO Plan (planName, datalimit, planPrice, mobileID, broadbandID) VALUES 
('Basic Mobile Plan', 10, 19.99, 1, NULL),
('Unlimited Mobile Plan', 100, 49.99, 2, NULL),
('Standard Broadband', 10, 39.99, NULL, 1),
('Premium Broadband', 10, 79.99, NULL, 2);

INSERT INTO Device (deviceName, devicePrice) VALUES 
('Samsung Galaxy Tab', 599.99),
('iPad Air', 699.99),
('Lenovo ThinkPad', 899.99);

INSERT INTO InventoryAvailability (inventoryAvailabilityType) VALUES 
('In Stock'),
('Out of Stock'),
('Pre-Order');

INSERT INTO Service (serviceName, serviceDesc) VALUES 
('Installation', 'Home installation service'),
('Technical Support', '24/7 technical support service');

INSERT INTO Inventory (inventoryName, description, inventoryAvailabilityID, planID, deviceID, serviceID) VALUES 
('iPhone 14 Package', 'Includes iPhone 14 with a basic mobile plan', 1, 1, 1, NULL),
('Samsung S23 Package', 'Includes Galaxy S23 with unlimited mobile plan', 1, 2, 2, NULL),
('FiberX Broadband', '100 Mbps broadband connection', 1, 3, NULL, NULL);

INSERT INTO Status (statusType) VALUES 
('Pending'),
('Confirmed'),
('Cancelled'),
('Completed');

INSERT INTO User (username, password, email, roleID) VALUES 
('admin_user', 'password123', 'admin@example.com', 1),
('john_doe', 'securePass1', 'john@example.com', 2),
('jane_smith', 'pass456', 'jane@example.com', 2),
('manager1', 'managerPass', 'manager@example.com', 3);

INSERT INTO Booking (userID, inventoryID, bookingdate, statusID) VALUES 
(2, 1, '2024-02-01', 2),
(3, 2, '2024-02-05', 1),
(2, 3, '2024-02-10', 3);

INSERT INTO Payment (bookingID, amountPaid, paymentDate, paymentMethod) VALUES 
(1, 19.99, '2024-02-02', 'Credit Card'),
(2, 49.99, '2024-02-06', 'PayPal'),
(3, 39.99, '2024-02-11', 'Debit Card');

INSERT INTO eBill (paymentID, amount, billDate) VALUES 
(1, 19.99, '2024-02-02'),
(2, 49.99, '2024-02-06'),
(3, 39.99, '2024-02-11');

INSERT INTO Feedback (feedbackText, feedbackDate, rating, bookingID) VALUES 
('Great service!', '2024-02-07', 5, 1),
('Could be better.', '2024-02-08', 3, 2),
('Very satisfied!', '2024-02-12', 4, 3);

INSERT INTO Callback (bookingID, callbackDate, serviceID) VALUES 
(1, '2024-02-03', 1),
(2, '2024-02-07', 2);

-- ALTER TABLE Service ADD COLUMN callbackID INT, 
-- ADD FOREIGN KEY (callbackID) REFERENCES Callback(callbackID);


-- select * from role;
-- select * from User;
-- select * from Inventory;
-- select * from Mobile;
-- select * from Broadband;
-- select * from Plan;
-- select * from Booking;
-- select * from Payment;
-- select * from eBill;
-- select * from Feedback;
-- select * from Callback;

-- ---------------------------------------------------
-- SQL STATEMENT
-- Insert a new booking
INSERT INTO Booking (userID, inventoryID, bookingDate, statusID) 
VALUES (1, 1, '2024-02-15', 1); -- Assuming statusID 1 is 'Pending'

-- View all bookings
SELECT B.bookingID, U.username, I.inventoryName, B.bookingDate, S.statusType
FROM Booking B
JOIN User U ON B.userID = U.userID
JOIN Inventory I ON B.inventoryID = I.inventoryID
JOIN Status S ON B.statusID = S.statusID;

-- Update booking status
UPDATE Booking 
SET statusID = 2  -- Assuming statusID 2 is 'Confirmed'
WHERE bookingID = 2;

-- Delete a booking
-- DELETE FROM Booking WHERE bookingID = 2;

-- Insert feedback
INSERT INTO Feedback (feedbackText, feedbackDate, rating, bookingID) 
VALUES ('Great service!', '2024-02-15', 5, 1);

-- Count bookings per month
SELECT DATE_FORMAT(bookingDate, '%Y-%m') AS Month, COUNT(*) AS TotalBookings
FROM Booking
GROUP BY Month
ORDER BY Month DESC;

-- View payment history
SELECT P.paymentID, U.username, B.bookingID, P.amountPaid, P.paymentDate, P.paymentMethod
FROM Payment P
JOIN Booking B ON P.bookingID = B.bookingID
JOIN User U ON B.userID = U.userID;





-- VIEWS
-- pending bookings 
-- View pending bookings
CREATE VIEW PendingBookings AS
SELECT B.bookingID, U.username, I.inventoryName, B.bookingDate
FROM Booking B
JOIN User U ON B.userID = U.userID
JOIN Inventory I ON B.inventoryID = I.inventoryID
WHERE B.statusID = 1; -- Assuming statusID 1 is 'Pending'

-- View all payments made
CREATE VIEW AllPayments AS
SELECT P.paymentID, U.username, P.amountPaid, P.paymentDate, P.paymentMethod
FROM Payment P
JOIN Booking B ON P.bookingID = B.bookingID
JOIN User U ON B.userID = U.userID;

-- View customer feedback
CREATE VIEW CustomerFeedback AS
SELECT U.username, F.feedbackText, F.rating, F.feedbackDate
FROM Feedback F
JOIN Booking B ON F.bookingID = B.bookingID
JOIN User U ON B.userID = U.userID;

-- View monthly booking trends
CREATE VIEW MonthlyBookingTrends AS
SELECT DATE_FORMAT(bookingDate, '%Y-%m') AS Month, COUNT(*) AS TotalBookings
FROM Booking
GROUP BY Month
ORDER BY Month DESC;

-- View available inventory
CREATE VIEW AvailableInventory AS
SELECT I.inventoryID, I.inventoryName, I.description
FROM Inventory I
JOIN InventoryAvailability IA ON I.inventoryAvailabilityID = IA.inventoryAvailabilityID
WHERE IA.inventoryAvailabilityType = 'In Stock';

SELECT * FROM PendingBookings;
SELECT * FROM AllPayments;
SELECT * FROM CustomerFeedback;
SELECT * FROM MonthlyBookingTrends;
SELECT * FROM AvailableInventory;

-- STORED PROCEDURES
-- Book a service
DELIMITER //
CREATE PROCEDURE BookService(IN p_userID INT, IN p_inventoryID INT)
BEGIN
    INSERT INTO Booking (userID, inventoryID, bookingDate, statusID)
    VALUES (p_userID, p_inventoryID, CURDATE(), 1); -- 1 for 'Pending'
END;
//
DELIMITER ;

-- Update booking status
DELIMITER //
CREATE PROCEDURE UpdateBookingStatus(IN p_bookingID INT, IN p_newStatusID INT)
BEGIN
    UPDATE Booking 
    SET statusID = p_newStatusID 
    WHERE bookingID = p_bookingID;
END;
//
DELIMITER ;

-- Get user's payment history
DELIMITER //
CREATE PROCEDURE GetUserPayments(IN p_username VARCHAR(100))
BEGIN
    SELECT P.paymentID, U.username, B.bookingID, P.amountPaid, P.paymentDate, P.paymentMethod
    FROM Payment P
    JOIN Booking B ON P.bookingID = B.bookingID
    JOIN User U ON B.userID = U.userID
    WHERE U.username = p_username;
END;
//
DELIMITER ;

-- Get monthly booking count
DELIMITER //
CREATE PROCEDURE GetMonthlyBookingCount()
BEGIN
    SELECT DATE_FORMAT(bookingDate, '%Y-%m') AS Month, COUNT(*) AS TotalBookings
    FROM Booking
    GROUP BY Month
    ORDER BY Month DESC;
END;
//
DELIMITER ;

-- Get monthly earnings
DELIMITER //
CREATE PROCEDURE GetMonthlyEarnings(IN p_yearMonth VARCHAR(7))  -- Format: 'YYYY-MM'
BEGIN
    SELECT 
        SUM(P.amountPaid) AS TotalEarnings,
        DATE_FORMAT(P.paymentDate, '%Y-%m') AS Month
    FROM Payment P
    JOIN Booking B ON P.bookingID = B.bookingID
    WHERE DATE_FORMAT(P.paymentDate, '%Y-%m') = p_yearMonth
    GROUP BY Month;
END;
//
DELIMITER ;

SET SQL_SAFE_UPDATES = 0;
CALL BookService(1, 2);  -- Example: User 1 books inventory ID 5
CALL UpdateBookingStatus(2, 2);  -- Example: Update booking 2 to 'Confirmed'
CALL GetUserPayments('admin_user');  -- Example: Get payments for 'admin_user'
CALL GetMonthlyBookingCount();  -- Get total bookings per month
CALL GetMonthlyEarnings('2024-02');  -- Get total earnings for February 2024
