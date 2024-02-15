
create database companydb;

CREATE TABLE RentalProperty (
    PropertyID INT PRIMARY KEY,
    Address VARCHAR(255),
    City VARCHAR(100),
    Province VARCHAR(100),
    PostalCode VARCHAR(10),
    ApartmentNumber VARCHAR(10) NULL,
    Type VARCHAR(50),
    NumberOfBedrooms INT,
    NumberOfBathrooms INT,
    Parking BOOLEAN,
    LaundryType VARCHAR(50),
    ListingDate DATE,
    Accessible BOOLEAN,
    CostPerMonth DECIMAL(10, 2)
);

-- Create House Extension Table
CREATE TABLE House (
    PropertyID INT PRIMARY KEY,
    FencedYard BOOLEAN,
    DetachedOrSemi VARCHAR(50),
    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID)
);

-- Create Apartment Extension Table
CREATE TABLE Apartment (
    PropertyID INT PRIMARY KEY,
    FloorNumber INT,
    Elevator BOOLEAN,
    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID)
);

-- Create Room Extension Table
CREATE TABLE Room (
    PropertyID INT PRIMARY KEY,
    NumberOfCoOccupants INT,
    KitchenPrivileges BOOLEAN,
    FurnishingsList TEXT, -- Consider normalizing this attribute
    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID)
);

-- Create Owner Table
CREATE TABLE Owner (
    OwnerID VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    PhoneNumber VARCHAR(50) UNIQUE
);

-- Create PropertyManager Table
CREATE TABLE PropertyManager (
    ManagerID VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    PhoneNumber VARCHAR(50) UNIQUE
    -- Note: ManagementStartYear might be better suited in a separate table if a manager can manage multiple properties
);

-- Create Renter Table
CREATE TABLE Renter (
    StudentID VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    PhoneNumber VARCHAR(50),
    ExpectedGraduationYear INT,
    ProgramOfStudy VARCHAR(255),
    GroupID INT,
    FOREIGN KEY (GroupID) REFERENCES RentalGroup(GroupID)
);

-- Create RentalGroup Table
CREATE TABLE RentalGroup (
    GroupID INT PRIMARY KEY,
    Preferences TEXT -- Consider detailing out or normalizing preferences
);

-- Create RentalAgreement Table
CREATE TABLE RentalAgreement (
    AgreementID INT PRIMARY KEY,
    PropertyID INT,
    GroupID INT,
    LeaseStartDate DATE,
    LeaseEndDate DATE,
    TotalMonthlyRent DECIMAL(10, 2),
    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID),
    FOREIGN KEY (GroupID) REFERENCES RentalGroup(GroupID)
);


-- Insert into RentalProperty
INSERT INTO RentalProperty (PropertyID, Address, City, Province, PostalCode, ApartmentNumber, Type, NumberOfBedrooms, NumberOfBathrooms, Parking, LaundryType, ListingDate, Accessible, CostPerMonth)
VALUES 
(1, '123 Maple Street', 'Kingston', 'Ontario', 'K7M8Z9', NULL, 'House', 3, 2, TRUE, 'Ensuite', '2023-01-01', FALSE, 1200.00),
(2, '456 Oak Avenue', 'Kingston', 'Ontario', 'K7P9L2', '101', 'Apartment', 2, 1, FALSE, 'Shared', '2023-02-15', TRUE, 850.00);

-- Insert into House
INSERT INTO House (PropertyID, FencedYard, DetachedOrSemi)
VALUES 
(1, TRUE, 'Detached');

-- Insert into Apartment
INSERT INTO Apartment (PropertyID, FloorNumber, Elevator)
VALUES 
(2, 10, TRUE);

-- Insert into Owner
INSERT INTO Owner (OwnerID, FirstName, LastName, PhoneNumber)
VALUES 
('AB123', 'John', 'Doe', '555-1234'),
('CD456', 'Jane', 'Smith', '555-5678');

-- Insert into PropertyManager
INSERT INTO PropertyManager (ManagerID, FirstName, LastName, PhoneNumber)
VALUES 
('XY789', 'Alice', 'Johnson', '555-9876');

-- Insert into Renter
INSERT INTO Renter (StudentID, FirstName, LastName, PhoneNumber, ExpectedGraduationYear, ProgramOfStudy, GroupID)
VALUES 
('S1234', 'Emily', 'Turner', '555-0001', 2024, 'Computer Science', 1),
('S5678', 'Michael', 'Brown', '555-0002', 2025, 'Business', 1);

-- Insert into RentalGroup
INSERT INTO RentalGroup (GroupID, Preferences)
VALUES 
(1, 'Type: House, Bedrooms: 3, Bathrooms: 2, Parking: Yes, Max Rent: 1300');

-- Insert into RentalAgreement
INSERT INTO RentalAgreement (AgreementID, PropertyID, GroupID, LeaseStartDate, LeaseEndDate, TotalMonthlyRent)
VALUES 
(1, 1, 1, '2023-03-01', '2024-02-28', 1200.00);



