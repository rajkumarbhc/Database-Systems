SELECT (SELECT CAST(COUNT(*) AS INT) FROM store) AS store_count,
(SELECT CAST(COUNT(*) AS INT) FROM manufacturer) AS manufacturer_count,
(SELECT CAST(COUNT(*) AS INT) FROM product) AS product_count,
(SELECT CAST(COUNT(*) AS INT) FROM manager) AS manager_count;