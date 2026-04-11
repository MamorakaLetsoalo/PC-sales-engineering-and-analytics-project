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

--Create dim store
CREATE TABLE [ComputerStg].[dbo].[dim_store](
	[StoreID] INT IDENTITY (1,1) PRIMARY KEY,
	[Shop_Name] [nvarchar](50) NOT NULL,
	[Shop_Age] [int] NOT NULL,
	)

--Create dim product
CREATE TABLE [ComputerStg].[dbo].[dim_product](
	[ProductID] INT IDENTITY (1,1) PRIMARY KEY,
	[PC_Make] [nvarchar](50) NOT NULL,
	[PC_Model] [nvarchar](50) NOT NULL,
	[Storage_Type] [nvarchar](50) NOT NULL,
	[RAM] [nvarchar](50) NOT NULL,
	[Storage_Capacity] [nvarchar](50) NOT NULL
	)

--Create dim payment
CREATE TABLE [ComputerStg].[dbo].[dim_payment](
	[PaymentID] INT IDENTITY (1,1) PRIMARY KEY,
	[Payment_Method] [nvarchar](50) NOT NULL,
	)

--Create dim channel
CREATE TABLE [ComputerStg].[dbo].[dim_channel](
	[ChannelID] INT IDENTITY (1,1) PRIMARY KEY,
	[Channel] [nvarchar](50) NOT NULL,
	)

--Create dim price
CREATE TABLE [ComputerStg].[dbo].[dim_price](
	[PriceID] INT IDENTITY (1,1) PRIMARY KEY,
	[Cost_Price] [int] NOT NULL,
	[Sale_Price] [int] NOT NULL,
	[PC_Market_Price] [int] NOT NULL,
	)