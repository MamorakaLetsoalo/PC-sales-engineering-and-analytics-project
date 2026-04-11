--Load Dimension  tables


--Load customer table
INSERT INTO [ComputerStg].[dbo].[dim_customer]
(Customer_Name,Customer_Surname,Customer_Contact_Number,Customer_Email_Address)
SELECT Customer_Name,Customer_Surname,Customer_Contact_Number,Customer_Email_Address
FROM [ComputerStg].[dbo].[raw_pc_data]

--Load dim loaction
INSERT INTO [ComputerStg].[dbo].[dim_location] (Continent,Country_or_State, Province_or_City)
SELECT Continent,Country_or_State,Province_or_City
FROM [ComputerStg].[dbo].[raw_pc_data]

--Load dim store
INSERT INTO [ComputerStg].[dbo].[dim_store] (Shop_Name,Shop_Age )
SELECT Shop_Name,Shop_Age
FROM [ComputerStg].[dbo].[raw_pc_data]


