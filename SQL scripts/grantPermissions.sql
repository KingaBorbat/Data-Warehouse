-- Creating login and user that belongs to the service account running SSAS
CREATE LOGIN [NT SERVICE\MSSQLServerOLAPService] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO

USE ClothingDM
GO

CREATE USER [OlapService] FOR LOGIN [NT SERVICE\MSSQLServerOLAPService] WITH DEFAULT_SCHEMA=[dbo]
GO

-- Granting permissions
GRANT SELECT ON BRIDGE_ProductFabric TO OlapService
GRANT SELECT ON DIM_Category TO OlapService
GRANT SELECT ON DIM_Customer TO OlapService
GRANT SELECT ON DIM_Date TO OlapService
GRANT SELECT ON DIM_Fabric TO OlapService
GRANT SELECT ON DIM_Location TO OlapService
GRANT SELECT ON DIM_Product TO OlapService
GRANT SELECT ON DIM_Store TO OlapService
GRANT SELECT ON DIM_Subcategory TO OlapService
GRANT SELECT ON FACT_Sales TO OlapService