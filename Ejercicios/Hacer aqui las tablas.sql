CREATE TABLE Partido (
Fecha DATE,
grupo VARCHAR2(15),
jLocal VARCHAR2(15) REFERENCES Bot(email),
jVisit VARCHAR2(15) REFERENCES Bot(email),                
GLocal INT NOT NULL CHECK (GLocal IN(0,1)),
GVisit INT NOT NULL CHECK (GVisit IN(0,1)),               
Empate INT NOT NULL CHECK (Empate IN(0,1)),               --El in para que sea uno de esos 2 
FOREIGN KEY (Fecha, grupo) REFERENCES Liga(Fecha, grupo), --Para cuando varias variables externas de otra misma tabla
PRIMARY KEY (Fecha, grupo, jLocal, jVisit),
CONSTRAINT gana_uno CHECK (GLocal + GVisit + Empate = 1), 
CONSTRAINT conmigo_mismo CHECK (jLocal != jVisit)
);

CREATE TABLE Bot (
email VARCHAR2(15) REFERENCES Participante(email) PRIMARY KEY,
NombreBot VARCHAR2(15) NOT NULL UNIQUE,                    --UNIQUE es clave candidata
cpp LONG,                                                   --LONG archivo de texto largo o algo asi
h LONG
);

hora NUMBRE (4,2) 4 numeros de los cuales 2 son decimales ej: 22,32

SELECT nombre FROM Participante WHERE NOT EXISTS(
(SELECT Fecha, Grupo FROM Liga WHERE Grupo='A1')
MINUS
(SELECT DISTINCT Fecha, Grupo FROM Partido WHERE Participante.email=jLocal));


CREATE VIEW vista AS
(consulta normal y corriente);
