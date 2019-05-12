SELECT
state,
storeID as store_id,
streetAddress as street_address,
cityname as city_name,
year,
CAST(sum(saleRevenue) AS NUMERIC(18, 2)) as revenue
FROM 
(SELECT
Store.state as state,
Store.StoreNumber as storeID,
Store.streetAddress as streetAddress, Store.cityName as cityName,
(1 - Sale.percentageDiscount) * Product.retailPrice * Sale.quantityPurchased as saleRevenue, date_part('year', Sale.saleDate) as year
FROM Store
join Sale on Store.storeNumber = Sale.storeNumber
join Product on Sale.productId = Product.productId) 

as total
WHERE state = <state>
GROUP BY state, storeID, streetAddress, cityName, year
ORDER BY year ASC, revenue DESC;
