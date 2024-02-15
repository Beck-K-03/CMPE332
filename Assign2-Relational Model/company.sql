drop database if exists RentalDB;
create database RentalDB;

CREATE TABLE Owner (
    OwnerID VARCHAR(50) NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (OwnerID)
);
CREATE TABLE RentalProperty (
    PropertyID INT PRIMARY KEY NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(100) NOT NULL,
    Province VARCHAR(100) NOT NULL,
    PostalCode VARCHAR(10) NOT NULL,
    ApartmentNumber VARCHAR(10),
    Type VARCHAR(50) NOT NULL,
    NumberOfBedrooms INT NOT NULL,
    NumberOfBathrooms INT NOT NULL,
    Parking BOOLEAN NOT NULL,
    LaundryType VARCHAR(50) NOT NULL,
    ListingDate DATE NOT NULL,
    Accessible BOOLEAN NOT NULL,
    CostPerMonth DECIMAL(10, 2) NOT NULL,

    OwnerID VARCHAR(50),

    FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID) ON DELETE SET NULL,
    PRIMARY KEY (PropertyID)
);

CREATE TABLE House (
    PropertyID INT PRIMARY KEY,
    FencedYard BOOLEAN,
    DetachedOrSemi VARCHAR(50),

    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID)
);

CREATE TABLE Apartment (
    PropertyID INT PRIMARY KEY,
    FloorNumber INT,
    Elevator BOOLEAN,

    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID)
);

CREATE TABLE Room (
    PropertyID INT PRIMARY KEY,
    NumberOfCoOccupants INT,
    KitchenPrivileges BOOLEAN,
    FurnishingsList TEXT, -- Consider normalizing this attribute

    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID)
);


CREATE TABLE PropertyManager (
    ManagerID VARCHAR(50) PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    PhoneNumber VARCHAR(50) UNIQUE
    -- Note: ManagementStartYear might be better suited in a separate table if a manager can manage multiple properties
);

CREATE TABLE Renter (
    StudentID VARCHAR(50) NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(50) NOT NULL,
    ExpectedGraduationYear INT NOT NULL,
    ProgramOfStudy VARCHAR(255) NOT NULL,

    GroupID INT NOT NULL,

    FOREIGN KEY (GroupID) REFERENCES RentalGroup(GroupID) ON DELETE CASCADE,
    PRIMARY KEY (StudentID)
);

CREATE TABLE RentalAgreement (
    AgreementID INT PRIMARY KEY NOT NULL,
   
    LeaseStartDate DATE NOT NULL,
    LeaseEndDate DATE NOT NULL,
    TotalMonthlyRent DECIMAL(10, 2) NOT NULL,

    PropertyID INT NOT NULL,
    GroupID INT NOT NULL,

    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID) ON DELETE CASCADE,
    FOREIGN KEY (GroupID) REFERENCES RentalGroup(GroupID) ON DELETE CASCADE,
    PRIMARY KEY (AgreementID)
);


CREATE TABLE RentalGroup (
    GroupID INT PRIMARY KEY NOT NULL,
    AccomodationType VARCHAR(10),
    PreferredNumBath INT NOT NULL,
    PreferredNumBed INT NOT NULL,
    PreferredLaundry BOOLEAN NOT NULL,
    PreferredAccessibility TEXT,--could be better way
    ParkingDesired BOOLEAN NOT NULL,
    MaxRent INT,

    PRIMARY KEY (GroupID)
);



