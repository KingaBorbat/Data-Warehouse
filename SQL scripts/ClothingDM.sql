-- Data Mart
CREATE DATABASE ClothingDM;

USE ClothingDM;
GO

DROP TABLE IF EXISTS FACT_Sales;
DROP TABLE IF EXISTS DIM_Date;
DROP TABLE IF EXISTS DIM_Store;
DROP TABLE IF EXISTS DIM_Location;
DROP TABLE IF EXISTS DIM_Customer;
DROP TABLE IF EXISTS BRIDGE_ProductFabric;
DROP TABLE IF EXISTS DIM_Product;
DROP TABLE IF EXISTS DIM_Fabric;
DROP TABLE IF EXISTS DIM_Subcategory;
DROP TABLE IF EXISTS DIM_Category;

CREATE TABLE DIM_Category(
	SK_Category INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	BK_Category INT,
	categoryName VARCHAR(100),
	gender VARCHAR(10)
);

CREATE TABLE DIM_Subcategory(
	SK_Subcategory INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	SK_Category INT FOREIGN KEY REFERENCES DIM_Category(SK_Category),
	BK_Subcategory INT,
	subcategory_name VARCHAR(100)
);

CREATE TABLE DIM_Product(
	SK_Product INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	BK_Product INT,
	SK_Subcategory INT FOREIGN KEY REFERENCES DIM_Subcategory(SK_Subcategory),
	productName VARCHAR(100),
	productSize VARCHAR(10),
	productColor VARCHAR(50),
	productPattern VARCHAR(50),
	productPrice INT
);

CREATE TABLE DIM_Fabric(
	SK_Fabric INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	BK_Fabric INT,
	fabricName VARCHAR(50)
);

CREATE TABLE BRIDGE_ProductFabric(
	SK_BridgeProdFabr INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	SK_Fabric INT FOREIGN KEY REFERENCES DIM_Fabric(SK_Fabric),
	SK_Product INT FOREIGN KEY REFERENCES DIM_Product(SK_Product)
);


CREATE TABLE DIM_Customer(
	SK_Customer INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	BK_Customer BIGINT,
	customerName VARCHAR(100),
	customerEmail VARCHAR(100),
	customerPhone VARCHAR(10),
	customerGender VARCHAR(10),
	customerSize VARCHAR(10)
);

CREATE TABLE DIM_Location(
	SK_Location INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	BK_Location INT,
	locationName VARCHAR(100),
	countyName VARCHAR(100),
	countryName VARCHAR(50)
);

CREATE TABLE DIM_Store(
	SK_Store INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	BK_Store INT,
	storeName VARCHAR(100),
	storeAddress VARCHAR(100)
);

CREATE TABLE DIM_Date(
	SK_Date INT NOT NULL PRIMARY KEY,
	dateYear INT,
	dateSemester INT,
	dateQuarter INT,
	dateMonth INT,
	dateMonthName VARCHAR(50),
	dateDayOfTheMonth INT,
	dateWeekDay VARCHAR(50),
	
);


CREATE TABLE FACT_Sales(
	SK_Product INT FOREIGN KEY REFERENCES DIM_Product(SK_Product),
	SK_Date INT FOREIGN KEY REFERENCES DIM_Date(SK_Date),
	SK_Customer INT FOREIGN KEY REFERENCES DIM_Customer(SK_Customer),
	SK_Store INT FOREIGN KEY REFERENCES DIM_Store(SK_Store),
	SK_CustomerLocation INT FOREIGN KEY REFERENCES DIM_Location(SK_Location),
	SK_StoreLocation INT FOREIGN KEY REFERENCES DIM_Location(SK_Location),
	quantity INT,
	price INT
);

