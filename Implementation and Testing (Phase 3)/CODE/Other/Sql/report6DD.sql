select store.storenumber as store_number, store.streetaddress as store_address,
store.cityname as city_name, manager.managername as manager_name, manager.manageremail as manageremail
FROM store
left outer join manages on store.storenumber = manages.storenumber
left outer join manager on manages.manageremail = manager.manageremail
where state = '<state>'
ORDER BY store.storenumber



--SELECT DISTINCT * FROM
--	(SELECT
--	CONCAT(CONCAT(date_part('YEAR', Sale.saleDate) , '-' , date_part('month', Sale.saleDate)),
--	AssignedTo.categoryName
--	,Store.state) as scs_code,
--	Store.StoreNumber as Store_Number
--	,Store.streetaddress as Store_address
--	,Store.cityName as city_Name,
--	manager.managername as manager_name,
--	manages.manageremail as manager_email
--	FROM Sale
--	JOIN Store ON sale.storeNumber = Store.StoreNumber
--	JOIN AssignedTo ON Sale.productId = AssignedTo.productId
--	JOIN manages ON manages.storenumber = Store.StoreNumber
--	JOIN manager ON manager.manageremail = manages.manageremail)--as foo
--WHERE scs_code = '<scs_code>'
