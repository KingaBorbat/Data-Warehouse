--OLAP reports

USE ClothingDM;
GO

-- Contains data for the reports
CREATE TABLE Sales(
	ProductName VARCHAR(100),
	ProductBK INT,
	ProductSK INT,
	ProductGender VARCHAR(10),
	CategoryName VARCHAR(100),
	SubcategoryName VARCHAR(100),
	SaleYear INT,
	CustomerBK BIGINT,
	CustomerName VARCHAR(100),
	CustomerLocation VARCHAR(100),
	StoreLocation VARCHAR(100),
	StoreBK INT,
	StoreName VARCHAR(100),
	Price INT,
	Quantity INT
)

INSERT INTO Sales
SELECT 
    DP.productName, 
    DP.BK_Product, 
    FS.SK_Product, 
	DC.gender,
    DC.categoryName, 
    DS.subcategory_name, 
    DD.dateYear, 
    DCU.BK_Customer, 
    DCU.customerName, 
    DLC.locationName AS CustomerLocation,
    DLS.locationName AS StoreLocation,
    DST.BK_Store,
    DST.storeName,
    FS.price,
    FS.quantity
FROM 
    FACT_Sales FS
JOIN 
    DIM_Product DP ON FS.SK_Product = DP.SK_Product
JOIN 
    DIM_Subcategory DS ON DP.SK_Subcategory = DS.SK_Subcategory
JOIN 
    DIM_Category DC ON DS.SK_Category = DC.SK_Category
JOIN 
    DIM_Date DD ON FS.SK_Date = DD.SK_Date
JOIN 
    DIM_Customer DCU ON FS.SK_Customer = DCU.SK_Customer
JOIN 
    DIM_Location DLC ON FS.SK_CustomerLocation = DLC.SK_Location
JOIN 
    DIM_Location DLS ON FS.SK_StoreLocation = DLS.SK_Location
JOIN 
    DIM_Store DST ON FS.SK_Store = DST.SK_Store

--1. Ranks the sales within each product category, broken down by year.
SELECT 
    CategoryName, 
	SaleYear,
    SUM(Price) AS pricePerCategory,
    RANK() OVER (PARTITION BY SaleYear ORDER BY SUM(Price) DESC) AS cat_rank
FROM 
    Sales
GROUP BY CategoryName, SaleYear;


--2. Selects the top 10 subcategories by sales
SELECT 
    SubcategoryName, 
    ProductGender,
    pricePerSubCategory,
    rowNumber
FROM (
    SELECT 
        SubcategoryName, 
        ProductGender,
        SUM(Price) AS pricePerSubCategory,
        ROW_NUMBER() OVER (PARTITION BY ProductGender ORDER BY SUM(Price) DESC) AS rowNumber
    FROM 
        Sales
    GROUP BY 
        SubcategoryName, 
        ProductGender
) AS R
WHERE 
    rowNumber <= 10;

--3. Selects the first 5 five customers (who spent the most) in every store
SELECT 
	CustomerBK,
	CustomerName,
	StoreLocation,
	StoreName,
	pricePerCategory,
	row_num
FROM (SELECT 
		CustomerBK,
		CustomerName,
		StoreLocation,
		StoreName,
		SUM(Price) AS pricePerCategory,
		ROW_NUMBER() OVER (PARTITION BY StoreName ORDER BY SUM(Price) DESC) AS row_num
	FROM 
		Sales
	GROUP BY StoreName, StoreLocation, CustomerBK, CustomerName) R
WHERE row_num <= 5;

--4. Ranks sales within years, broken down by locations.
SELECT 
	SaleYear,
    StoreLocation, 
    SUM(Price) AS pricePerCategory,
    RANK() OVER (PARTITION BY StoreLocation ORDER BY SUM(Price) DESC) AS year_rank
FROM 
    Sales
GROUP BY StoreLocation, SaleYear;

--5. Ranks sales by material, broken down by years
WITH FabricSales AS (
    SELECT 
        DF.fabricName AS Fabric,
        S.SaleYear AS SaleYear,
        SUM(S.price) AS TotalPrice
    FROM 
        DIM_Fabric DF
    JOIN 
        BRIDGE_ProductFabric BDF ON DF.SK_Fabric = BDF.SK_Fabric
    JOIN 
        Sales S ON S.ProductSK = BDF.SK_BridgeProdFabr
    GROUP BY 
        DF.fabricName,
        S.SaleYear
) 
SELECT 
    Fabric,
    SaleYear,
    TotalPrice,
    RANK() OVER (PARTITION BY SaleYear ORDER BY TotalPrice DESC) AS FabricRank
FROM 
    FabricSales;

--6. Ranks the store locations by sales, broken down by years
SELECT 
    StoreLocation, 
	SaleYear,
    SUM(Price) AS pricePerCategory,
    RANK() OVER (PARTITION BY SaleYear ORDER BY SUM(Price) DESC) AS store_rank
FROM 
    Sales
GROUP BY StoreLocation, SaleYear;

--7. Divides the products into five parts based on how much of each was sold.
SELECT 
    ProductBK, 
	ProductName,
    SUM(Quantity) AS quantity,
    NTILE(5) OVER (ORDER BY SUM(Quantity) DESC) AS ntile5
FROM 
    Sales
GROUP BY ProductBK, ProductName;

--8. Selects the first 5 stores, broken down by years
SELECT 
	SaleYear,
	StoreLocation,
	StoreName,
	price,
	row_num
FROM (SELECT 
		StoreLocation,
		StoreName,
		SaleYear,
		SUM(Price) AS price,
		ROW_NUMBER() OVER (PARTITION BY SaleYear ORDER BY SUM(Price) DESC) AS row_num
	FROM 
		Sales
	GROUP BY SaleYear, StoreName, StoreLocation) R
WHERE row_num <= 5;