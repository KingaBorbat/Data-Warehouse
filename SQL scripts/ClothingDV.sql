-- Data Vault
CREATE DATABASE ClothingDV;

USE ClothingDV;
GO


DROP TABLE IF EXISTS SAT_SalesProducts;
DROP TABLE IF EXISTS SAT_Subcategories;
DROP TABLE IF EXISTS SAT_Stores;
DROP TABLE IF EXISTS SAT_Sales;
DROP TABLE IF EXISTS SAT_Products;
DROP TABLE IF EXISTS SAT_Locations;
DROP TABLE IF EXISTS SAT_Fabrics;
DROP TABLE IF EXISTS SAT_Customers;
DROP TABLE IF EXISTS SAT_Categories;
DROP TABLE IF EXISTS LINK_ProductsSubcategories;
DROP TABLE IF EXISTS LINK_Sales;
DROP TABLE IF EXISTS LINK_CategorySubcategory;
DROP TABLE IF EXISTS LINK_SalesProducts;
DROP TABLE IF EXISTS LINK_StoresLocations;
DROP TABLE IF EXISTS LINK_ProductsFabrics;
DROP TABLE IF EXISTS LINK_CustomersLocations;
DROP TABLE IF EXISTS LINK_LocationsCounties;
DROP TABLE IF EXISTS LINK_CountiesCountries;
DROP TABLE IF EXISTS HUB_Subcategories;
DROP TABLE IF EXISTS HUB_Stores;
DROP TABLE IF EXISTS HUB_Sales;
DROP TABLE IF EXISTS HUB_Products;
DROP TABLE IF EXISTS HUB_Locations;
DROP TABLE IF EXISTS HUB_Fabrics;
DROP TABLE IF EXISTS HUB_Customers;
DROP TABLE IF EXISTS HUB_Categories;

CREATE TABLE HUB_Categories(
	h_category_PK INT IDENTITY(1, 1) NOT NULL,
	h_category_BK INT NOT NULL,
	h_cat_RSRSC VARCHAR(10),
	h_cat_LDTS DATETIME,
	CONSTRAINT PK_HUB_Categories PRIMARY KEY(h_category_PK)
);

CREATE TABLE HUB_Customers(
	h_customer_PK INT IDENTITY(1, 1) NOT NULL,
	h_customer_BK BIGINT NOT NULL,
	h_customer_RSRSC VARCHAR(10),
	h_customer_LDTS DATETIME,
	CONSTRAINT PK_HUB_Customers PRIMARY KEY(h_customer_PK)
);

CREATE TABLE HUB_Fabrics(
	h_fabric_PK INT IDENTITY(1, 1) NOT NULL,
	h_fabric_BK INT NOT NULL,
	h_fabric_RSRSC VARCHAR(10),
	h_fabric_LDTS DATETIME,
	CONSTRAINT PK_HUB_Fabrics PRIMARY KEY(h_fabric_PK)
);

CREATE TABLE HUB_Locations(
	h_location_PK INT IDENTITY(1, 1) NOT NULL,
	h_location_BK INT NOT NULL,
	h_location_RSRC VARCHAR(10),
	h_location_LDTS DATETIME,
	CONSTRAINT PK_HUB_Locations PRIMARY KEY(h_location_PK)
);

CREATE TABLE HUB_Products(
	h_product_PK INT IDENTITY(1, 1) NOT NULL,
	h_product_BK INT NOT NULL,
	h_product_RSRC VARCHAR(10),
	h_product_LDTS DATETIME,
	CONSTRAINT PK_HUB_Products PRIMARY KEY(h_product_PK)
);

CREATE TABLE HUB_Sales(
	h_sale_PK INT IDENTITY(1, 1) NOT NULL,
	h_sale_BK INT NOT NULL,
	h_sale_RSRC VARCHAR(10),
	h_sale_LDTS DATETIME,
	CONSTRAINT PK_HUB_Sales PRIMARY KEY(h_sale_PK)
);

CREATE TABLE HUB_Stores(
	h_store_PK INT IDENTITY(1, 1) NOT NULL,
	h_store_BK INT NOT NULL,
	h_store_RSRC VARCHAR(10),
	h_store_LDTS DATETIME,
	CONSTRAINT PK_HUB_Stores PRIMARY KEY(h_store_PK)
);

CREATE TABLE HUB_Subcategories(
	h_subcategory_PK INT IDENTITY(1, 1) NOT NULL,
	h_subcategory_BK INT NOT NULL,
	h_subcategory_RSRC VARCHAR(10),
	h_subcategory_LDTS DATETIME,
	CONSTRAINT PK_HUB_Subcategories PRIMARY KEY(h_subcategory_PK)
);

CREATE TABLE LINK_CustomersLocations(
	l_customersLocations_PK INT IDENTITY(1, 1) NOT NULL,
	l_customersLocations_RSRC VARCHAR(10),
	l_customersLocations_LDTS DATETIME,
	h_customer_PK INT NOT NULL,
	h_location_PK INT NOT NULL,
	CONSTRAINT FK_LINK_CustomersLocations_Location FOREIGN KEY(h_location_PK) REFERENCES HUB_Locations(h_location_PK),
	CONSTRAINT FK_LINK_CustomersLocations_Customer FOREIGN KEY(h_customer_PK) REFERENCES HUB_Customers(h_customer_PK),
	CONSTRAINT PK_LINK_CustomersLocations PRIMARY KEY(l_customersLocations_PK)
);

CREATE TABLE LINK_ProductsFabrics(
	l_productsFabrics_PK INT IDENTITY(1, 1) NOT NULL,
	l_productsFabrics_RSRC VARCHAR(10),
	l_productsFabrics_LDTS DATETIME,
	h_product_PK INT NOT NULL,
	h_fabric_PK INT NOT NULL,
	CONSTRAINT FK_LINK_ProductsFabrics_Product FOREIGN KEY(h_product_PK) REFERENCES HUB_Products(h_product_PK),
	CONSTRAINT FK_LINK_ProductsFabrics_Fabric FOREIGN KEY(h_fabric_PK) REFERENCES HUB_Fabrics(h_fabric_PK),
	CONSTRAINT PK_LINK_ProductsFabrics PRIMARY KEY(l_productsFabrics_PK)
);

CREATE TABLE LINK_StoresLocations(
	l_storesLocations_PK INT IDENTITY(1, 1) NOT NULL,
	l_storesLocations_RSRC VARCHAR(10),
	l_storesLocations_LDTS DATETIME,
	h_store_PK INT NOT NULL,
	h_location_PK INT NOT NULL,
	CONSTRAINT FK_LINK_StoresLocations_Location FOREIGN KEY(h_location_PK) REFERENCES HUB_Locations(h_location_PK),
	CONSTRAINT FK_LINK_StoresLocations_Store FOREIGN KEY(h_store_PK) REFERENCES HUB_Stores(h_store_PK),
	CONSTRAINT PK_LINK_StoresLocations PRIMARY KEY(l_storesLocations_PK)
);

CREATE TABLE LINK_SalesProducts(
	l_salesProducts_PK INT IDENTITY(1, 1) NOT NULL,
	l_salesProducts_RSRC VARCHAR(10),
	l_salesProducts_LDTS DATETIME,
	h_sale_PK INT NOT NULL,
	h_product_PK INT NOT NULL,
	CONSTRAINT FK_LINK_SalesProducts_Sale FOREIGN KEY(h_sale_PK) REFERENCES HUB_Sales(h_sale_PK),
	CONSTRAINT FK_LINK_SalesProducts_Product FOREIGN KEY(h_product_PK) REFERENCES HUB_Products(h_product_PK),
	CONSTRAINT PK_LINK_SalesProducts PRIMARY KEY(l_salesProducts_PK)
);

CREATE TABLE LINK_CategorySubcategory(
	l_categoriesSubcategories_PK INT IDENTITY(1, 1) NOT NULL,
	l_categoriesSubcategories_RSRC VARCHAR(10),
	l_categoriesSubcategories_LDTS DATETIME,
	h_category_PK INT NOT NULL,
	h_subcategory_PK INT NOT NULL,
	CONSTRAINT FK_LINK_CategorySubcategory_Cat FOREIGN KEY(h_category_PK) REFERENCES HUB_Categories(h_category_PK),
	CONSTRAINT FK_LINK_CategorySubcategory_Subcat FOREIGN KEY(h_subcategory_PK) REFERENCES HUB_Subcategories(h_subcategory_PK),
	CONSTRAINT PK_LINK_CategorySubcategory PRIMARY KEY(l_categoriesSubcategories_PK)
);

CREATE TABLE LINK_Sales(
	l_salesStores_PK INT IDENTITY(1, 1) NOT NULL,
	l_salesStores_RSRC VARCHAR(10),
	l_salesStores_LDTS DATETIME,
	h_sale_PK INT NOT NULL,
	h_store_PK INT NOT NULL,
	h_customer_PK INT NOT NULL,
	CONSTRAINT FK_LINK_Sales_Customer FOREIGN KEY(h_customer_PK) REFERENCES HUB_Customers(h_customer_PK),
	CONSTRAINT FK_LINK_Sales_Sale FOREIGN KEY(h_sale_PK) REFERENCES HUB_Sales(h_sale_PK),
	CONSTRAINT FK_LINK_Sales_Store FOREIGN KEY(h_store_PK) REFERENCES HUB_Stores(h_store_PK),
	CONSTRAINT PK_LINK_Sales PRIMARY KEY(l_salesStores_PK)
);


CREATE TABLE LINK_ProductsSubcategories(
	l_productsSubcategories_PK INT IDENTITY(1, 1) NOT NULL,
	l_productsSubcategories_RSRC VARCHAR(10),
	l_productsSubcategories_LDTS DATETIME,
	h_product_PK INT NOT NULL,
	h_subcategory_PK INT NOT NULL,
	CONSTRAINT FK_LINK_ProductSubcategory_Prod FOREIGN KEY(h_product_PK) REFERENCES HUB_Products(h_product_PK),
	CONSTRAINT FK_LINK_ProductSubcategory_Subcat FOREIGN KEY(h_subcategory_PK) REFERENCES HUB_Subcategories(h_subcategory_PK),
	CONSTRAINT PK_LINK_ProductSubcategory PRIMARY KEY(l_productsSubcategories_PK)
);

CREATE TABLE SAT_Categories(
	h_category_PK INT NOT NULL,
	category VARCHAR(100),
	category_gender VARCHAR(10),
	s_cat_RSRSC VARCHAR(10),
	s_cat_LDTS DATETIME,
	CONSTRAINT FK_SAT_Categories FOREIGN KEY(h_category_PK) REFERENCES HUB_Categories(h_category_PK), 
	CONSTRAINT PK_SAT_Categories PRIMARY KEY(h_category_PK, s_cat_LDTS)
);

CREATE TABLE SAT_Customers(
	h_customer_PK INT NOT NULL,
	customer_name VARCHAR(100),
	customer_email VARCHAR(100),
	customer_phone VARCHAR(10),
	customer_gender VARCHAR(10),
	customer_size VARCHAR(10),
	s_customer_RSRSC VARCHAR(10),
	s_customer_LDTS DATETIME,
	CONSTRAINT FK_SAT_Customers FOREIGN KEY(h_customer_PK) REFERENCES HUB_Customers(h_customer_PK), 
	CONSTRAINT PK_SAT_Customers PRIMARY KEY(h_customer_PK, s_customer_LDTS)
);

CREATE TABLE SAT_Fabrics(
	h_fabric_PK INT NOT NULL,
	fabric_name VARCHAR(50),
	s_fabric_RSRSC VARCHAR(10),
	s_fabric_LDTS DATETIME,
	CONSTRAINT FK_SAT_Fabrics FOREIGN KEY(h_fabric_PK) REFERENCES HUB_Fabrics(h_fabric_PK), 
	CONSTRAINT PK_SAT_Fabrics PRIMARY KEY(h_fabric_PK, s_fabric_LDTS)
);

CREATE TABLE SAT_Locations(
	h_location_PK INT NOT NULL,
	location_name VARCHAR(100),
	county_name VARCHAR(100),
	country_name VARCHAR(100),
	s_location_RSRC VARCHAR(10),
	s_location_LDTS DATETIME,
	CONSTRAINT FK_SAT_Locations FOREIGN KEY(h_location_PK) REFERENCES HUB_Locations(h_location_PK), 
	CONSTRAINT PK_SAT_Locations PRIMARY KEY(h_location_PK, s_location_LDTS)
);

CREATE TABLE SAT_Products(
	h_product_PK INT NOT NULL,
	product_name VARCHAR(100),
	product_color VARCHAR(50),
	product_pattern VARCHAR(50),
	product_price INT,
	s_product_RSRC VARCHAR(10),
	s_product_LDTS DATETIME,
	CONSTRAINT FK_SAT_Products FOREIGN KEY(h_product_PK) REFERENCES HUB_Products(h_product_PK), 
	CONSTRAINT PK_SAT_Products PRIMARY KEY(h_product_PK, s_product_LDTS)
);

CREATE TABLE SAT_Sales(
	l_sale_PK INT NOT NULL,
	sale_date DATE,
	h_sale_RSRC VARCHAR(10),
	h_sale_LDTS DATETIME,
	CONSTRAINT FK_SAT_Sales FOREIGN KEY(l_sale_PK) REFERENCES LINK_Sales(l_salesStores_PK), 
	CONSTRAINT PK_SAT_Sales PRIMARY KEY(l_sale_PK, h_sale_LDTS)
);

CREATE TABLE SAT_Stores(
	h_store_PK INT NOT NULL,
	store_name VARCHAR(100),
	store_address VARCHAR(100),
	s_store_RSRC VARCHAR(10),
	s_store_LDTS DATETIME,
	CONSTRAINT FK_SAT_Stores FOREIGN KEY(h_store_PK) REFERENCES HUB_Stores(h_store_PK),
	CONSTRAINT PK_SAT_Stores PRIMARY KEY(h_store_PK, s_store_LDTS)
);

CREATE TABLE SAT_Subcategories(
	h_subcategory_PK INT NOT NULL,
	subcategory_name VARCHAR(100),
	s_subcategory_RSRC VARCHAR(10),
	s_subcategory_LDTS DATETIME,
	CONSTRAINT FK_SAT_Subcategories FOREIGN KEY(h_subcategory_PK) REFERENCES HUB_Subcategories(h_subcategory_PK),
	CONSTRAINT PK_SAT_Subcategories PRIMARY KEY(h_subcategory_PK, s_subcategory_LDTS)
);

CREATE TABLE SAT_SalesProducts(
	l_salesProducts_PK INT NOT NULL,
	price INT,
	quantity INT,
	size VARCHAR(10),
	s_salesProducts_RSRC VARCHAR(10),
	s_salesProducts_LDTS DATETIME,
	CONSTRAINT FK_SAT_SalesProducts FOREIGN KEY(l_salesProducts_PK) REFERENCES LINK_SalesProducts(l_salesProducts_PK),
	CONSTRAINT PK_SAT_SalesProducts PRIMARY KEY(l_salesProducts_PK, s_salesProducts_LDTS)
);

