--Create facts table

IF OBJECT_ID('dbo.fact_pc_sales', 'U') IS NOT NULL
    DROP TABLE dbo.fact_pc_sales;
GO

CREATE TABLE dbo.fact_pc_sales
(
    Fact_ID                         INT IDENTITY(1,1) PRIMARY KEY,

    Customer_ID                     INT,
    Location_ID                     INT,
    Store_ID                        INT,
    Product_ID                      INT,
    Payment_ID                      INT,
    Channel_ID                      INT,
    Price_ID                        INT,

    Sales_Person_Name               VARCHAR(200),
    Sales_Person_Department         VARCHAR(200),

    Discount_Amount                 DECIMAL(18,2),
    Purchase_Date                   DATE,
    Ship_Date                       DATE,
    Finance_Amount                  DECIMAL(18,2),
    Credit_Score                    INT,
    Priority                        VARCHAR(100),
    Cost_of_Repairs                 DECIMAL(18,2),
    Total_Sales_per_Employee        DECIMAL(18,2)


);