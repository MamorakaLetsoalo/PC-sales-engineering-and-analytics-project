--SP: CREATE + LOAD DIM STORE

CREATE OR ALTER PROCEDURE dbo.usp_Create_Load_Dim_Store
AS
BEGIN

    IF OBJECT_ID('dbo.dim_store', 'U') IS NOT NULL
        DROP TABLE dbo.dim_store;

    CREATE TABLE dbo.dim_store
    (
        Store_ID            INT IDENTITY(1,1) PRIMARY KEY,
        Shop_Name           VARCHAR(255),
        Shop_Age            INT
    );

    INSERT INTO dbo.dim_store
    (
        Shop_Name,
        Shop_Age
    )
    SELECT DISTINCT
        Shop_Name,
        Shop_Age
    FROM dbo.raw_pc_data;
END;