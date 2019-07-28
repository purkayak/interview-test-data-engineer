  
-- ------------------------------------------------------------------------------------
-- SQL script for importing Customer Order Data into a MySQL database.
-- ------------------------------------------------------------------------------------

DROP DATABASE IF EXISTS Customer_Order_Transactions;

CREATE DATABASE Customer_Order_Transactions;

USE Customer_Order_Transactions;

DROP TABLE IF EXISTS Region;
CREATE TABLE Region(
	r_regionkey INT(10) NOT NULL,
	r_name VARCHAR(100),
	r_comment VARCHAR(500),
	CONSTRAINT PK_Region PRIMARY KEY (r_regionkey)
);

DROP TABLE IF EXISTS Nation;
CREATE TABLE Nation(
	n_nationkey INT(10) NOT NULL,
	n_name VARCHAR(100),
	n_regionkey INT (10)  NOT NULL,
	n_comment VARCHAR(500),
	CONSTRAINT PK_Nation PRIMARY KEY (n_nationkey),
	FOREIGN KEY (c_regionkey) REFERENCES Nation(r_regionkey)
);

DROP TABLE IF EXISTS Part;
CREATE TABLE Part (
	p_partkey INT(10) NOT NULL,
	p_name VARCHAR(100),
	p_mfgr VARCHAR(500),
	p_brand VARCHAR (100),
	p_type VARCHAR(25),
	p_size INT(10),
	p_container VARCHAR(100),
	p_retailprice DECIMAL(10,2),
	p_comment VARCHAR(500),
	CONSTRAINT PK_Par PRIMARY KEY (p_partkey)
);

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
	c_custkey INT(10) NOT NULL,
	c_name VARCHAR(100),
	c_address VARCHAR(500),
	c_nationkey INT (10) NOT NULL,
	c_phone VARCHAR(25),
	c_acctbal DECIMAL(10,2),
	c_mktsegment VARCHAR(100),
	c_comment VARCHAR(500),
	CONSTRAINT PK_Customer PRIMARY KEY (c_custkey),
	FOREIGN KEY (c_nationkey) REFERENCES Nation(n_nationkey)
);

DROP TABLE IF EXISTS Supplier;
CREATE TABLE Supplier (
	s_suppkey INT(10) NOT NULL,
	s_name VARCHAR(100),
	s_address VARCHAR(500),
	s_nationkey INT (10) NOT NULL,
	s_phone VARCHAR(25),
	s_acctbal DECIMAL(10,2),
	s_comment VARCHAR(500),
	CONSTRAINT PK_Supplier PRIMARY KEY (s_suppkey),
	FOREIGN KEY (c_nationkey) REFERENCES Nation(n_nationkey)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
	o_orderkey INT(10) NOT NULL,
	o_custkey INT(10) NOT NULL,
	o_orderstatus VARCHAR(1),
	o_totalprice DECIMAL(10,2),
	o_orderdate DATE,
	o_orderpriority VARCHAR(25),
	o_clerk VARCHAR(25), --This column should be clerk and not cleark?
	o_shippriority VARCHAR(25),
	o_comment VARCHAR(500),
	CONSTRAINT PK_Orders PRIMARY KEY (o_orderkey),
	FOREIGN KEY (c_custkey) REFERENCES Customer(c_custkey)
);

DROP TABLE IF EXISTS Partsupp;
CREATE TABLE Partsupp (
	ps_id INT(10) NOT NULL,
	ps_partkey INT(10) NOT NULL,
	ps_suppkey INT(10) NOT NULL,
	ps_availqty DECIMAL(10,2),
	ps_suppcost DECIMAL(10,2),
	ps_comment VARCHAR(500),
	CONSTRAINT PK_Partsupp PRIMARY KEY (ps_id),
	FOREIGN KEY (ps_partkey) REFERENCES Part(p_partkey),
	FOREIGN KEY (ps_suppkey) REFERENCES Supplier(s_suppkey)
);

DROP TABLE IF EXISTS Lineitem;
CREATE TABLE Partsupp (
	l_id INT(10) NOT NULL,
	l_orderkey INT(10) NOT NULL,
	l_ps_id INT(10) NOT NULL,
	l_linenumber INT(10);
	l_quantity DECIMAL(10,2),
	l_extendedprice DECIMAL(10,2),
	l_discount DECIMAL(10,2),
	l_tax DECIMAL(10,2),
	l_returnflag VARCHAR(1),
	l_linestatus VARCHAR(4),
	l_shipdate DATE,
	l_commitdate DATE,
	l_shipinstruct VARCHAR(50),
	l_shipmode VARCHAR(10),
	l_comment VARCHAR(500),
	CONSTRAINT PK_Lineitem PRIMARY KEY (l_id),
	FOREIGN KEY (l_orderkey) REFERENCES Part(o_orderkey),
	FOREIGN KEY (l_ps_id) REFERENCES Partsupp(ps_id)
);


----------------------------------------------------------------------------------
-- LOAD DATA to Transaction DB
----------------------------------------------------------------------------------

LOAD DATA INFILE 'Region.tbl' INTO TABLE Region
	FIELDS TERMINATED BY '|'
	--ENCLOSED BY '"' 
	LINES TERMINATED BY '|\n'
	--IGNORE 1 LINES
	;

LOAD DATA INFILE 'Nation.tbl' INTO TABLE Nation
	FIELDS TERMINATED BY '|'
	--ENCLOSED BY '"' 
	LINES TERMINATED BY '|\n'
	--IGNORE 1 LINES
	;
	
LOAD DATA INFILE 'Part.tbl' INTO TABLE Part
	FIELDS TERMINATED BY '|'
	--ENCLOSED BY '"' 
	LINES TERMINATED BY '|\n'
	--IGNORE 1 LINES
	;
	
LOAD DATA INFILE 'Customer.tbl' INTO TABLE Customer
	FIELDS TERMINATED BY '|'
	--ENCLOSED BY '"' 
	LINES TERMINATED BY '|\n'
	--IGNORE 1 LINES
	;

LOAD DATA INFILE 'Supplier.tbl' INTO TABLE Supplier
	FIELDS TERMINATED BY '|'
	--ENCLOSED BY '"' 
	LINES TERMINATED BY '|\n'
	--IGNORE 1 LINES
	;

LOAD DATA INFILE 'Orders.tbl' INTO TABLE Orders
	FIELDS TERMINATED BY '|'
	--ENCLOSED BY '"' 
	LINES TERMINATED BY '|\n'
	--IGNORE 1 LINES
	;

LOAD DATA INFILE 'Partsupp.tbl' INTO TABLE Partsupp
	FIELDS TERMINATED BY '|'
	--ENCLOSED BY '"' 
	LINES TERMINATED BY '|\n'
	--IGNORE 1 LINES
	;
	
LOAD DATA INFILE 'Lineitem.tbl' INTO TABLE Lineitem
	FIELDS TERMINATED BY '|'
	--ENCLOSED BY '"' 
	LINES TERMINATED BY '|\n'
	--IGNORE 1 LINES
	;
	
	
	
-----------------------------------------------------------------------------------------------
-- CREATE and LOAD data in Customer Orders Mart	
-----------------------------------------------------------------------------------------------

DROP DATABASE IF EXISTS Customer_Order_Mart;

CREATE DATABASE Customer_Order_Mart;

USE Customer_Order_Mart;

DROP TABLE IF EXISTS d_region;
CREATE TABLE d_region(
	r_regionid INT(10) NOT NULL,
	r_name VARCHAR(100),
	r_comment VARCHAR(500),
	CONSTRAINT PK_Region PRIMARY id (r_regionid)
);

DROP TABLE IF EXISTS d_nation;
CREATE TABLE d_nation(
	n_nationid INT(10) NOT NULL,
	n_name VARCHAR(100),
	n_regionid INT (10)  NOT NULL,
	n_comment VARCHAR(500),
	CONSTRAINT PK_Nation PRIMARY id (n_nationid),
	FOREIGN id (c_regionid) REFERENCES d_nation(r_regionid)
);

DROP TABLE IF EXISTS d_part;
CREATE TABLE d_part (
	p_partid INT(10) NOT NULL,
	p_name VARCHAR(100),
	p_mfgr VARCHAR(500),
	p_brand VARCHAR (100),
	p_type VARCHAR(25),
	p_size INT(10),
	p_container VARCHAR(100),
	p_retailprice DECIMAL(10,2),
	p_comment VARCHAR(500),
	CONSTRAINT PK_Par PRIMARY id (p_partid)
);

DROP TABLE IF EXISTS d_customer;
CREATE TABLE d_customer(
	c_custid INT(10) NOT NULL,
	c_name VARCHAR(100),
	c_address VARCHAR(500),
	c_nationid INT (10) NOT NULL,
	c_phone VARCHAR(25),
	c_acctbal DECIMAL(10,2),
	c_mktsegment VARCHAR(100),
	c_comment VARCHAR(500),
	c_acctbal_level DECIMAL(10,2), --balance level field for high, low, medium
	CONSTRAINT PK_Customer PRIMARY id (c_custid),
	FOREIGN id (c_nationid) REFERENCES d_nation(n_nationid)
);

DROP TABLE IF EXISTS d_supplier;
CREATE TABLE d_supplier (
	s_suppid INT(10) NOT NULL,
	s_name VARCHAR(100),
	s_address VARCHAR(500),
	s_nationid INT (10) NOT NULL,
	s_phone VARCHAR(25),
	s_acctbal DECIMAL(10,2),
	s_comment VARCHAR(500),
	CONSTRAINT PK_Supplier PRIMARY id (s_suppid),
	FOREIGN id (c_nationid) REFERENCES d_nation(n_nationid)
);

DROP TABLE IF EXISTS f_order_dtl;
CREATE TABLE f_order_dtl (
	r_regionid INT(10) NOT NULL,
	n_nationid INT(10) NOT NULL,
	c_custid INT(10) NOT NULL,
	p_partid INT(10) NOT NULL,
	o_orderid INT(10) NOT NULL,
	l_lineitem INT(10) NOT NULL,
	s_suppid INT(10) NOT NULL,
	o_orderstatus VARCHAR(1),
	o_totalprice DECIMAL(10,2),
	o_orderdate DATE,
	o_orderpriority VARCHAR(25),
	o_shippriority VARCHAR(25),
	l_linenumber INT(10);
	l_quantity DECIMAL(10,2),
	l_extendedprice DECIMAL(10,2),
	l_discount DECIMAL(10,2),
	l_tax DECIMAL(10,2),
	l_revenue DECIMAL(10,2),
	l_returnflag VARCHAR(1),
	l_linestatus VARCHAR(4),
	l_shipdate DATE,
	l_commitdate DATE,
	l_shipinstruct VARCHAR(50),
	l_shipmode VARCHAR(10),
	FOREIGN id (r_regionid) REFERENCES d_region(r_regionid),
	FOREIGN id (n_nationid) REFERENCES d_nation(n_nationid)
	FOREIGN id (c_custid) REFERENCES d_customer(c_custid),
	FOREIGN id (p_partid) REFERENCES d_part(p_partid),
	FOREIGN id (s_suppid) REFERENCES d_supplier(s_suppid)
)
	PARTITION BY RANGE ( YEAR(o_orderdate) ) 
(
    PARTITION p1 VALUES LESS THAN (SYSDATE - 730), ---values older than 
    PARTITION p2 VALUES LESS THAN MAXVALUE --DEFAULT for over 2 years data
);


----------------------------------------------------------------------------------
-- LOAD DATA to Mart
----------------------------------------------------------------------------------


INSERT INTO d_region SELECT * FROM Customer_Order_Transactions.region;
INSERT INTO d_nation SELECT * FROM Customer_Order_Transactions.nation;
INSERT INTO d_part SELECT * FROM Customer_Order_Transactions.part;

INSERT INTO d_customer SELECT c.*, 
	case WHEN c_acctbal < 10000 THEN 'L'
		WHEN c_acctbal > 10000 and  c_acctbal < 99999 THEN 'M'
		WHEN c_acctbal > 100000 THEN 'H'
		END as c_acctbal_level
 FROM Customer_Order_Transactions.customer c;
 
INSERT INTO d_supplier SELECT * FROM Customer_Order_Transactions.supplier;

INSERT INTO  f_order_dtl
SELECT 
	r_regionid ,
	n_nationid ,
	c_custid ,
	p_partid ,
	o_orderid ,
	l_lineitem ,
	s_suppid ,
	o_orderstatus ,
	o_totalprice ,
	o_orderdate ,
	o_orderpriority ,
	o_shippriority ,
	l_linenumber ,
	l_quantity ,
	l_extendedprice ,
	l_discount ,
	l_tax ,
	(l_extendedprice -l_discount + l_tax) as l_revenue
	l_returnflag ,
	l_linestatus ,
	l_shipdate ,
	l_commitdate ,
	l_shipinstruct ,
	l_shipmode 
FROM 
 d_region r , d_nation n, d_customer c, d_part p, d_supplier s, orders o, lineitem l
WHERE r.r_regionid = n.n_regionid
 AND  n.n_nationid = c.c_nationid
 AND c.c_custid = o.o_custid
 AND o.o_orderid = l.l_orderid
 	;

