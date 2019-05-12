SELECT 
	a.manufacturerName as manufacturer_name, 
	COUNT(b.productId) as Product_Count, 
	CAST((AVG(b.retailPrice)) AS NUMERIC(18, 2)) as Average_Retail_Price,
	MIN(b.retailPrice) as Minimum_Retail_Price, 
	MAX(b.retailPrice) as Maximum_Retail_Price
FROM 
	Manufacturer as a
INNER JOIN 
	Product as b
	ON a.manufacturername = b.manufacturername
GROUP BY 
	a.manufacturerName
ORDER BY 
	Average_Retail_Price DESC
LIMIT 100;
