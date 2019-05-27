SELECT
category.categoryname as category_name,
COUNT(assignedto.productid) as total_products,
COUNT(DISTINCT(product.manufacturername)) as total_manufacturers,
CAST((AVG(product.retailprice)) AS NUMERIC(18, 2)) as average_retail_price
FROM category
LEFT JOIN assignedto on category.categoryname = assignedto.categoryname
LEFT JOIN product on assignedto.productid = product.productid
GROUP BY category.categoryname;