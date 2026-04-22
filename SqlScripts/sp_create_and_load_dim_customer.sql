
 --SP: CREATE + LOAD DIM CUSTOMER


 CREATE OR ALTER PROCEDURE dbo.usp_Create_Load_Dim_Customer
AS
BEGIN
 
   IF OBJECT_ID('dbo.dim_customer', 'U') IS NOT NULL
        DROP TABLE dbo.dim_customer;

    CREATE TABLE dbo.dim_customer
    (
        Customer_ID                 INT IDENTITY(1,1) PRIMARY KEY,
        Customer_Name               VARCHAR(200),
        Customer_Surname            VARCHAR(200),
        Customer_Contact_Number     VARCHAR(50),
        Customer_Email_Address      VARCHAR(255)
    );

    INSERT INTO dbo.dim_customer
    (
        Customer_Name,
        Customer_Surname,
        Customer_Contact_Number,
        Customer_Email_Address
    )
    SELECT DISTINCT
        Customer_Name,
        Customer_Surname,
        Customer_Contact_Number,
        Customer_Email_Address
    FROM dbo.raw_pc_data;
END;