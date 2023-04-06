CREATE TABLE proveedor (

    codpro VARCHAR2(3) CONSTRAINT codpro_pk PRIMARY KEY,
    nompro VARCHAR2(20) CONSTRAINT nombre_no_nulo NOT NULL,
    status NUMBER CONSTRAINT status_entre_1_y_10 CHECK (status>=1 and status<=10),
    ciudad VARCHAR2(15)
    
);

CREATE TABLE pieza (

    codpie VARCHAR2(3) CONSTRAINT codpie_pk PRIMARY KEY,
    nompie VARCHAR2(10) CONSTRAINT nompie_not_null NOT NULL,
    color VARCHAR2(10),
    peso NUMBER(5,2) CONSTRAINT peso_entre_0_y_100 CHECK (peso>0 and peso<=100),
    ciudad VARCHAR2(15)

);

CREATE TABLE proyecto(

    codpj VARCHAR2(3) CONSTRAINT codpj_pk PRIMARY KEY,
    nompj VARCHAR2(20) CONSTRAINT nompj_no_nulo NOT NULL,
    ciudad VARCHAR2(15)

);

CREATE TABLE ventas (

    codpro CONSTRAINT codpro_clave_externa_proveedor REFERENCES proveedor(codpro),
    codpie CONSTRAINT codpie_clave_externa_pieza REFERENCES pieza(codpie),
    codpj CONSTRAINT codpj_clave_externa_proyecto REFERENCES proyecto(codpj),
    cantidad NUMBER(4),
    fecha DATE,
    CONSTRAINT clave_primaria PRIMARY KEY (codpro,codpie,codpj)
    

);


REM INSERTING into PROVEEDOR
SET DEFINE OFF;
Insert into PROVEEDOR (CODPRO,NOMPRO,STATUS,CIUDAD) values ('S1','Jose Fernandez',2,'Madrid');
Insert into PROVEEDOR (CODPRO,NOMPRO,STATUS,CIUDAD) values ('S2','Manuel Vidal',1,'Londres');
Insert into PROVEEDOR (CODPRO,NOMPRO,STATUS,CIUDAD) values ('S3','Luisa Gomez',3,'Lisboa');
Insert into PROVEEDOR (CODPRO,NOMPRO,STATUS,CIUDAD) values ('S4','Pedro Sanchez',4,'Paris');
Insert into PROVEEDOR (CODPRO,NOMPRO,STATUS,CIUDAD) values ('S5','Maria Reyes',5,'Roma');
REM INSERTING into PROYECTO
SET DEFINE OFF;
Insert into PROYECTO (CODPJ,NOMPJ,CIUDAD) values ('J1','Proyecto 1','Londres');
Insert into PROYECTO (CODPJ,NOMPJ,CIUDAD) values ('J2','Proyecto 2','Londres');
Insert into PROYECTO (CODPJ,NOMPJ,CIUDAD) values ('J3','Proyecto 3','Paris');
Insert into PROYECTO (CODPJ,NOMPJ,CIUDAD) values ('J4','Proyecto 4','Roma');
REM INSERTING into PIEZA
SET DEFINE OFF;
Insert into PIEZA (CODPIE,NOMPIE,COLOR,PESO,CIUDAD) values ('P1','Tuerca','Gris',2.5,'Madrid');
Insert into PIEZA (CODPIE,NOMPIE,COLOR,PESO,CIUDAD) values ('P2','Tornillo','Rojo',1.25,'Paris');
Insert into PIEZA (CODPIE,NOMPIE,COLOR,PESO,CIUDAD) values ('P3','Arandela','Blanco',3,'Londres');
Insert into PIEZA (CODPIE,NOMPIE,COLOR,PESO,CIUDAD) values ('P4','Clavo','Gris',5.5,'Lisboa');
Insert into PIEZA (CODPIE,NOMPIE,COLOR,PESO,CIUDAD) values ('P5','Alcayata','Blanco',10,'Roma');

REM INSERTING into VENTAS
SET DEFINE OFF;
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S1','P1','J1',150,to_date('18/09/97','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S1','P1','J2',100,to_date('06/05/96','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S1','P1','J3',500,to_date('06/05/96','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S1','P2','J1',200,to_date('22/07/95','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S2','P2','J2',15,to_date('23/11/04','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S4','P2','J3',1700,to_date('28/11/00','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S1','P3','J1',800,to_date('22/07/95','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S5','P3','J2',30,to_date('01/04/14','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S1','P4','J1',10,to_date('22/07/95','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S1','P4','J3',250,to_date('09/03/94','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S2','P5','J2',300,to_date('23/11/04','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S2','P2','J1',4500,to_date('15/08/04','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S3','P1','J1',90,to_date('09/06/04','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S3','P2','J1',190,to_date('12/04/02','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S3','P5','J3',20,to_date('28/11/00','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S4','P5','J1',15,to_date('12/04/02','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S4','P3','J1',100,to_date('12/04/02','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S4','P1','J3',1500,to_date('26/01/03','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S1','P4','J4',290,to_date('09/03/94','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S1','P2','J4',175,to_date('09/03/94','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S5','P1','J4',400,to_date('01/04/14','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S5','P3','J3',400,to_date('01/04/14','DD/MM/RR'));
Insert into VENTAS (CODPRO,CODPIE,CODPJ,CANTIDAD,FECHA) values ('S1','P5','J1',340,to_date('06/02/10','DD/MM/RR'));
