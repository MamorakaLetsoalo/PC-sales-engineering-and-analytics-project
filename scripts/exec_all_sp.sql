EXEC [dbo].[usp_Create_Load_Dim_Customer]
EXEC dbo.usp_Create_Load_Dim_Location
EXEC dbo.usp_Create_Load_Dim_Store
EXEC dbo.usp_Create_Load_Dim_Product
EXEC dbo.usp_Create_Load_Dim_Payment
EXEC dbo.usp_Create_Load_Dim_Channel
EXEC dbo.usp_Create_Load_Dim_Price

EXEC dbo.usp_Load_Fact_PC_Sales

SELECT * FROM [dbo].[fact_pc_sales]

