SELECT date_part('year', Sale.saleDate) as Sales_Year,
SUM(Sale.quantityPurchased) as total_Items_Sold_per_year,
SUM(case when date_part('month', Sale.saleDate) = 2 and date_part('day', Sale.saleDate) = 2 and AssignedTo.categoryname = 'Air Conditioner'
	then Sale.quantityPurchased else null end)
as Total_Items_Sold_on_Groundhog_Day,
CAST((SUM(Sale.quantityPurchased)/365) AS NUMERIC(18, 2)) as Average_Units_Sold_per_day
From Sale
JOIN AssignedTo ON Sale.productId = AssignedTo.productId
WHERE AssignedTo.categoryname = 'Air Conditioner'
GROUP BY date_part('year', Sale.saleDate)
ORDER BY date_part('year', Sale.saleDate) ASC;