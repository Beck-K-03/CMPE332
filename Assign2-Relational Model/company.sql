drop database if exists RentalDB;
create database RentalDB;

CREATE TABLE Owner (
    OwnerID VARCHAR(5) PRIMARY KEY NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(50) NOT NULL UNIQUE,
);

CREATE TABLE PropertyManager (
    ManagerID VARCHAR(5) PRIMARY KEY NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(50) UNIQUE NOT NULL,
);

CREATE TABLE RentalGroup (
    GroupID INT PRIMARY KEY NOT NULL,
    AccomodationType VARCHAR(30),
    PreferredNumBath INT NOT NULL,
    PreferredNumBed INT NOT NULL,
    PreferredLaundry BOOLEAN NOT NULL,
    PreferredAccessibility TEXT,--could be better way
    ParkingDesired BOOLEAN NOT NULL,
    MaxRent INT,

);

CREATE TABLE Renter (
    StudentID INT PRIMARY KEY NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(50) UNIQUE NOT NULL,
    ExpectedGraduationYear INT NOT NULL,
    ProgramOfStudy VARCHAR(255) NOT NULL,

    GroupID INT NOT NULL,

    FOREIGN KEY (GroupID) REFERENCES RentalGroup(GroupID) ON DELETE SET NULL,
);

CREATE TABLE RentalAgreement (
    AgreementID INT PRIMARY KEY NOT NULL,
   
    LeaseStartDate DATE NOT NULL,
    LeaseEndDate DATE NOT NULL,
    TotalMonthlyRent DECIMAL(10, 2) NOT NULL,

    PropertyID INT NOT NULL,
    GroupID INT NOT NULL,
    DateSigned DATE NOT NULL,--for rental group that signed

    FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID) ON DELETE CASCADE,
    FOREIGN KEY (GroupID) REFERENCES RentalGroup(GroupID) ON DELETE CASCADE,
);

CREATE TABLE OwnerProperty (
    OwnerID VARCHAR(5),
    PropertyID INT,
    PRIMARY KEY (OwnerID, PropertyID),
    FOREIGN KEY (OwnerID) REFERENCES Owner(OwnerID)
        ON DELETE CASCADE,
    FOREIGN KEY (PropertyID) REFERENCES Property(PropertyID)
        ON DELETE CASCADE
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
    Accessibility BOOLEAN NOT NULL,
    CostPerMonth DECIMAL(10, 2) NOT NULL,

    PropertyManagerID VARCHAR(50),
    ManagementStartYear INT NOT NULL, --Only Tracking When The CURRENT MANAGER started managing

    FOREIGN KEY (PropertyManagerID) REFERENCES PropertyManager(ManagerID) ON DELETE SET NULL,
    PRIMARY KEY (PropertyID)
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

CREATE TABLE Furnishings(
PropertyID INT PRIMARY KEY,
Furnishing VARCHAR(15),
FOREIGN KEY (PropertyID) REFERENCES RentalProperty(PropertyID)
);











