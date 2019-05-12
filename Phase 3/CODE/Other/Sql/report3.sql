SELECT * FROM
(SELECT
b.productId as product_id,
b.productName as product_name,
b.retailPrice as retail_price,
SUM(b.saleItemsPurchased) as sale_Items_Purchased,
SUM(b.fullPriceItemsPurchased) as full_Price_Items_Purchased,
sum(b.saleItemsPurchased) + sum(b.fullPriceItemsPurchased) as total_items_purchased,
CAST((SUM(b.actualRevenue)) AS NUMERIC(18, 2)) as actual_Revenue,
SUM(b.predictedRevenue) as predicted_Revenue,
CAST((SUM(actualRevenue) - SUM(predictedRevenue)) AS NUMERIC(18, 2)) as revenue_Difference
FROM (SELECT
a.productId,
a.productName,
a.retailPrice,
CASE WHEN a.onSale = 1 then SUM(a.quantityPurchased) else null
end as saleItemsPurchased,
CASE WHEN a.onSale = 0 then SUM(a.quantityPurchased) else null
end as fullPriceItemsPurchased,
SUM(a.actualRevenue) as actualRevenue,
SUM(a.predictedRevenue) as predictedRevenue
FROM (SELECT
Sale.productId,
Product.productName,
Product.retailPrice,
Sale.quantityPurchased,
Sale.percentageDiscount, 
Product.retailPrice * (1 - Sale.percentageDiscount) * Sale.quantityPurchased as actualRevenue, CASE WHEN percentageDiscount != 0 then Product.retailPrice * (0.75 * Sale.quantityPurchased) else Product.retailPrice * Sale.quantityPurchased
end as predictedRevenue,
CASE WHEN percentageDiscount != 0 then 1 else 0 end as onSale
FROM Sale
Join Product on
Sale.productId = Product.productId
Join AssignedTo on
Product.productId = AssignedTo.productId
WHERE AssignedTo.categoryName = 'GPS') as a
GROUP BY productId, productName, retailPrice, onSale) as b
GROUP BY productId, productName, retailPrice) as c
WHERE c.revenue_difference > 5000 OR c.revenue_difference < -5000
ORDER BY c.revenue_difference DESC;
														