--SP:SALES FACTS

CREATE OR ALTER PROCEDURE dbo.usp_Load_Fact_PC_Sales
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE dbo.fact_pc_sales;

    ;WITH CleanedData AS
    (
        SELECT
            r.*,
            TRY_CONVERT(DATE, r.Purchase_Date, 103) AS Clean_Purchase_Date,
            TRY_CONVERT(DATE, r.Ship_Date, 103) AS Clean_Ship_Date
        FROM dbo.raw_pc_data r
        WHERE
            TRY_CONVERT(DATE, r.Purchase_Date, 103) IS NOT NULL
            AND TRY_CONVERT(DATE, r.Ship_Date, 103) IS NOT NULL
    )

    INSERT INTO dbo.fact_pc_sales
    (
        CustomerID,
        LocationID,
        StoreID,
        ProductID,
        PaymentID,
        ChannelID,
        PriceID,
        Sales_Person_Name,
        Sales_Person_Department,
        Discount_Amount,
        Purchase_Date,
        Ship_Date,
        Finance_Amount,
        Credit_Score,
        Priority,
        Cost_of_Repairs,
        Total_Sales_per_Employee
    )
    SELECT
        dc.Customer_ID,
        dl.Location_ID,
        ds.Store_ID,
        dp.Product_ID,
        dpay.Payment_ID,
        dch.Channel_ID,
        dpr.Price_ID,
        c.Sales_Person_Name,
        c.Sales_Person_Department,
        c.Discount_Amount,
        c.Clean_Purchase_Date,
        c.Clean_Ship_Date,
        c.Finance_Amount,
        c.Credit_Score,
        c.Priority,
        c.Cost_of_Repairs,
        c.Total_Sales_per_Employee
    FROM CleanedData c
    INNER JOIN dbo.dim_customer dc
        ON c.Customer_Name = dc.Customer_Name
       AND c.Customer_Surname = dc.Customer_Surname
    INNER JOIN dbo.dim_location dl
        ON c.Continent = dl.Continent
       AND c.Country_or_State = dl.Country_or_State
       AND c.Province_or_City = dl.Province_or_City
    INNER JOIN dbo.dim_store ds
        ON c.Shop_Name = ds.Shop_Name
    INNER JOIN dbo.dim_product dp
        ON c.PC_Make = dp.PC_Make
       AND c.PC_Model = dp.PC_Model
    INNER JOIN dbo.dim_payment dpay
        ON c.Payment_Method = dpay.Payment_Method
    INNER JOIN dbo.dim_channel dch
        ON c.Channel = dch.Channel
    INNER JOIN dbo.dim_price dpr
        ON c.Cost_Price = dpr.Cost_Price
       AND c.Sale_Price = dpr.Sale_Price;
END;
GO