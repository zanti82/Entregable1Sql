use rambed_ecommerce;

select * from clientes;

SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'C:\Users\ZANTI82 LNV\Desktop\CODER git\Entregable1Sql\ClientesNuevos.cvs'
INTO TABLE clientes
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- revisamos la lsiat nueva
select * from clientes;