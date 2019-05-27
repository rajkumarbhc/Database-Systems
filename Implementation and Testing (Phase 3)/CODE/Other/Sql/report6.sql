select scs_code, sale_date, categoryname, state, sum as units_sold from RPT_6
WHERE (sale_date, categoryname, sum) in
(select sale_date, categoryname, max(sum) from RPT_6
where sale_date = '<sale_date>'
group by categoryname, sale_date)

--select * from report6_view
--where (category_name, max_units_sold) in
--(select
-- 	category_name,
-- 	max(max_units_sold) as max_units 
-- 	from report6_view
--	where sale_date = '<sale_date>'
-- 	group by category_name)
--AND sale_date = '<sale_date>'
--order by category_name
