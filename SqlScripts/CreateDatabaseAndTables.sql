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