--Just creating this so we have the basic shell of the drill down.
--Once we figure out how to drill down on specific manufacturers should be simple to make changes to this query.
SELECT
	--c.manufacturername as manufacturer_name,
	--c.manufacMaxDiscount as manufacturer_Max_Discount,
	a.productId as product_id,
	a.productName as product_name,
	STRING_AGG(b.categoryName, ', ') as Categories,
	a.retailPrice as retail_price	
FROM
	Product as a
	INNER JOIN AssignedTo as b
	ON a.productId = b.productId
	INNER JOIN Manufacturer as c
	ON a.manufacturerName = c.manufacturerName
WHERE c.manufacturername = '<manufacturername>'
GROUP BY
	c.manufacturername, a.productId, a.productName, a.retailPrice, c.manufacMaxDiscount
ORDER BY 
	a.retailPrice DESC;
