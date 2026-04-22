--SP: CREATE + LOAD DIM PRICE

CREATE OR ALTER PROCEDURE dbo.usp_Create_Load_Dim_Price
AS
BEGIN

    IF OBJECT_ID('dbo.dim_price', 'U') IS NOT NULL
        DROP TABLE dbo.dim_price;

    CREATE TABLE dbo.dim_price
    (
        Price_ID            INT IDENTITY(1,1) PRIMARY KEY,
        Cost_Price          DECIMAL(18,2),
        Sale_Price          DECIMAL(18,2),
        PC_Market_Price     DECIMAL(18,2)
    );

    INSERT INTO dbo.dim_price
    (
        Cost_Price,
        Sale_Price,
        PC_Market_Price
    )
    SELECT DISTINCT
        Cost_Price,
        Sale_Price,
        PC_Market_Price
    FROM dbo.raw_pc_data;
END;