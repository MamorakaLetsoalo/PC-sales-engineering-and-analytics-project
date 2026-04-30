/*========================================================
STORED PROCEDURE TO LOAD FACT TABLE
- Uses INNER JOIN
- Prevents duplicates using NOT EXISTS
- Uses TRY_CONVERT for dates
========================================================*/

CREATE OR ALTER PROCEDURE [dbo].[usp_Load_Fact_PC_Sales]
AS
BEGIN
    SET NOCOUNT ON;
    TRUNCATE TABLE dbo.fact_pc_sales;

    INSERT INTO [ComputerStg].[dbo].[fact_pc_sales]
    (
        Customer_ID,
        Location_ID,
        Store_ID,
        Product_ID,
        Payment_ID,
        Channel_ID,
        Price_ID,

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
    SELECT DISTINCT
        dc.Customer_ID,
        dl.Location_ID,
        ds.Store_ID,
        dp.Product_ID,
        dpay.Payment_ID,
        dch.Channel_ID,
        dpr.Price_ID,

        r.Sales_Person_Name,
        r.Sales_Person_Department,

        r.Discount_Amount,
        TRY_CONVERT(DATE, r.Purchase_Date, 103),
        TRY_CONVERT(DATE, r.Ship_Date, 103),
        r.Finance_Amount,
        r.Credit_Score,
        r.Priority,
        r.Cost_of_Repairs,
        r.Total_Sales_per_Employee

    FROM [ComputerStg].[dbo].[raw_pc_data] r

    INNER JOIN [ComputerStg].[dbo].[dim_customer] dc
        ON r.Customer_Name = dc.Customer_Name
       AND r.Customer_Surname = dc.Customer_Surname
       AND r.Customer_Contact_Number = dc.Customer_Contact_Number
       AND r.Customer_Email_Address = dc.Customer_Email_Address

    INNER JOIN [ComputerStg].[dbo].[dim_location] dl
        ON r.Continent = dl.Continent
       AND r.Country_or_State = dl.Country_or_State
       AND r.Province_or_City = dl.Province_or_City

    INNER JOIN [ComputerStg].[dbo].[dim_store] ds
        ON r.Shop_Name = ds.Shop_Name
       AND r.Shop_Age = ds.Shop_Age

    INNER JOIN [ComputerStg].[dbo].[dim_product] dp
        ON r.PC_Make = dp.PC_Make
       AND r.PC_Model = dp.PC_Model
       AND r.Storage_Type = dp.Storage_Type
       AND r.RAM = dp.RAM
       AND r.Storage_Capacity = dp.Storage_Capacity

    INNER JOIN [ComputerStg].[dbo].[dim_payment] dpay
        ON r.Payment_Method = dpay.Payment_Method

    INNER JOIN [ComputerStg].[dbo].[dim_channel] dch
        ON r.Channel = dch.Channel

    INNER JOIN [ComputerStg].[dbo].[dim_price] dpr
        ON r.Cost_Price = dpr.Cost_Price
       AND r.Sale_Price = dpr.Sale_Price
       AND r.PC_Market_Price = dpr.PC_Market_Price;

    /*WHERE NOT EXISTS
    (
        SELECT 1
        FROM [ComputerStg].[dbo].[fact_pc_sales] f
        WHERE
            f.Customer_ID = dc.Customer_ID
            AND f.Location_ID = dl.Location_ID
            AND f.Store_ID = ds.Store_ID
            AND f.Product_ID = dp.Product_ID
            AND f.Payment_ID = dpay.Payment_ID
            AND f.Channel_ID = dch.Channel_ID
            AND f.Price_ID = dpr.Price_ID
            AND f.Purchase_Date = TRY_CONVERT(DATE, r.Purchase_Date, 103)  );*/
   

END;
