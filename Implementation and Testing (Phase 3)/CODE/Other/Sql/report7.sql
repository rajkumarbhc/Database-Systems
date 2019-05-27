SELECT year,
CAST(avg(smallRevenue) AS NUMERIC(18, 2)) AS average_Small_Revenue,
CAST(avg(medRevenue) AS NUMERIC(18, 2)) AS average_Medium_Revenue,
CAST(avg(largeRevenue) AS NUMERIC(18, 2)) AS average_Large_Revenue,
CAST(avg(xlRevenue) AS NUMERIC(18, 2)) AS average_Extra_Large_Revenue
FROM (

SELECT 
year,
Case when population < 3700000 then totalyearlyrevenue
ELSE null
END AS smallRevenue,
Case when population >= 3700000 and population < 6700000 then totalyearlyrevenue
 ELSE null
END AS medRevenue,
Case when population >= 6700000 and population < 9000000 then totalyearlyrevenue
 ELSE null
END AS largeRevenue,
Case when population >= 9000000 then totalyearlyrevenue
ELSE null
END as xlRevenue
FROM (

select city, state, population, storeid, year, sum(saleRevenue) as totalYearlyRevenue
	from (

SELECT 
City.cityname AS city,
City.state AS state,
Store.storeNumber as storeid,
City.population AS population,
Store.streetAddress AS streetAddress,
City.cityname AS cityname,	
(1-Sale.percentageDiscount)*Product.retailPrice*Sale.quantityPurchased as saleRevenue,
date_part('year', Sale.saleDate) AS year

FROM Store
JOIN City
ON Store.state = City.state and Store.cityname = City.cityname
JOIN Sale
ON Store.storeNumber = Sale.storeNumber
JOIN Product
ON Sale.productID = Product.productID
	
	) as raw 

group by city, state, population, year, storeID
) as pivoted
	
) as pivoted_avg
							   
GROUP BY year order BY year ASC;