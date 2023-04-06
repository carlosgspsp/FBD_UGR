--3.60--
SELECT *
FROM encuentros;

--3.61--
SELECT nombre_e, nombre_j
FROM equipos, jugadores
Where equipos.cod_e=jugadores.cod_e
ORDER BY (nombre_e);

--3.62--
SELECT cod_j
FROM faltas
WHERE num=0;

--3.63--
SELECT nombre_j, cod_j
FROM jugadores
WHERE cod_e =(SELECT cod_e FROM jugadores where cod_j=01);

--3.64--
SELECT nombre_j, localidad
FROM jugadores, equipos
WHERE jugadores.cod_e=equipos.cod_e;

--3.65--
SELECT cod_e, nombre_e
FROM equipos
WHERE cod_e=ANY(SELECT e_local FROM encuentros WHERE p_local>p_visitante);

--3.66--
SELECT cod_e, nombre_e
FROM equipos
WHERE cod_e=ANY(SELECT e_local FROM encuentros WHERE p_local>p_visitante) 
OR cod_e=ANY(SELECT e_visitante FROM encuentros WHERE p_visitante>p_local);

--3.67--
(SELECT DISTINCT e_local
FROM encuentros
WHERE
(encuentros.p_local>encuentros.p_visitante))
MINUS
SELECT DISTINCT e_visitante
FROM encuentros
WHERE
(encuentros.p_local<encuentros.p_visitante);

--3.68--
/*SELECT DISTINCT e0.e_local
FROM encuentros e0
WHERE NOT EXISTS(
(SELECT e1.e_local FROM encuentros e1)
MINUS
(SELECT e2.e_local FROM encuentros e2 WHERE e2.p_local>e0.p_visitante)
);   No se por que no funciona*/ 
select e_local
from encuentros
minus
select e_local
from encuentros
where p_local<p_visitante;


--3.69--
SELECT *
FROM encuentros
WHERE fecha >= SYSDATE;

--3.70--
--Entendiendo que quiere que mueste loe Encuentros de una ciudad Especifica
SELECT *
FROM encuentros
WHERE e_local IN(SELECT cod_e FROM equipos WHERE localidad='Las Marinas' );

--Entendiendo que pide que muestre todos los encuentros ordenados por la localidad
SELECT *
FROM encuentros, equipos
WHERE encuentros.e_local=equipos.cod_e
ORDER BY localidad;

--3.71--
SELECT count(*), cod_e, nombre_e
FROM encuentros, equipos
WHERE e_local=cod_e
GROUP by (cod_e, nombre_e);

--3.72--
SELECT *
FROM encuentros
WHERE ABS(p_local-p_visitante) = (SELECT MAX(ABS(p_local-p_visitante)) FROM encuentros);

--3.73--
SELECT *
FROM jugadores
WHERE cod_j IN(SELECT cod_j FROM faltas WHERE faltas.num<3);

--3.74--
SELECT *
FROM equipos
WHERE cod_e IN (SELECT E_visitante FROM encuentros WHERE p_visitante = (SELECT MAX(p_visitante) FROM encuentros));

--3.75--
SELECT cod, SUM(victorias)
FROM(
SELECT e_local as cod, count(*) as victorias FROM encuentros WHERE p_local>p_visitante GROUP BY e_local
UNION
SELECT e_visitante as cod, count(*) as victorias FROM encuentros WHERE p_local<p_visitante GROUP BY e_visitante
)
GROUP BY cod;

--3.76--
SELECT cod, vic
FROM (SELECT cod, SUM(victorias) as vic
FROM(
SELECT e_local as cod, count(*) as victorias FROM encuentros WHERE p_local>p_visitante GROUP BY e_local
UNION
SELECT e_visitante as cod, count(*) as victorias FROM encuentros WHERE p_local<p_visitante GROUP BY e_visitante
)
GROUP BY cod)
WHERE vic = (SELECT MAX(vic2) FROM((SELECT cod, SUM(victorias) as vic2
FROM(
SELECT e_local as cod, count(*) as victorias FROM encuentros WHERE p_local>p_visitante GROUP BY e_local
UNION
SELECT e_visitante as cod, count(*) as victorias FROM encuentros WHERE p_local<p_visitante GROUP BY e_visitante
)
GROUP BY cod
)));

--3.77--
SELECT AVG(p_visitante), e_visitante
FROM encuentros
GROUP BY e_visitante;

--3.78--
SELECT cod, pt
FROM (SELECT cod, SUM(puntos) as pt 
FROM(
(SELECT e_local as cod, SUM(p_local) as puntos FROM encuentros GROUP BY e_local)
UNION
(SELECT e_visitante as cod, SUM(p_visitante) as puntos FROM encuentros GROUP BY e_visitante)
)
GROUP BY cod)
WHERE pt = (SELECT MAX(pt2) FROM((SELECT cod, SUM(puntos) as pt2 
FROM(
(SELECT e_local as cod, SUM(p_local) as puntos FROM encuentros GROUP BY e_local)
UNION
(SELECT e_visitante as cod, SUM(p_visitante) as puntos FROM encuentros GROUP BY e_visitante)
)
GROUP BY cod
)));


/*
SELECT cod, SUM(puntos) 
FROM(
(SELECT e_local as cod, SUM(p_local) as puntos FROM encuentros GROUP BY e_local)
UNION
(SELECT e_visitante as cod, SUM(p_visitante) as puntos FROM encuentros GROUP BY e_visitante)
)
GROUP BY cod;
*/


