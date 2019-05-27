DROP TABLE assignedto CASCADE;
DROP TABLE category CASCADE;
DROP TABLE city CASCADE;
DROP TABLE holiday CASCADE;
DROP TABLE manages CASCADE;
DROP TABLE manager CASCADE;
DROP TABLE manufacturer CASCADE;
DROP TABLE product CASCADE;
DROP TABLE sale CASCADE;
DROP TABLE store CASCADE;

CREATE TABLE manager (
  manageremail varchar (320) NOT NULL,
  managername varchar (100) NOT NULL,
  activeinactive varchar(1) NOT NULL,
  PRIMARY KEY (manageremail)
);

CREATE TABLE city (
  cityname varchar (100) NOT NULL,
  state varchar (2) NOT NULL,
  population int NOT NULL,
  PRIMARY KEY (cityname, state)
);

CREATE TABLE manufacturer (
  manufacturername varchar (100) NOT NULL,
  manufacmaxdiscount float NOT NULL,
  PRIMARY KEY (manufacturername)
);

CREATE TABLE category (
  categoryname varchar (100) NOT NULL,
  PRIMARY KEY (categoryname)
);

CREATE TABLE store (
  storenumber int  NOT NULL,
  streetaddress varchar (100) NOT NULL,
  phonenumber bigint NOT NULL,
  cityname varchar (100) NOT NULL,
  state varchar (2) NOT NULL,
  PRIMARY KEY (storenumber)
  --KEY date_time (date_time)
);

CREATE TABLE product (
  productid int  NOT NULL,
  retailprice float NOT NULL,
  productname varchar (100) NOT NULL,
  manufacturername varchar (100) NOT NULL,
  PRIMARY KEY (productid)
);

CREATE TABLE sale (
  productid int NOT NULL,
  storenumber int NOT NULL,
  saledate date NOT NULL,
  percentagediscount float NOT NULL,
  quantitypurchased float NOT NULL
);

CREATE TABLE manages (
  manageremail varchar (320) NOT NULL,
  storenumber int NOT NULL
);

CREATE TABLE assignedto (
  productid int NOT NULL,
  categoryname varchar (100) NOT NULL
);

CREATE TABLE holiday (
  holidaydate date NOT NULL,
  holidayname varchar (100) NOT NULL
);



-- CONSTRAINTs   Foreign Keys: FK_ChildTable_childColumn_ParentTable_parentColumn

ALTER TABLE store
  ADD CONSTRAINT fk_store_cityname_state_City_cityname_state FOREIGN KEY (cityname, state) REFERENCES City (cityname, state);

ALTER TABLE product
  ADD CONSTRAINT fk_product_manufactuererName_manufacturer_manufacturername FOREIGN KEY (manufacturername) REFERENCES manufacturer (manufacturername);

ALTER TABLE sale 
  ADD CONSTRAINT fk_sale_productid_product_productid FOREIGN KEY (productid) REFERENCES product (productid) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE sale  
  ADD CONSTRAINT fk_sale_storenumber_store_storenumber FOREIGN KEY (storenumber) REFERENCES store (storenumber) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE manages
  ADD CONSTRAINT fk_manages_manageremail_manager_manageremail FOREIGN KEY (manageremail) REFERENCES manager (manageremail) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE manages
 ADD CONSTRAINT fk_manages_storenumber_store_storenumber FOREIGN KEY (storenumber) REFERENCES store (storenumber) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE assignedto
  ADD CONSTRAINT fk_assignedto_productid_product_productid FOREIGN KEY (productid) REFERENCES product (productid) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE assignedto
  ADD CONSTRAINT fk_assignedto_categoryname_category_categoryname FOREIGN KEY (categoryname) REFERENCES category (categoryname) ON DELETE CASCADE ON UPDATE CASCADE;