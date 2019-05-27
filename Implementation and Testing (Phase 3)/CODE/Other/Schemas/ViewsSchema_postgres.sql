--New report 6 view
CREATE VIEW RPT_6 AS
(SELECT CONCAT(CONCAT(date_part('year', saledate),'-',date_part('month', saledate)),
categoryname,
state) as scs_code,
CONCAT(date_part('year', saledate),'-',date_part('month', saledate)) as sale_date,
categoryname, state, sum(quantitypurchased)
from											  
(select *
from sale
join assignedto on sale.productid = assignedto.productid
join store on sale.storenumber = store.storenumber) as foo
group by categoryname, state, sale_date);


CREATE VIEW report6_view AS
SELECT
CONCAT(CONCAT(date_part('year', sale_date),'-',date_part('month', sale_date)),
Category_Name,
state) as scs_code,
CONCAT(date_part('year', sale_date),'-',date_part('month', sale_date)) as sale_date,
Category_Name,
state,
MAX(Max_Units_Sold) AS Max_Units_Sold
FROM
(SELECT
    sale.saledate as sale_date,
    AssignedTo.categoryName AS Category_Name,
	Store.state AS state,
	SUM(sale.quantityPurchased) AS Max_Units_Sold
FROM sale
JOIN AssignedTo ON sale.productId = AssignedTo.productId
JOIN Store ON sale.storeNumber = Store.StoreNumber
GROUP BY sale.saledate, Store.state, AssignedTo.categoryName) Total
GROUP BY sale_date, Category_Name, state
ORDER BY Category_Name ASC;



CREATE VIEW report6_view_summary AS
select * from report6_view
where (category_name, max_units_sold) in (select  category_name, max(max_units_sold) as max_units from report6_view group by category_name)
order by category_name asc;

--CREATE VIEW report6_view_drilldown AS
--SELECT distinct
--CONCAT(CONCAT(date_part('YEAR', Sale.saleDate) , '-' , date_part('month', Sale.saleDate)),
--AssignedTo.categoryName
--,Store.state) as scs_code
--,Store.StoreNumber as Store_Number
--,Store.streetaddress as Store_address
--,Store.cityName as city_Name,
--manager.managername as manager_name,
--manages.manageremail as manager_email
--FROM Sale
--JOIN Store ON Store.storeNumber = Store.StoreNumber
--JOIN AssignedTo ON Sale.productId = AssignedTo.productId
--JOIN manages ON manages.storenumber = Store.StoreNumber
--JOIN manager ON manager.manageremail = manages.manageremail;
