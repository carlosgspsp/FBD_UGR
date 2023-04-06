--3.42--
SELECT codpro
FROM ventas
GROUP BY codpro HAVING COUNT(*) > (SELECT count(*) from ventas where codpro='S1');

--3.43--
SELECT codpro, SUM(cantidad)
FROM ventas
GROUP BY codpro HAVING SUM(cantidad) = (SELECT MAX(SUM(v.cantidad)) from ventas v GROUP BY v.codpro);

--3.44--
SELECT codpro
FROM proveedor
WHERE codpro!='S3' AND NOT EXISTS(
SELECT codpie FROM pieza WHERE  ciudad IN(SELECT ciudad FROM proyecto WHERE codpj IN (SELECT DISTINCT codpj FROM ventas WHERE codpro='S3'))
MINUS
SELECT codpie FROM ventas WHERE proveedor.codpro=ventas.codpro
);
 SELECT ciudad FROM proyecto WHERE codpj IN (SELECT DISTINCT codpj FROM ventas WHERE codpro='S3');


--3.45--
SELECT codpro
FROM ventas
GROUP BY codpro HAVING count(*)>10;

--3.46--
SELECT DISTINCT codpro
FROM proveedor
WHERE NOT EXISTS(
SELECT v1.codpie FROM ventas v1 WHERE v1.codpro ='S1'
MINUS
SELECT v2.codpie FROM ventas v2 WHERE proveedor.codpro =v2.codpro
);

--3.47--
SELECT SUM(cantidad), codpro
FROM ventas
GROUP BY (codpro) HAVING codpro = 
(SELECT DISTINCT v0.codpro
FROM ventas v0
WHERE NOT EXISTS(
SELECT v1.codpie FROM ventas v1 WHERE v1.codpro ='S1'
MINUS
SELECT v2.codpie FROM ventas v2 WHERE v0.codpro =v2.codpro));

--3.48--
SELECT DISTINCT proyecto.codpj 
FROM proyecto
WHERE NOT EXISTS(
SELECT v1.codpro FROM ventas v1 WHERE v1.codpie='P3'
MINUS
SELECT v2.codpro FROM ventas v2 WHERE proyecto.codpj=v2.codpj);

--3.49--
SELECT codpro, AVG(cantidad)
FROM ventas
WHERE codpro IN (SELECT DISTINCT codpro FROM ventas WHERE codpie='P3')
GROUP BY codpro;

--3.50--
select index_name, table_name, owner from all_indexes;

--3.51--
SELECT column_name,nullable,data_type,data_length FROM USER_TAB_COLUMNS WHERE table_name='VENTAS';

--3.52--
SELECT AVG(cantidad),codpro ,TO_CHAR(fecha,'YYYY')
FROM ventas
GROUP BY codpro, TO_CHAR(fecha,'YYYY');

--3.53--
SELECT DISTINCT codpro
FROM ventas
WHERE codpie IN(SELECT codpie FROM pieza WHERE color='Rojo');

--3.54--
SELECT DISTINCT codpro
FROM proveedor
WHERE NOT EXISTS(
SELECT codpie FROM pieza WHERE color='Rojo'
MINUS
SELECT codpie FROM ventas WHERE proveedor.codpro=ventas.codpro
);

--3.55--
SELECT DISTINCT codpro
FROM proveedor
WHERE NOT EXISTS(
SELECT codpie FROM ventas WHERE proveedor.codpro=ventas.codpro
MINUS
SELECT codpie FROM pieza WHERE codpie IN (SELECT codpie FROM pieza WHERE color='Rojo')

);
SELECT codpie FROM pieza WHERE color='Rojo';

--3.56--
SELECT codpro, count(*) 
FROM ventas 
WHERE codpie IN(SELECT codpie FROM pieza WHERE color='Rojo') GROUP BY codpro HAVING count(*)>1;

--3.57--
SELECT DISTINCT codpro
FROM ventas v0
WHERE NOT EXISTS(
SELECT codpie FROM pieza WHERE color='Rojo'
MINUS
SELECT v1.codpie FROM ventas v1 WHERE v0.codpro=v1.codpro
)
GROUP BY v0.codpro HAVING MIN(cantidad)>10;




--3.58--
UPDATE proveedor
SET status=1 WHERE codpro IN(
SELECT codpro FROM ventas v
WHERE NOT EXISTS
(SELECT * FROM ventas v1 WHERE v1.codpro=v.codpro AND v1.codpie!='P1'));

--3.59--



