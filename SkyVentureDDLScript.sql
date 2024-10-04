-- Disable foreign key checks to prevent errors during table drops
SET FOREIGN_KEY_CHECKS = 0;

-- Drop table if it exists and any dependent objects or constraints
DROP TABLE IF EXISTS Plane CASCADE;
DROP TABLE IF EXISTS Seat CASCADE;
DROP TABLE IF EXISTS Seat_Status CASCADE;
DROP TABLE IF EXISTS Seat_Assignment CASCADE;
DROP TABLE IF EXISTS Itinerary CASCADE;
DROP TABLE IF EXISTS Ticket CASCADE;
DROP TABLE IF EXISTS Passenger CASCADE;
DROP TABLE IF EXISTS Baggage CASCADE;

-- Re-enable foreign key checks after the drop operations
SET FOREIGN_KEY_CHECKS = 1;


-- Define the tables
-- Create Plane Table
CREATE TABLE Plane (
    Plane_ID CHAR(5) PRIMARY KEY,     
    Capacity SMALLINT NOT NULL,        -- Use SMALLINT for smaller values
    Age TINYINT NOT NULL,              -- Use TINYINT for age (0-255)
    Mileage INT NOT NULL                -- INT is suitable for mileage
);

-- Create Seat Table
CREATE TABLE Seat (
    Seat_ID CHAR(8) PRIMARY KEY,       
    Plane_ID CHAR(5),                 
    FOREIGN KEY (Plane_ID) REFERENCES Plane(Plane_ID) ON DELETE SET NULL
);

-- Create Seat Status Table
CREATE TABLE Seat_Status (
    Seat_A_ID CHAR(12) PRIMARY KEY,   
    Seat_ID CHAR(8),                   
    Seat_Location CHAR(4) NOT NULL,     
    Status ENUM('Available', 'Occupied', 'Reserved') NOT NULL,  -- Use ENUM for fixed set of values
    FOREIGN KEY (Seat_ID) REFERENCES Seat(Seat_ID)
);

-- Create Seat Assignment Table
CREATE TABLE Seat_Assignment (
    Seat_A_ID CHAR(13) PRIMARY KEY,    
    Boarding_Rank TINYINT NOT NULL,      
    FOREIGN KEY (Seat_A_ID) REFERENCES Seat_Status(Seat_A_ID)
);

-- Create Itinerary Table
CREATE TABLE Itinerary (
    Itinerary_ID CHAR(5) PRIMARY KEY,   
    Start_Destination VARCHAR(50) NOT NULL,  
    End_Destination VARCHAR(50) NOT NULL,    
    Depart_Date DATE NOT NULL,
    Arrive_Date DATE NOT NULL,
    Gate CHAR(6),                     
    Arrival_Time TIME NOT NULL
);

-- Create Ticket Table
CREATE TABLE Ticket (
    Ticket_ID CHAR(5) PRIMARY KEY,       
    Itinerary_ID CHAR(5),                
    Seat_A_ID CHAR(13),                  
    Passenger_ID CHAR(5),               
    Baggage_ID CHAR(5),                 
    Status ENUM('Active', 'Cancelled', 'Completed') DEFAULT 'Active',
    FOREIGN KEY (Itinerary_ID) REFERENCES Itinerary(Itinerary_ID),
    FOREIGN KEY (Seat_A_ID) REFERENCES Seat_Assignment(Seat_A_ID),
    FOREIGN KEY (Passenger_ID) REFERENCES Passenger(Passenger_ID),
    FOREIGN KEY (Baggage_ID) REFERENCES Baggage(Baggage_ID)
);

-- Create Passenger Table
CREATE TABLE Passenger (
    Passenger_ID CHAR(5) PRIMARY KEY,    
    First_Name VARCHAR(30) NOT NULL,      
    Last_Name VARCHAR(30) NOT NULL,       
    DOB DATE NOT NULL,
    Street VARCHAR(50),                  
    City VARCHAR(30),                      
    "State" CHAR(2),                         
    Zipcode CHAR(5)                       
);

-- Create Baggage Table
CREATE TABLE Baggage (
    Baggage_ID CHAR(5) PRIMARY KEY,     
    Ticket_ID CHAR(5),                    
    Weight SMALLINT NOT NULL,              -- Use SMALLINT for weight (up to 65,535)
    FOREIGN KEY (Ticket_ID) REFERENCES Ticket(Ticket_ID)
);


-- Load data into tables
-- Plane data
INSERT INTO Plane (Plane_ID, Capacity, Age, Mileage)
VALUES 
    ('14471', 850, 11, 50000),
    ('15471', 450, 15, 200000),
    ('11471', 200, 25, 3000000),
    ('12471', 350, 17, 230000),
    ('1371', 500, 12, 4000000),
    ('16471', 230, 12, 2476500),
    ('17471', 150, 8, 200000);

-- Itinerary data
INSERT INTO Itinerary (Itinerary_ID, Start_Destination, End_Destination, Depart_date, Arrive_date, Gate, Arrival_time)
VALUES 
(110, 'New York', 'Los Angeles', '2023-11-01', '2023-11-01', 'Gate A', '11:00:00'),
(111, 'Los Angeles', 'Chicago', '2023-11-12', '2023-11-13', 'Gate B', '13:30:00'),
(112, 'Chicago', 'Atlanta', '2023-11-13', '2023-11-14', 'Gate C', '20:15:00'),
(113, 'Portland', 'DC', '2023-11-24', '2023-11-24', 'Gate D', '15:45:00'),
(114, 'Denver', 'Seattle', '2023-11-28', '2023-11-28', 'Gate E', '18:30:00'),
(210, 'New York', 'Charlotte', '2023-11-01', '2023-11-01', 'Gate A', '11:30:00'),
(211, 'Charlotte', 'New Orleans', '2023-11-10', '2023-11-10', 'Gate B', '02:30:00'),
(212, 'Columbus', 'Hartford', '2023-11-13', '2023-11-14', 'Gate C', '08:15:00'),
(213, 'DC', 'Newark', '2023-11-24', '2023-11-24', 'Gate D', '03:45:00'),
(214, 'Denver', 'Sacramento', '2023-11-28', '2023-11-29', 'Gate E', '01:30:00');

-- Baggage data
INSERT INTO Baggage (Baggage_ID, Ticket_ID, Weight)
VALUES 
(00001, 10001, 25),
(00002, 10002, 30),
(00003, 10003, 15),
(00004, 10004, 22),
(00005, 10005, 18),
(00006, 10006, 40),
(00007, 10007, 32),
(00008, 10008, 27),
(00009, 10009, 19),
(00010, 10010, 35),
(00011, 10011, 28),
(00012, 10012, 23),
(00013, 10013, 20),
(00014, 10014, 16),
(00015, 10015, 29),
(00016, 10016, 24),
(00017, 10017, 36),
(00018, 10018, 17),
(00019, 10019, 31),
(00020, 10020, 26),
(00021, 20001, 28),
(00022, 20002, 35),
(00023, 20003, 17),
(00024, 20004, 24),
(00025, 20005, 20),
(00026, 20006, 42),
(00027, 20007, 36),
(00028, 20008, 23),
(00029, 20009, 19),
(00030, 20010, 37),
(00031, 20011, 25),
(00032, 20012, 23),
(00033, 20013, 20),
(00034, 20014, 15),
(00035, 20015, 29),
(00036, 20016, 27),
(00037, 20017, 36),
(00038, 20018, 17),
(00039, 20019, 31),
(00040, 20020, 28);

-- Passenger data
INSERT INTO Passenger (Passenger_ID, First_name, Last_name, DOB, Street, City, State, Zipcode)
VALUES 
(12345, 'John', 'Doe', '1990-05-15', '123 Main Rd', 'New York', 'NY', '10001'),
(23456, 'Jane', 'Smith', '1985-08-20', '456 Oak St', 'Los Angeles', 'CA', '90001'),
(34567, 'Bob', 'Johnson', '1978-03-10', '789 Elm Ave', 'Chicago', 'IL', '60601'),
(45678, 'Alice', 'Williams', '1995-11-25', '321 Pine St', 'Miami', 'FL', '33101'),
(56789, 'Charlie', 'Brown', '1982-07-05', '654 Maple St', 'Houston', 'TX', '77001'),
(67890, 'Eva', 'Davis', '1998-01-30', '987 Cedar St', 'Seattle', 'WA', '98101'),
(12346, 'Michael', 'Jones', '1989-09-12', '631 Birch St', 'San Francisco', 'CA', '94101'),
(23457, 'Sarah', 'Clark', '1970-12-03', '171 Summer Blvd', 'Denver', 'CO', '80201'),
(34568, 'David', 'White', '1992-06-18', '871 Spring St', 'Dallas', 'TX', '75201'),
(45679, 'Olivia', 'Martin', '1980-04-28', '954 Ellie St', 'Atlanta', 'GA', '30301'),
(56780, 'Peter', 'Anderson', '1993-02-14', '424 Pratt Ave', 'Boston', 'MA', '02101'),
(67891, 'Grace', 'Miller', '1975-10-08', '212 Crane Ln', 'Charlotte', 'NC', '28201'),
(12347, 'Ryan', 'Harris', '1999-07-20', '593 Brad St', 'Orlando', 'FL', '32801'),
(23458, 'Emma', 'Taylor', '1987-04-05', '461 Oak St', 'Las Vegas', 'NV', '89101'),
(34569, 'Daniel', 'Moore', '1972-11-15', '978 Slow Ave', 'New Orleans', 'LA', '70112'),
(45670, 'Sophia', 'Baker', '1994-08-02', '323 Rock St', 'San Diego', 'CA', '92101'),
(56781, 'William', 'Turner', '1984-01-12', '774 Tree Rd', 'Minneapolis', 'MN', '55401'),
(67892, 'Ava', 'Fisher', '1986-09-28', '155 Ice Ave', 'Phoenix', 'AZ', '85001'),
(12348, 'Jackson', 'Ward', '1977-06-22', '943 Past Blvd', 'Philadelphia', 'PA', '19101'),
(23459, 'Madison', 'Cooper', '1991-03-18', '612 June St', 'Portland', 'OR', '97201'),
(33892, 'Thomas', 'Smith', '1989-01-25', '40 Birch Rd', 'New York', 'NY', '10001'),
(37849, 'Lisa', 'Johnson', '1995-06-22', '45 Cedar St', 'Albany', 'NY', '10101'),
(29018, 'Brady', 'Brown', '1997-10-24', '78 Pine Ave', 'Sacramento', 'CA', '94203'),
(78192, 'Ashley', 'Taylor', '2001-03-15', '32 Walnut St', 'Los Angeles', 'CA', '90001'),
(82734, 'Frederick', 'Miller', '1978-07-04', '632 Alpine St', 'Miami', 'FL', '33152'),
(72839, 'Ellie', 'Anderson', '1981-02-10', '991 Turmoil St', 'Springfield', 'IL', '62701'),
(17384, 'Steven', 'Wilson', '2003-12-03', '641 Rock St', 'Chicago', 'IL', '60601'),
(20394, 'Greg', 'Davis', '2000-10-31', '132 Free Blvd', 'Philadelphia', 'PA', '19019'),
(71829, 'Barbara', 'Jones', '1979-11-12', '853 Paradise St', 'Boston', 'MA', '02108'),
(82735, 'Linda', 'White', '1965-07-05', '931 Frank St', 'Atlanta', 'GA', '30301'),
(71823, 'Heather', 'Harris', '1955-08-25', '414 Lucy Ave', 'Columbus', 'OH', '43230'),
(91823, 'Emma', 'Martin', '1992-10-13', '210 Fox Ln', 'Cleveland', 'OH', '44101'),
(81934, 'Ryan', 'Thompson', '1983-12-06', '543 Cheryl St', 'Detroit', 'MI', '48201'),
(28934, 'Derek', 'Martinez', '2002-01-15', '471 Cherry St', 'Lansing', 'MI', '48901'),
(10039, 'Emily', 'Robinson', '2007-03-15', '489 Metro Ave', 'Denver', 'CO', '80201'),
(28345, 'Sofia', 'Clark', '2010-01-01', '420 Plaster St', 'Charlotte', 'NC', '28201'),
(18934, 'Andrew', 'Lee', '1945-05-25', '744 April Rd', 'Memphis', 'TN', '77340'),
(29385, 'Elizabeth', 'Walker', '1939-07-30', '210 Fish Ave', 'Seattle', 'WA', '98101'),
(71849, 'David', 'Hall', '2017-02-20', '23 Jordan Blvd', 'Portland', 'OR', '97201'),
(20495, 'Oliver', 'Wright', '2000-09-27', '655 Martyr St', 'Olympia', 'WA', '98500');


-- Ticket data
INSERT INTO Ticket (Ticket_ID, Itinerary_ID, Seat_A_ID, Passenger_ID, Status)
VALUES
(10001, 110, '14471A110001', 12345, 'Checked-In'),
(10002, 111, '14471B210002', 23456, 'Checked-In'),
(10003, 112, '14471C310003', 34567, 'Checked-In'),
(10004, 113, '14471D410000', 45678, 'Not Checked-In'),
(10005, 114, '14471E510005', 56789, 'Checked-In'),
(10006, 110, '14471F610000', 67890, 'Not Checked-In'),
(10007, 111, '14471A310007', 12346, 'Checked-In'),
(10008, 112, '14471B310000', 23457, 'Not Checked-In'),
(10009, 113, '14471C110000', 34568, 'Not Checked-In'),
(10010, 114, '14471D110000', 45679, 'Not Checked-In'),
(10011, 110, '14471E110011', 56780, 'Checked-In'),
(10012, 111, '14471F210012', 67891, 'Checked-In'),
(10013, 112, '14471A410013', 12347, 'Checked-In'),
(10014, 113, '14471B410000', 23458, 'Not Checked-In'),
(10015, 114, '14471C510015', 34569, 'Checked-In'),
(10016, 110, '14471D610000', 45670, 'Not Checked-In'),
(10017, 111, '14471E210017', 56781, 'Checked-In'),
(10018, 112, '14471F310000', 67892, 'Not Checked-In'),
(10019, 113, '14471A210019', 12348, 'Checked-In'),
(10020, 114, '14471B110020', 23459, 'Checked-In'),
(20001, 110, '15471A120001', 33892, 'Checked-In'),
(20002, 111, '15471B120002', 37849, 'Checked-In'),
(20003, 112, '15471C120003', 29018, 'Checked-In'),
(20004, 113, '15471D120000', 78192, 'Not Checked-In'),
(20005, 114, '15471E120005', 82734, 'Checked-In'),
(20006, 110, '15471F120000', 72839, 'Not Checked-In'),
(20007, 111, '15471A220007', 17384, 'Checked-In'),
(20008, 112, '15471B220000', 20394, 'Not Checked-In'),
(20009, 113, '15471C220000', 71829, 'Not Checked-In'),
(20010, 114, '15471D220010', 82735, 'Checked-In'),
(20011, 110, '15471E220011', 71823, 'Checked-In'),
(20012, 111, '15471F220012', 91823, 'Checked-In'),
(20013, 112, '15471A320013', 81934, 'Checked-In'),
(20014, 113, '15471B320000',28934 , 'Not Checked-In'),
(20015, 114, '15471C320015', 10039, 'Checked-In'),
(20016, 110, '15471D320016', 28345, 'Checked-In'),
(20017, 111, '15471E320017', 18934, 'Checked-In'),
(20018, 112, '15471F320018', 29385, 'Checked-In'),
(20019, 113, '15471A420019', 71849, 'Checked-In'),
(20020, 114, '15471B420020', 20495, 'Checked-In');

-- Seat Assignment data
INSERT INTO Seat_Assignment (Seat_A_ID, Boarding_Rank)
VALUES
('14471A110001', 'First Class'),
('14471B210002', 'Economy'),
('14471C310003', 'Business'),
('14471D410000', 'Economy'),
('14471E510005', 'First Class'),
('14471F610000', 'Economy'),
('14471A310007', 'Business'),
('14471B310000', 'Economy'),
('14471C110000', 'First Class'),
('14471D110010', 'Economy'),
('14471E110011','Business'),
('14471F210012', 'Economy'),
('14471A410013', 'First Class'),
('14471B410010', 'Economy'),
('14471C510015', 'Business'),
('14471D610010', 'Economy'),
('14471E210017', 'First Class'),
('14471F310010', 'Economy'),
('14471A210019', 'Business'),
('14471B110020', 'Economy'),
('15471A120001', 'First Class'),
('15471B120002', 'Economy'),
('15471C120003', 'Business'),
('15471D120000', 'Economy'),
('15471E120005', 'First Class'),
('15471F120000', 'Economy'),
('15471A220007', 'Business'),
('15471B220000', 'Economy'),
('15471C220000', 'First Class'),
('15471D220000', 'Economy'),
('15471E220011', 'Business'),
('15471F220012', 'Economy'),
('15471A320013', 'First Class'),
('15471B320000', 'Economy'),
('15471C320015', 'Business'),
('15471D320016', 'Economy'),
('15471E320017', 'First Class'),
('15471F320018', 'Economy'),
('15471A420019', 'Business'),
('15471B420020', 'Economy');


-- Seat Status data
INSERT INTO Seat_Status (Seat_ID, Seat_A_ID, Seat_Location, Status)
VALUES
('14471A1','14471A110001','A1','Taken'),
('14471B2','14471B210002','B2' ,'Taken'),
('14471C3','14471C310003','C3' ,'Taken'),
('14471D4','14471D400000','D4' ,'Not Taken'),
('14471E5','14471E510005','E5' ,'Taken'),
('14471F6','14471F600000','F6' ,'Not Taken'),
('14471A3','14471A310007','A3' ,'Taken'),
('14471B3','14471B300000','B3' ,'Not Taken'),
('14471C1','14471C100000','C1' ,'Not Taken'),
('14471D1','14471D100010','D1' ,'Not Taken'),
('14471E1','14471E110011','E1' ,'Taken'),
('14471F2','14471F210012','F2' ,'Taken'),
('14471A4','14471A410013','A4' ,'Taken'),
('14471B4','14471B400000','B4' ,'Not Taken'),
('14471C5','14471C510015','C5' ,'Taken'),
('14471D6','14471D600000','D6' ,'Not Taken'),
('14471E2','14471E210017','E2' ,'Taken'),
('14471F3','14471F300000','F3' ,'Not Taken'),
('14471A2','14471A210019','A2' ,'Taken'),
('14471B1','14471B110020','B1' ,'Taken'),
('15471B4','15471A120001','A1', 'Taken'),
('15471B1','15471B120002','B1', 'Taken'),
('15471C1','15471C120003','C1', 'Taken'),
('15471D1','15471D120000','D1', 'Not Taken'),
('15471E1','15471E120005','E1', 'Taken'),
('15471F1','15471F120000','F1', 'Not Taken'),
('15471A2','15471A220007','A2', 'Taken'),
('15471B2','15471B220000','B2', 'Not Taken'),
('15471C2','15471C220000','C2', 'Not Taken'),
('15471D2','15471D220000','D2', 'Not Taken'),
('15471E2','15471E220011','E2', 'Taken'),
('15471F2','15471F220012','F2', 'Taken'),
('15471A3','15471A320013','A3', 'Taken'),
('15471B3','15471B320000','B3', 'Not Taken'),
('15471C3','15471C320015','C3', 'Taken'),
('15471D3','15471D320016','D3', 'Not Taken'),
('15471E3','15471E320017','E3', 'Taken'),
('15471F3','15471F320018','F3', 'Not Taken'),
('15471A4','15471A420019','A4', 'Taken'),
('15471B4','15471B420020','B4', 'Taken');

-- Seat data
INSERT INTO Seat (Seat_ID, Plane_ID)
VALUES
('14471A1', 14471),
('14471B2', 14471),
('14471C3', 14471),
('14471D4', 14471),
('14471E5', 14471),
('14471F6', 14471),
('14471A3', 14471),
('14471B3', 14471),
('14471C1', 14471),
('14471D1', 14471),
('14471E1', 14471),
('14471F2', 14471),
('14471A4', 14471),
('14471B4', 14471),
('14471C5', 14471),
('14471D6', 14471),
('14471E2', 14471),
('14471F3', 14471),
('14471A2', 14471),
('14471B1', 14471),
('15471A1',15471),
('15471B1',15471),
('15471C1',15471),
('15471D1',15471),
('15471E1',15471),
('15471F1',15471),
('15471A2',15471),
('15471B2',15471),
('15471C2',15471),
('15471D2',15471),
('15471E2',15471),
('15471F2',15471),
('15471A3',15471),
('15471B3',15471),
('15471C3',15471),
('15471D3',15471),
('15471E3',15471),
('15471F3',15471),
('15471A4',15471);
