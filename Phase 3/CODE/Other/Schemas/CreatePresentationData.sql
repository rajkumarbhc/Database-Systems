--Make sure to change each file path to your own directory to load these files.
--If you get a permissions error go to the second answer of this stack overflow link and do what they say
--Link: https://stackoverflow.com/questions/14083311/permission-denied-when-trying-to-import-a-csv-file-from-pgadmin

COPY manager(manageremail, managername, activeinactive)
FROM 'C:\\Users\\daron\\OneDrive\\CSE_6400\\Data_Warehouse_App_Testing\\Phase 3\\CODE\\Other\\team08_sampleData\\manager.csv' DELIMITER ',' CSV HEADER;

COPY city(cityname, state, population)
FROM 'C:\\Users\\daron\\OneDrive\\CSE_6400\\Data_Warehouse_App_Testing\\Phase 3\\CODE\\Other\\team08_sampleData\\city.csv' DELIMITER ',' CSV HEADER;

COPY manufacturer(manufacturername, manufacmaxdiscount)
FROM 'C:\\Users\\daron\\OneDrive\\CSE_6400\\Data_Warehouse_App_Testing\\Phase 3\\CODE\\Other\\team08_sampleData\\manufacturer.csv' DELIMITER ',' CSV HEADER;

COPY category(categoryname)
FROM 'C:\\Users\\daron\\OneDrive\\CSE_6400\\Data_Warehouse_App_Testing\\Phase 3\\CODE\\Other\\team08_sampleData\\category.csv' DELIMITER ',' CSV HEADER;

COPY store(storenumber, streetaddress, phonenumber, cityname, state)
FROM 'C:\\Users\\daron\\OneDrive\\CSE_6400\\Data_Warehouse_App_Testing\\Phase 3\\CODE\\Other\\team08_sampleData\\store.csv' DELIMITER ',' CSV HEADER;

COPY product(productid, retailprice, productname, manufacturername)
FROM 'C:\\Users\\daron\\OneDrive\\CSE_6400\\Data_Warehouse_App_Testing\\Phase 3\\CODE\\Other\\team08_sampleData\\product.csv' DELIMITER ',' CSV HEADER;

COPY sale(productid, storenumber, saledate, percentagediscount, quantitypurchased)
FROM 'C:\\Users\\daron\\OneDrive\\CSE_6400\\Data_Warehouse_App_Testing\\Phase 3\\CODE\\Other\\team08_sampleData\\sale.csv' DELIMITER ',' CSV HEADER;

COPY manages(manageremail, storenumber)
FROM 'C:\\Users\\daron\\OneDrive\\CSE_6400\\Data_Warehouse_App_Testing\\Phase 3\\CODE\\Other\\team08_sampleData\\manages.csv' DELIMITER ',' CSV HEADER;

COPY assignedto(productid, categoryname)
FROM 'C:\\Users\\daron\\OneDrive\\CSE_6400\\Data_Warehouse_App_Testing\\Phase 3\\CODE\\Other\\team08_sampleData\\assignedto.csv' DELIMITER ',' CSV HEADER;

COPY holiday(holidaydate, holidayname)
FROM 'C:\\Users\\daron\\OneDrive\\CSE_6400\\Data_Warehouse_App_Testing\\Phase 3\\CODE\\Other\\team08_sampleData\\holiday.csv' DELIMITER ',' CSV HEADER