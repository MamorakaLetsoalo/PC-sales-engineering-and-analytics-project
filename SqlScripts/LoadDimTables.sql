--Load Dimension  tables

--Load customer table
INSERT INTO [ComputerStg].[dbo].[dim_customer]
(Customer_Name,Customer_Surname,Customer_Contact_Number,Customer_Email_Address)
SELECT Customer_Name,Customer_Surname,Customer_Contact_Number,Customer_Email_Address
FROM [ComputerStg].[dbo].[raw_pc_data]

