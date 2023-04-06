--3.1--
Select distinct ciudad from proyecto;

--3.2--
Select * FROM ventas;

--3.3--
SELECT codpie FROM pieza WHERE (color = 'Gris' OR color = 'Rojo') AND ciudad = 'Madrid';

--3.4--
SELECT codpro,codpie,codpj,cantidad FROM ventas WHERE cantidad <= 300 AND cantidad >= 200;

--3.5--
SELECT codpie,nompie FROM pieza where nompie LIKE '_ornillo%';

--3.6--
SELECT table_name
FROM ALL_TABLES
WHERE TABLE_NAME LIKE '%VENTAS';

--3.7--
(SELECT ciudad from proveedor where status>2)
        INTERSECT
(SELECT ciudad from pieza where codpie!='P1');

--3.8--
SELECT codpj from ventas minus SELECT codpj FROM ventas where codpj!='S1';

--3.9--
SELECT ciudad from proveedor UNION SELECT ciudad from proyecto UNION SELECT ciudad from pieza;

--3.10--
SELECT ciudad from proveedor UNION ALL SELECT ciudad from proyecto UNION ALL SELECT ciudad from pieza;

--3.11--
SELECT * FROM ventas, proveedor;

--3.12--
SELECT proveedor.codpro, pieza.codpie, proyecto.codpj 
FROM proveedor, proyecto, pieza, ventas
WHERE (proveedor.ciudad=proyecto.ciudad AND proyecto.ciudad=pieza.ciudad) 
AND (proveedor.codpro=ventas.codpro AND pieza.codpie=ventas.codpie AND proyecto.codpj=ventas.codpj); 

--3.13--
SELECT p.codpro, p2.codpro
FROM proveedor p, proveedor p2
WHERE p.codpro < p2.codpro AND p.ciudad!=p2.ciudad;

--3.14--
SELECT *
FROM pieza 
MINUS 
SELECT p1.* FROM pieza p1, pieza p2
WHERE p1.peso < p2.peso;

--EJEMPLO 3.12--
SELECT nompro, cantidad
FROM proveedor NATURAL JOIN(SELECT * FROM ventas WHERE cantidad>800);

--3.15--
SELECT DISTINCT codpie
FROM ventas NATURAL JOIN(SELECT * FROM proveedor WHERE ciudad='Madrid' );

--3.16--
SELECT ciudad, codpie
FROM ventas, (SELECT codpj, codpro, proyecto.ciudad 
FROM proveedor, proyecto
WHERE proveedor.ciudad=proyecto.ciudad) p
WHERE ventas.codpj=p.codpj AND ventas.codpro=p.codpro;

--3.17--
SELECT nompro
FROM proveedor
ORDER BY nompro;

--3.18--
SELECT *
FROM ventas
ORDER BY cantidad, fecha desc;

--3.19--
SELECT codpie
FROM ventas
WHERE codpro IN (SELECT codpro FROM proveedor where ciudad='Madrid');

--3.20--
SELECT DISTINCT codpj
FROM proyecto
where ciudad in (SELECT ciudad FROM pieza);

SELECT DISTINCT codpj
FROM ventas
where codpj in (SELECT codpj FROM proyecto, pieza WHERE proyecto.ciudad = pieza.ciudad);


--3.21--
SELECT codpj
FROM proyecto
MINUS SELECT codpj FROM ventas 
WHERE codpie IN (SELECT codpie FROM pieza WHERE color='Rojo') 
AND 
codpro IN (SELECT codpro FROM proveedor WHERE ciudad='Londres');

--3.22--
SELECT codpie
FROM pieza
WHERE peso > ALL(SELECT peso from pieza where nompie LIKE '_ornillo%');

--3.23--
SELECT p.codpie
FROM pieza p
WHERE peso > ALL(SELECT peso from pieza where p.codpie != pieza.codpie);

--3.24--
SELECT pieza.codpie
FROM pieza
WHERE NOT EXISTS(
SELECT codpj from proyecto where proyecto.ciudad='Londres'
MINUS
SELECT codpj from ventas where ventas.codpie=pieza.codpie);




--3.25--
SELECT proveedor.codpro
FROM proveedor
WHERE NOT EXISTS(
SELECT proyecto.ciudad from proyecto
MINUS
SELECT pieza.ciudad from ventas, pieza where ventas.codpie=pieza.codpie AND ventas.codpro = proveedor.codpro);

SELECT  codpro
FROM proveedor
WHERE NOT EXISTS(
SELECT codpie FROM pieza WHERE ciudad IN (SELECT ciudad FROM proyecto)
MINUS
SELECT codpie FROM ventas WHERE ventas.codpro=proveedor.codpro
);


--3.26--
SELECT count(*)
FROM ventas
WHERE cantidad >1000;

--3.27--
SELECT MAX(peso)
FROM pieza;

--3.28--
Select codpie
FROM pieza
WHERE peso = (SELECT MAX(peso) FROM pieza);

--3.29--
SELECT codpie, MAX(peso)
FROM pieza;

--3.30--
SELECT codpro
FROM proveedor
WHERE 3<(SELECT count(*) FROM ventas WHERE ventas.codpro = proveedor.codpro);

--3.31--
SELECT AVG(cantidad), pieza.codpie, pieza.nompie
FROM ventas, pieza
WHERE ventas.codpie=pieza.codpie
GROUP BY pieza.codpie,pieza.nompie;

--3.32--
SELECT AVG(cantidad), codpro
FROM ventas
WHERE codpie='P1'
GROUP BY codpro;

--3.33--
SELECT SUM(cantidad), codpie, codpj
FROM ventas
GROUP BY codpie,codpj;

--3.34--
SELECT v.codpro, v.codpj, j.nompj, AVG(v.cantidad)
FROM ventas v, proyecto j
WHERE v.codpj=j.codpj
GROUP BY (v.codpj,j.nompj,v.codpro);

--3.35--
SELECT nompro
FROM proveedor, ventas
WHERE proveedor.codpro = ventas.codpro
GROUP BY nompro HAVING SUM(ventas.cantidad)>1000;

--3.36--
SELECT codpie, SUM(cantidad)
FROM ventas
GROUP BY codpie HAVING SUM(cantidad) = (SELECT MAX(SUM(v.cantidad)) FROM ventas v GROUP BY v.codpie);

--3.38--
SELECT TO_CHAR(fecha,'MM'), AVG(cantidad)
FROM ventas
GROUP BY TO_CHAR(fecha,'MM');

--3.39--

