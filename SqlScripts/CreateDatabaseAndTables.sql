CREATE DATABASE ComputerStg

--Create Dimension tables

--Create dim customer
CREATE TABLE [ComputerStg].[dbo].[dim_customer](
	[CustomerID] INT IDENTITY (1,1) PRIMARY KEY,
	[Customer_Name] [nvarchar](50) NOT NULL,
	[Customer_Surname] [nvarchar](50) NOT NULL,
	[Customer_Contact_Number] [nvarchar](50) NOT NULL,
	[Customer_Email_Address] [nvarchar](50) NOT NULL,
	)

--Create dim location
CREATE TABLE [ComputerStg].[dbo].[dim_location](
	[LocationID] INT IDENTITY (1,1) PRIMARY KEY,
	[Continent] [nvarchar](50) NOT NULL,
	[Country_or_State] [nvarchar](50) NOT NULL,
	[Province_or_City] [nvarchar](100) NOT NULL,
	)