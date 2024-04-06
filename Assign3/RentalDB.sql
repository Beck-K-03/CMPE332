drop database if exists RentalDB;
create database RentalDB;
USE RentalDB;

CREATE TABLE Owner (
    OwnerID VARCHAR(5) PRIMARY KEY NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE PropertyManager (
    ManagerID VARCHAR(5) PRIMARY KEY NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE RentalGroup (
    GroupID INT PRIMARY KEY NOT NULL,
    AccomodationType VARCHAR(30),
    PreferredNumBath INT NOT NULL,
    PreferredNumBed INT NOT NULL,
    PreferredLaundry VARCHAR(15) NOT NULL,
    PreferredAccessibility VARCHAR(30),
    ParkingDesired BOOLEAN NOT NULL,
    MaxRent INT NOT NULL

);

CREATE TABLE Renter (
    StudentID INT PRIMARY KEY NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(50) UNIQUE NOT NULL,
    ExpectedGraduationYear INT NOT NULL,
    ProgramOfStudy VARCHAR(255) NOT NULL,

    GroupID INT NOT NULL,

    FOREIGN KEY (GroupID) REFERENCES RentalGroup(GroupID) ON DELETE CASCADE
);

CREATE TABLE RentalProperty (
    PropertyID INT PRIMARY KEY NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Province VARCHAR(100) NOT NULL,
    PostalCode VARCHAR(10) NOT NULL,
    StreetOrApartmentNumber VARCHAR(10),

    Type VARCHAR(50) NOT NULL,

    NumberOfBedrooms INT NOT NULL,
    NumberOfBathrooms INT NOT NULL,
    Parking BOOLEAN NOT NULL,
    LaundryType VARCHAR(50) NOT NULL,
    ListingDate DATE NOT NULL,
    Accessibility BOOLEAN NOT NULL,
    CostPerMonth DECIMAL(10, 2) NOT NULL,

    ManagerID VARCHAR(5) NOT NULL,
    ManagementStartYear INT NOT NULL,

    FOREIGN KEY (ManagerID) REFERENCES PropertyManager(ManagerID) ON DELETE CASCADE
);
CREATE TABLE RentalAgreement (
    AgreementID INT PRIMARY KEY NOT NULL,
   
    LeaseStartDate DATE NOT NULL,
    LeaseEndDate DATE NOT NULL,
    TotalMonthlyRent DECIMAL(10, 2) NOT NULL,

    PropertyID INT NOT NULL,
    GroupID INT NOT NULL,
    DateSigned DATE NOT NULL,

    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID) ON DELETE CASCADE,
    FOREIGN KEY (GroupID) REFERENCES RentalGroup(GroupID) ON DELETE CASCADE
);

CREATE TABLE OwnerProperty (
    OwnerID VARCHAR(5),
    PropertyID INT,
    PRIMARY KEY (OwnerID, PropertyID),
    FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID)
        ON DELETE CASCADE,
    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID)
        ON DELETE CASCADE
);


CREATE TABLE House (
    PropertyID INT PRIMARY KEY NOT NULL,
    FencedYard BOOLEAN NOT NULL,
    DetachedOrSemi VARCHAR(50) NOT NULL,

    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID) ON DELETE CASCADE
);

CREATE TABLE Apartment (
    PropertyID INT PRIMARY KEY NOT NULL,
    FloorNumber INT NOT NULL,
    Elevator BOOLEAN NOT NULL,

    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID) ON DELETE CASCADE
);

CREATE TABLE Room (
    PropertyID INT PRIMARY KEY NOT NULL,
    NumberOfCoOccupants INT NOT NULL,
    KitchenPrivileges BOOLEAN NOT NULL,

    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID) ON DELETE CASCADE
);

CREATE TABLE Furnishings (
PropertyID INT NOT NULL,
Furnishing VARCHAR(15) NOT NULL,
FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID)
);


INSERT INTO PropertyManager (ManagerID, FirstName, LastName, PhoneNumber) VALUES
('qt141', 'Alice', 'Johnson', '555-3333'),
('ty555', 'Bob', 'Brown', '555-5134'),
('ui789', 'Alex', 'Jobs', '555-9851'),
('qf476', 'Brain', 'Unglass', '555-1542'),
('gb165', 'Alice', 'Zuckerberg', '555-0932'),
('jk176', 'Issei', 'Hyoudou', '555-1666');

INSERT INTO RentalProperty (PropertyID, Address, City, Province, PostalCode, StreetOrApartmentNumber, Type, NumberOfBedrooms, NumberOfBathrooms, Parking, LaundryType, ListingDate, Accessibility, CostPerMonth, ManagerID, ManagementStartYear) VALUES
(1111, '123 Maple St', 'Anytown', 'ON', 'A1A 1A1', 'NA', 'House', 3, 2, TRUE, 'In-unit', '2023-01-01', FALSE, 1200.00, 'qt141', 2023),
(2222, '456 Oak Ave', 'Anytown', 'ON', 'A1A 2B2', '31', 'Apartment', 2, 1, FALSE, 'Shared', '2023-02-01', TRUE, 800.00, 'ty555', 2023),
(3333, '789 Pine Rd', 'Laketown', 'BC', 'B2B 3C3', 'NA', 'House', 4, 3, TRUE, 'In-unit', '2023-03-15', FALSE, 1500.00, 'ui789', 2023),
(4444, '101 Birch Ln', 'Laketown', 'BC', 'B2B 4D4', '12', 'Room', 1, 1, TRUE, 'Shared', '2023-04-01', TRUE, 500.00, 'qf476', 2023),
(5555, '234 Willow St', 'Hillside', 'AB', 'C3C 5E5', '45', 'Apartment', 3, 2, FALSE, 'In-unit', '2023-05-20', FALSE, 1000.00, 'gb165', 2023),
(6666, '567 Cedar Blvd', 'Hillside', 'AB', 'C3C 6F6', 'NA', 'House', 5, 4, TRUE, 'In-unit', '2023-06-10', TRUE, 2000.00, 'jk176', 2023),
(7777, '890 Elm St', 'Seaview', 'NS', 'D4D 7G7', '56', 'Apartment', 1, 1, FALSE, 'Shared', '2023-07-05', FALSE, 700.00, 'qt141', 2023),
(8888, '321 Spruce Ave', 'Seaview', 'NS', 'D4D 8H8', '14', 'Room', 2, 1, TRUE, 'Shared', '2023-08-15', TRUE, 600.00, 'qt141', 2023);

INSERT INTO Owner (OwnerID, FirstName, LastName, PhoneNumber) VALUES
('CR000', 'John', 'Doe', '555-1111'),
('LF123', 'Jane', 'Smith', '555-2222'),
('GR111', 'James', 'burger', '555-3333'),
('AS444', 'Jaqueline', 'nape', '555-4444'),
('AS546', 'Jack', 'Titan', '555-5555'),
('QE154', 'Gavin', 'Cox', '555-6666');



INSERT INTO RentalGroup (GroupID, AccomodationType, PreferredNumBath, PreferredNumBed, PreferredLaundry, PreferredAccessibility, ParkingDesired, MaxRent) VALUES
(1123, 'Apartment', 1, 2, 'Shared', 'Wheelchair Access', TRUE, 100000),
(2234, 'House', 2, 3, 'ENSUIT', 'None', TRUE, 90000),
(3567, 'Room', 3, 2, 'Shared', 'None', FALSE, 100),
(4567, 'House', 4, 3, 'Shared', 'None', TRUE, 1500),
(5567, 'Apartment', 1, 2, 'Shared', 'Riveted Stairs For Blind', TRUE, 2500),
(6345, 'Room', 2, 3, 'Shared', 'None', FALSE, 2000);

INSERT INTO Renter (StudentID, FirstName, LastName, PhoneNumber, ExpectedGraduationYear, ProgramOfStudy, GroupID) VALUES
(10011001, 'Emily', 'Clark', '555-5555', 2024, 'Computer Science', 1123),
(10022001, 'Dave', 'Wilson', '555-6666', 2025, 'Business', 2234),
(10033001, 'Sarah', 'Miller', '555-7777', 2023, 'English Literature', 1123),
(10044001, 'Michael', 'Brown', '555-8888', 2024, 'Mechanical Engineering', 2234),
(10055001, 'Jessica', 'Davis', '555-9999', 2025, 'Biology', 3567),
(10066001, 'Aaron', 'Smith', '555-0000', 2023, 'Chemistry', 4567),
(10077001, 'Hannah', 'Taylor', '555-0101', 2024, 'Mathematics', 5567),
(10088001, 'James', 'Anderson', '555-0202', 2025, 'Political Science', 6345);




INSERT INTO House (PropertyID, FencedYard, DetachedOrSemi) VALUES
(1111, TRUE, 'Detached'),
(3333, FALSE, 'Detached'),
(6666, TRUE, 'Semi');


INSERT INTO Apartment (PropertyID, FloorNumber, Elevator) VALUES
(2222, 1, TRUE),
(5555, 4, FALSE),
(7777, 7, TRUE);

INSERT INTO OwnerProperty (OwnerID, PropertyID) VALUES
('CR000', 1111),
('CR000', 2222),
('LF123', 1111),
('GR111', 3333),
('AS444', 4444),
('AS546', 5555),
('AS546', 6666),
('QE154', 7777),
('QE154', 8888),
('AS444', 1111);

INSERT INTO RentalAgreement (AgreementID, LeaseStartDate, LeaseEndDate, TotalMonthlyRent, PropertyID, GroupID, DateSigned) VALUES
(1, '2023-03-01', '2024-03-01', 2000.00, 1111, 1123, '2023-03-01'),
(2, '2023-04-01', '2024-04-01', 80.00, 2222, 2234, '2023-04-01'),
(3, '2023-03-01', '2024-03-01', 20000.00, 3333, 3567, '2023-03-01'),
(4, '2023-04-01', '2024-04-01', 100.00, 4444, 4567, '2023-04-01'),
(5, '2023-03-01', '2024-03-01', 9000.00, 5555, 5567, '2023-03-01'),
(6, '2023-04-01', '2024-04-01', 32.00, 6666, 6345, '2023-04-01');

INSERT INTO Furnishings (PropertyID, Furnishing) VALUES
(4444,'Chair'),
(8888,'Stool'),
(4444,'Motorcycle'),
(8888,'Desk'),
(4444,'Bench'),
(8888,'Log');