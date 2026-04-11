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

--Load dim Product
INSERT INTO [ComputerStg].[dbo].[dim_product] (PC_Make,PC_Model,Storage_Type,RAM,Storage_Capacity)
SELECT PC_Make,PC_Model,Storage_Type,RAM,Storage_Capacity
FROM [ComputerStg].[dbo].[raw_pc_data]

--Load dim payment
INSERT INTO [ComputerStg].[dbo].[dim_payment] (Payment_Method)
SELECT Payment_Method
FROM [ComputerStg].[dbo].[raw_pc_data]

--Load dim channel
INSERT INTO [ComputerStg].[dbo].[dim_channel] (Channel)
SELECT Channel
FROM [ComputerStg].[dbo].[raw_pc_data]