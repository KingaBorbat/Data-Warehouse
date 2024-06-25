DROP DATABASE IF exists ClothingStore;
CREATE DATABASE ClothingStore;

CREATE USER IF NOT EXISTS 'clothing-user'@'localhost' IDENTIFIED BY 'clothing-pass';
GRANT ALL PRIVILEGES ON * . * TO 'clothing-user'@'localhost';
FLUSH PRIVILEGES;

USE ClothingStore;

DROP TABLE IF EXISTS SaleDetails;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS FabricDetails;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Stores;
DROP TABLE IF EXISTS SubCategories;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Fabrics;
DROP TABLE IF EXISTS Locations;
DROP TABLE IF EXISTS Counties;
DROP TABLE IF EXISTS Countries;

CREATE TABLE Countries(
	countryID INT NOT NULL auto_increment,
    country VARCHAR(200) UNIQUE,
    PRIMARY KEY( countryID )
);

CREATE TABLE Counties (
	countyID INT NOT NULL auto_increment,
    county VARCHAR(200) UNIQUE,
    countryID INT NOT NULL,
    
    PRIMARY KEY( countyID ),
    FOREIGN KEY( countryID )
		REFERENCES Countries( countryID )
);

CREATE TABLE Locations (
	locationID INT NOT NULL AUTO_INCREMENT,
    location VARCHAR(200) UNIQUE,
    countyID INT NOT NULL,
    
    PRIMARY KEY( locationID ),
    FOREIGN KEY( countyID )
		REFERENCES Counties( countyID )
);

CREATE TABLE Fabrics (
	fabricID INT NOT NULL AUTO_INCREMENT,
    fabric VARCHAR(100) UNIQUE,
    
    PRIMARY KEY( fabricID )
);

CREATE TABLE Customers (
	customerID BIGINT NOT NULL,
    customerName VARCHAR(200) NOT NULL,
	email VARCHAR(100),
    phoneNumber VARCHAR(10),
    gender VARCHAR(10), 
    locationID INT NOT NULL, 
	size VARCHAR(10),
    PRIMARY KEY( customerID ),
    FOREIGN KEY( locationID ) REFERENCES Locations( locationID )
);

CREATE TABLE Categories(
	categoryID INT NOT NULL AUTO_INCREMENT,
    category VARCHAR(100),
    gender VARCHAR(10),
    
    PRIMARY KEY( categoryID )
);

CREATE TABLE SubCategories(
	subcategoryID INT NOT NULL AUTO_INCREMENT,
    subCategory VARCHAR(100),
    categoryID INT NOT NULL,
    
    PRIMARY KEY(subcategoryID),
    FOREIGN KEY( categoryID ) REFERENCES Categories( categoryID )
);

CREATE TABLE Stores(
	storeID INT NOT NULL AUTO_INCREMENT,
    storeName VARCHAR(100),
    locationID INT NOT NULL,
    address VARCHAR(512),    
    PRIMARY KEY( storeID ),
    FOREIGN KEY( locationID ) REFERENCES Locations( locationID )
);

CREATE TABLE Products (
	productID INT NOT NULL AUTO_INCREMENT,
    productName VARCHAR(100),
    color VARCHAR(50),
    pattern VARCHAR(100),
    price INT,
    subcategoryID INT,
    PRIMARY KEY( productID ),
    FOREIGN KEY( subcategoryID ) REFERENCES Subcategories( subcategoryID ) 
);

CREATE TABLE FabricDetails(
	fabricdetailsID INT NOT NULL AUTO_INCREMENT,
    fabricID INT NOT NULL,
    productID INT NOT NULL,
    PRIMARY KEY( fabricdetailsID ),
    FOREIGN KEY( fabricID ) REFERENCES Fabrics( fabricID ),
    FOREIGN KEY( productID ) REFERENCES Products( productID )
);

CREATE TABLE Sales(
	saleID INT NOT NULL AUTO_INCREMENT,
    customerID BIGINT NOT NULL, 
    storeID INT NOT NULL,
    saleDate DATE NOT NULL,
    
    PRIMARY KEY( saleID ),
    FOREIGN KEY( customerID ) REFERENCES Customers( customerID ),
    FOREIGN KEY( storeID ) REFERENCES Stores( storeID )
);

CREATE TABLE SaleDetails(
	saleDetailID INT NOT NULL AUTO_INCREMENT,
    saleID INT NOT NULL,
    productID INT NOT NULL, 
    quantity INT NOT NULL,
    price INT NOT NULL,
    size VARCHAR(10),
    PRIMARY KEY( saleDetailID ),
    FOREIGN KEY( saleID ) REFERENCES Sales( saleID ),
    FOREIGN KEY( productID ) REFERENCES Products( productID )
)


