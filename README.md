# Data Warehouse Project

## Overview

This repository contains a comprehensive data warehouse project developed as part of a Business Intelligence course. The project integrates, stores, and analyzes sales data from two sources using SQL Server Integration Services (SSIS) for ETL processes and SQL Server Analysis Services (SSAS) for multidimensional analysis.

## Project Structure

The repository is organized into the following structure:

- `Staging Area/`: Contains SSIS packages for extracting and loading data from MySQL and Excel to the Staging Area (SA) in SQL Server.
- `Data Vault/`: Contains SSIS packages for transforming and loading data from the Staging Area (SA) to the Data Vault (DV) in SQL Server.
- `Data Mart/`: Contains SSIS packages for transforming and loading data from the Data Vault (DV) to the Data Marts (DM) in SQL Server.
- `SSAS/`: Contains files for the SSAS project, which creates OLAP cubes for sales data analysis.
- `generate_data.py`: Python script for generating synthetic data.
- `SQL scripts/`: Contains SQL scripts for setting up the databases.

## Setup Instructions

### Project Requirements

- **Python**: Ensure you have Python installed to run the data generation script.
- **Microsoft Excel**: Required for accessing and manipulating Excel files.
- **MySQL**: Install MySQL Server, MySQL Workbench and ODBC Connector.
- **SQL Server**: Install with Full option for Analysis Services.
- **Visual Studio**: Install Visual Studio and the following tools: SQL Server Integration Services Projects, Microsoft Reporting Services Projects (if you want to make report in Visual Studio), Microsoft Analysis Services Projects.

### Step-by-Step Guide

#### 1. Generate Data

1. Ensure you have Python installed.
2. Run the `mysql_source.sql` script in MySQL to create the source database named `clothingstore`.
3. Run the Python script to generate synthetic data.
4. If you regenerate data don't forget to delete the Excel file and the data from the database.

#### 2. SSIS projects

1. Run the `ClothingSA.sql`, `ClothingDV.sql` and `ClothingDM.sql`.
2. Create three new Integration Services Projects: one for loading data from sources to Staging Area, one for loading the Data Vault, and one for loading the Data Mart.
3. Add the existing packages from the folders to the corresponding projects.
4. Configure the connection managers:

- 4.1. Create two data sources:
  - for the MySQL `clothingstore` database: MySQL's configuration guide: https://dev.mysql.com/doc/connector-odbc/en/connector-odbc-configuration-dsn-windows-5-2.html. The data source name used for the project was `MySQL data source` (this might make it easier to configure it in Visual Studio). You find the user and password in the `SQL Scripts/mysql_source.sql`.
  - for the MSSQL `ClothingSA` database: Go to the **ODBC Data Sources Administrator** -> **Add** -> Choose **SQL Server** -> Specifiy the name (for the project it was `MSSQL SA`) and server (the name of your MSSQL server) -> **Next** -> Check the **Windows NT authentication** (if it's not checked by default) -> **Next** -> Change default database to `ClothingSA` -> **Next** -> **Finish** -> **Test Data Source**.
- 4.2. Update the configuration managers in Visual Studio if needed.
- 4.3. Create an **Excel Connection Manager** for the **Staging Area** Excel source.

5. Run the packages in the projects in the corresponding order.

#### 3. SSAS

1. Run the `SQL scripts/grantPermissions.sql` to create the user for the service account.
2. Create an **Analysis Services Multidimensional Project** in Visual Studio and add the files from `SSAS` folder to the project.
3. Create a new connection string with **SQL Server Native Client** provider for the **Data Source**, choose the `ClothingDM` database.
4. Process the dimensions.
5. Processs the cube.
6. Connect to the **Analysis Services Server** in MSSQL Server Managment Studio. Under the databases you will find the SSAS database and you can start creating reports.
