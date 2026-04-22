--SP: CREATE + LOAD DIM CHANNEL

CREATE OR ALTER PROCEDURE dbo.usp_Create_Load_Dim_Channel
AS
BEGIN

    IF OBJECT_ID('dbo.dim_channel', 'U') IS NOT NULL
        DROP TABLE dbo.dim_channel;

    CREATE TABLE dbo.dim_channel
    (
        Channel_ID      INT IDENTITY(1,1) PRIMARY KEY,
        Channel         VARCHAR(100)
    );

    INSERT INTO dbo.dim_channel
    (
        Channel
    )
    SELECT DISTINCT
        Channel
    FROM dbo.raw_pc_data;
END;