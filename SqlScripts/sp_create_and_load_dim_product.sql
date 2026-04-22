--SP: CREATE + LOAD DIM PRODUCT

CREATE OR ALTER PROCEDURE dbo.usp_Create_Load_Dim_Product
AS
BEGIN

    IF OBJECT_ID('dbo.dim_product', 'U') IS NOT NULL
        DROP TABLE dbo.dim_product;

    CREATE TABLE dbo.dim_product
    (
        Product_ID              INT IDENTITY(1,1) PRIMARY KEY,
        PC_Make                 VARCHAR(200),
        PC_Model                VARCHAR(200),
        Storage_Type            VARCHAR(100),
        RAM                     VARCHAR(100),
        Storage_Capacity        VARCHAR(100)
    );

    INSERT INTO dbo.dim_product
    (
        PC_Make,
        PC_Model,
        Storage_Type,
        RAM,
        Storage_Capacity
    )
    SELECT DISTINCT
        PC_Make,
        PC_Model,
        Storage_Type,
        RAM,
        Storage_Capacity
    FROM dbo.raw_pc_data;
END;