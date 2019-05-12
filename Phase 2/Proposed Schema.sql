CREATE TABLE Manager (
  managerEmail varchar (100) NOT NULL,
  managerName varchar (100) NOT NULL,
  last_login datetime DEFAULT NULL,
  PRIMARY KEY (managerEmail), 
);

CREATE TABLE City (
  cityName varchar (100) NOT NULL,
  state varchar (100) NOT NULL,
  population INT NOT NULL,
  PRIMARY KEY (cityName, state)
);

CREATE TABLE Manufacturer (
  manufacturerName varchar (100) NOT NULL,
  manufacMaxDiscount float NOT NULL,
  PRIMARY KEY (manufacturerName)
);

CREATE TABLE Category (
  categoryName varchar (100) NOT NULL,
  PRIMARY KEY (categoryName)
);

CREATE TABLE Store (
  storeNumber INT IDENTITY(1,1) NOT NULL,
  streetAddress varchar (100) NOT NULL,
  phoneNumber INT NOT NULL,
  cityName varchar (100) NOT NULL,
  state varchar (100) NOT NULL
  PRIMARY KEY (storeNumber),
  --KEY date_time (date_time)
);

CREATE TABLE Product (
  productId INT IDENTITY(1,1) NOT NULL,
  retailPRice float NOT NULL,
  productName varchar (100) NOT NULL,
  manufacturerName varchar (100) NOT NULL,
  PRIMARY KEY (productId)
);

CREATE TABLE Sale (
  productID INT NOT NULL,
  storeNumber INT NOT NULL,
  saleDate DATETIME NOT NULL,
  percentageDiscount float NOT NULL,
  quantityPurchased float NOT NULL
);

CREATE TABLE Manages (
  managerEmail varchar (100) NOT NULL,
  storeNumber INT NOT NULL
);

CREATE TABLE AssignedTo (
  productId INT NOT NULL,
  categoryName varchar (100) NOT NULL,
);

CREATE TABLE Holiday (
  holidayName varchar (100) NOT NULL,
  holidayDate DATETIME NOT NULL,
  productID INT NOT NULL,
  storeNumber INT NOT NULL,
  saleDate DATETIME NOT NULL
);

-- Constraints   Foreign Keys: FK_ChildTable_childColumn_ParentTable_parentColumn

ALTER TABLE Store
  ADD CONSTRAINT fk_Store_cityName_state_City_cityName_state FOREIGN KEY (cityName, state) REFERENCES City (cityName, State);

ALTER TABLE Product
  ADD CONSTRAINT fk_Product_manufactuererName_Manufacturer_manufacturerName FOREIGN KEY (manufacturerName) REFERENCES Manufacturer (manufacturerName);

ALTER TABLE Sale 
  ADD CONSTRAINT fk_Sale_productId_Product_productId FOREIGN KEY (productId) REFERENCES Product (productID) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Sale  
  ADD CONSTRAINT fk_Sale_storeNumber_Store_storeNumber FOREIGN KEY (storeNumber) REFERENCES Store (storeNumber) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE Manages
  ADD CONSTRAINT fk_Manages_managerEmail_Manager_managerEmail FOREIGN KEY (managerEmail) REFERENCES Manager (managerEmail) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Manages
 ADD CONSTRAINT fk_Manages_storeNumber_Store_storeNumber FOREIGN KEY (storeNumber) REFERENCES Store (storeNumber) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE assignedTo
  ADD CONSTRAINT fk_AssignedTo_productId_Product_productId FOREIGN KEY (productId) REFERENCES Product (productId) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE assignedTo
  ADD CONSTRAINT fk_AssignedTo_categoryName_Category_categoryName FOREIGN KEY (categoryName) REFERENCES Category (categoryName) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Holiday
  ADD CONSTRAINT fk_Holiday_productId_Product_productId FOREIGN KEY (productId) REFERENCES Product (productId) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Holiday
  ADD CONSTRAINT fk_Holiday_storeNumber_Store_storeNumber FOREIGN KEY (storeNumber) REFERENCES Store (storeNumber) ON DELETE CASCADE ON UPDATE CASCADE;
