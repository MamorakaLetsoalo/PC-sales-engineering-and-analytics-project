--SP: CREATE + LOAD DIM PAYMENT

CREATE OR ALTER PROCEDURE dbo.usp_Create_Load_Dim_Payment
AS
BEGIN

    IF OBJECT_ID('dbo.dim_payment', 'U') IS NOT NULL
        DROP TABLE dbo.dim_payment;

    CREATE TABLE dbo.dim_payment
    (
        Payment_ID          INT IDENTITY(1,1) PRIMARY KEY,
        Payment_Method      VARCHAR(100)
    );

    INSERT INTO dbo.dim_payment
    (
        Payment_Method
    )
    SELECT DISTINCT
        Payment_Method
    FROM dbo.raw_pc_data;
END;