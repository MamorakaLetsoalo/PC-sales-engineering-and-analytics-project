--SP: CREATE + LOAD DIM LOCATION

CREATE OR ALTER PROCEDURE dbo.usp_Create_Load_Dim_Location
AS
BEGIN

    IF OBJECT_ID('dbo.dim_location', 'U') IS NOT NULL
        DROP TABLE dbo.dim_location;

    CREATE TABLE dbo.dim_location
    (
        Location_ID             INT IDENTITY(1,1) PRIMARY KEY,
        Continent               VARCHAR(100),
        Country_or_State        VARCHAR(200),
        Province_or_City        VARCHAR(200)
    );

    INSERT INTO dbo.dim_location
    (
        Continent,
        Country_or_State,
        Province_or_City
    )
    SELECT DISTINCT
        Continent,
        Country_or_State,
        Province_or_City
    FROM dbo.raw_pc_data;
END;