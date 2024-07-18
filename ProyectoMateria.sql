CREATE DATABASE MEDICO;
USE MEDICO;

CREATE TABLE roles (
    id_rol INT PRIMARY KEY IDENTITY,
    nombre_rol VARCHAR(50)
);

CREATE TABLE medicos (
    id_medicos INT PRIMARY KEY IDENTITY,
    nombres VARCHAR(100),
    apellidos_p VARCHAR(100),
    apellidos_m VARCHAR(100),
    correo VARCHAR(100),
    contraseña VARCHAR(100),
    RFC VARCHAR(13),
    id_rol INT,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

CREATE TABLE expedientes (
    id_expediente INT PRIMARY KEY IDENTITY,
    nombres VARCHAR(100),
    apellidos_p VARCHAR(100),
    apellidos_m VARCHAR(100),
    alergias VARCHAR(255),
    enfermedades_cronicas VARCHAR(255),
    antecedentes_familiares VARCHAR(255),
    fecha_nacimiento DATE,
    id_medico INT,
    id_receta INT,
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medicos),
);

CREATE TABLE exploraciones (
    id_exploracion INT PRIMARY KEY IDENTITY,
    peso DECIMAL(5,2),
    altura DECIMAL(5,2),
    temperatura INT,
    latidos_por_min INT,
    id_expediente INT,
    FOREIGN KEY (id_expediente) REFERENCES expedientes(id_expediente)
);

CREATE TABLE citas (
    id_cita INT PRIMARY KEY IDENTITY,
    fecha DATETIME,
    id_exploracion INT,
    id_medico INT,
    id_expediente INT,
    FOREIGN KEY (id_exploracion) REFERENCES exploraciones(id_exploracion),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medicos),
    FOREIGN KEY (id_expediente) REFERENCES expedientes(id_expediente)
);

CREATE TABLE diagnosticos (
    id_diagnostico INT PRIMARY KEY IDENTITY,
    tratamiento VARCHAR(MAX),
    fecha DATE,
    dx VARCHAR(255),
    id_expediente INT,
    FOREIGN KEY (id_expediente) REFERENCES expedientes(id_expediente)
);

CREATE TABLE recetas (
    id_receta INT PRIMARY KEY IDENTITY,
    informacion VARCHAR(MAX),
    id_diagnostico INT,
    id_cita INT,
    FOREIGN KEY (id_diagnostico) REFERENCES diagnosticos(id_diagnostico),
    FOREIGN KEY (id_cita) REFERENCES citas(id_cita)
);








-- Insertar roles
INSERT INTO roles (nombre_rol) VALUES ('Doctor');
INSERT INTO roles (nombre_rol) VALUES ('Enfermero');
INSERT INTO roles (nombre_rol) VALUES ('Especialista');

-- Insertar médicos
INSERT INTO medicos (nombres, apellidos_p, apellidos_m, correo, contraseña, RFC, id_rol)
VALUES ('Juan', 'Pérez', 'Gómez', 'juan.perez@correo.com', 'password123', 'JUAP870102MDF', 1);
INSERT INTO medicos (nombres, apellidos_p, apellidos_m, correo, contraseña, RFC, id_rol)
VALUES ('María', 'López', 'Hernández', 'maria.lopez@correo.com', 'password456', 'MALH920405HDF', 2);
INSERT INTO medicos (nombres, apellidos_p, apellidos_m, correo, contraseña, RFC, id_rol)
VALUES ('Luis', 'Ramírez', 'Ortiz', 'luis.ramirez@correo.com', 'password789', 'LUIR850710HDF', 1);
INSERT INTO medicos (nombres, apellidos_p, apellidos_m, correo, contraseña, RFC, id_rol)
VALUES ('Ana', 'García', 'Martínez', 'ana.garcia@correo.com', 'password101', 'ANGM830912HDF', 3);

-- Insertar expedientes
INSERT INTO expedientes (nombres, apellidos_p, apellidos_m, alergias, enfermedades_cronicas, antecedentes_familiares, fecha_nacimiento, id_medico, id_receta)
VALUES ('Carlos', 'Sánchez', 'Martínez', 'Ninguna', 'Diabetes', 'Hipertensión', '1985-05-15', 1, NULL);
INSERT INTO expedientes (nombres, apellidos_p, apellidos_m, alergias, enfermedades_cronicas, antecedentes_familiares, fecha_nacimiento, id_medico, id_receta)
VALUES ('Ana', 'Fernández', 'Rodríguez', 'Penicilina', 'Asma', 'Asma', '1990-08-25', 2, NULL);
INSERT INTO expedientes (nombres, apellidos_p, apellidos_m, alergias, enfermedades_cronicas, antecedentes_familiares, fecha_nacimiento, id_medico, id_receta)
VALUES ('Miguel', 'Torres', 'Jiménez', 'Polen', 'Hipertensión', 'Cardiopatías', '1978-12-02', 3, NULL);
INSERT INTO expedientes (nombres, apellidos_p, apellidos_m, alergias, enfermedades_cronicas, antecedentes_familiares, fecha_nacimiento, id_medico, id_receta)
VALUES ('Laura', 'Mendoza', 'López', 'Ninguna', 'Diabetes', 'Diabetes', '1989-03-22', 4, NULL);

-- Insertar exploraciones
INSERT INTO exploraciones (peso, altura, temperatura, latidos_por_min, id_expediente)
VALUES (70.5, 1.75, 36, 70, 1);
INSERT INTO exploraciones (peso, altura, temperatura, latidos_por_min, id_expediente)
VALUES (65.2, 1.60, 37, 75, 2);
INSERT INTO exploraciones (peso, altura, temperatura, latidos_por_min, id_expediente)
VALUES (80.0, 1.80, 38, 72, 3);
INSERT INTO exploraciones (peso, altura, temperatura, latidos_por_min, id_expediente)
VALUES (55.5, 1.65, 36, 68, 4);

-- Insertar citas
INSERT INTO citas (fecha, id_exploracion, id_medico, id_expediente)
VALUES ('2024-07-09 10:00:00', 1, 1, 1);
INSERT INTO citas (fecha, id_exploracion, id_medico, id_expediente)
VALUES ('2024-07-09 11:00:00', 2, 2, 2);
INSERT INTO citas (fecha, id_exploracion, id_medico, id_expediente)
VALUES ('2024-07-10 09:00:00', 3, 3, 3);
INSERT INTO citas (fecha, id_exploracion, id_medico, id_expediente)
VALUES ('2024-07-10 14:00:00', 4, 4, 4);

-- Insertar diagnósticos

SELECT * FROM diagnosticos;


INSERT INTO diagnosticos (tratamiento, fecha, dx, id_expediente)
VALUES ('Tratamiento A', '2024-07-09', 'Diagnóstico A', 1);
INSERT INTO diagnosticos (tratamiento, fecha, dx, id_expediente)
VALUES ('Tratamiento B', '2024-07-09', 'Diagnóstico B', 2);
INSERT INTO diagnosticos (tratamiento, fecha, dx, id_expediente)
VALUES ('Tratamiento C', '2024-07-10', 'Diagnóstico C', 3);
INSERT INTO diagnosticos (tratamiento, fecha, dx, id_expediente)
VALUES ('Tratamiento D', '2024-07-10', 'Diagnóstico D', 4);

-- Insertar recetas
INSERT INTO recetas (informacion, id_diagnostico, id_cita)
VALUES ('Receta A', 1, 1);
INSERT INTO recetas (informacion, id_diagnostico, id_cita)
VALUES ('Receta B', 2, 2);
INSERT INTO recetas (informacion, id_diagnostico, id_cita)
VALUES ('Receta C', 3, 3);
INSERT INTO recetas (informacion, id_diagnostico, id_cita)
VALUES ('Receta D', 4, 4);




SELECT * FROM vw_clienteMedico;

SELECT * FROM recetas;

UPDATE expedientes SET id_receta = 1 WHERE id_expediente = 1;
UPDATE expedientes SET id_receta = 2 WHERE id_expediente = 2;
UPDATE expedientes SET id_receta = 3 WHERE id_expediente = 3;
UPDATE expedientes SET id_receta = 4 WHERE id_expediente = 4;

INSERT INTO expedientes (nombres, apellidos_p, apellidos_m, alergias, enfermedades_cronicas, antecedentes_familiares, fecha_nacimiento, id_medico, id_receta)
VALUES ('Carlos', 'Sánchez', 'Martínez', 'Ninguna', 'Diabetes', 'Hipertensión', '1985-05-15', 1, NULL);
INSERT INTO expedientes (nombres, apellidos_p, apellidos_m, alergias, enfermedades_cronicas, antecedentes_familiares, fecha_nacimiento, id_medico, id_receta)
VALUES ('Ana', 'Fernández', 'Rodríguez', 'Penicilina', 'Asma', 'Asma', '1990-08-25', 2, NULL);
INSERT INTO expedientes (nombres, apellidos_p, apellidos_m, alergias, enfermedades_cronicas, antecedentes_familiares, fecha_nacimiento, id_medico, id_receta)
VALUES ('Miguel', 'Torres', 'Jiménez', 'Polen', 'Hipertensión', 'Cardiopatías', '1978-12-02', 3, NULL);
INSERT INTO expedientes (nombres, apellidos_p, apellidos_m, alergias, enfermedades_cronicas, antecedentes_familiares, fecha_nacimiento, id_medico, id_receta)
VALUES ('Laura', 'Mendoza', 'López', 'Ninguna', 'Diabetes', 'Diabetes', '1989-03-22', 4, NULL);

SELECT * FROM expedientes;

SELECT * FROM recetas;







CREATE VIEW vw_recetasTratamientos
AS
SELECT r.informacion, d.tratamiento, d.dx AS diagnostico ,d.fecha, 
CONCAT(m.nombres,' ', m.apellidos_p) AS 'Nombre del medico encargado'
FROM recetas as r
INNER JOIN diagnosticos as d ON d.id_diagnostico = r.id_diagnostico
INNER JOIN citas as c ON c.id_cita = r.id_cita
INNER JOIN medicos as m ON m.id_medicos = c.id_medico;

SELECT * FROM vw_recetasTratamientos;

--Vistas de la pagina

CREATE VIEW vw_medicosRol 
AS
SELECT m.nombres, m.apellidos_m, r.nombre_rol
FROM medicos as m
INNER JOIN roles as r on r.id_rol = m.id_rol;


SELECT * FROM vw_medicosRol;

SELECT * FROM vw_recetasTratamientos
SELECT * FROM vw_medicosRol;
SELECT * FROM vw_clienteMedico;



CREATE VIEW vw_clienteMedico 
AS
SELECT e.nombres, CONCAT(e.apellidos_p,' ', e.apellidos_m) AS Apellido, 
CONCAT(m.nombres,' ', m.apellidos_p) AS 'Nombre del medico encargado'
FROM expedientes as e
INNER JOIN medicos as m on e.id_medico = m.id_medicos
INNER JOIN roles as r on r.id_rol = m.id_rol;




SELECT * FROM vw_clienteMedico

SELECT * FROM expedientes;
SELECT * FROM vw_medicosRol
SELECT * FROM vw_recetasTratamientos

--Diseña y Prueba 4 Procedimientos con transacciones para la BD

-- 1 agg un medico y cambiar su rol







CREATE PROCEDURE InsertarMedico
    @nombres VARCHAR(100),
    @apellidos_p VARCHAR(100),
    @apellidos_m VARCHAR(100),
    @correo VARCHAR(100),
    @contraseña VARCHAR(100),
    @RFC VARCHAR(13),
    @id_rol INT
AS
BEGIN
    BEGIN TRANSACTION
    INSERT INTO medicos (nombres, apellidos_p, apellidos_m, correo, contraseña, RFC, id_rol)
    VALUES (@nombres, @apellidos_p, @apellidos_m, @correo, @contraseña, @RFC, @id_rol);
    
    UPDATE roles
    SET nombre_rol = 'Medico'
    WHERE id_rol = @id_rol;

COMMIT TRANSACTION;
END;

EXEC InsertarMedico 'Santiago', 'Amaya', 'Lopez', 'santiago.amaya@gmail.com', 'contra234', 'SSSS999100SSS', 1;

SELECT * FROM medicos;
SELECT * FROM roles;

DROP PROCEDURE InsertarMedico;

--2 agg nuevo expendiente y poner otro encargado





CREATE PROCEDURE InsertarExpediente
    @nombres VARCHAR(100),
    @apellidos_p VARCHAR(100),
    @apellidos_m VARCHAR(100),
    @alergias VARCHAR(255),
    @enfermedades_cronicas VARCHAR(255),
    @antecedentes_familiares VARCHAR(255),
    @fecha_nacimiento DATE,
    @id_medico INT
AS
BEGIN
    BEGIN TRANSACTION
    INSERT INTO expedientes (nombres, apellidos_p, apellidos_m, alergias, enfermedades_cronicas, antecedentes_familiares, fecha_nacimiento, id_medico)
    VALUES (@nombres, @apellidos_p, @apellidos_m, @alergias, @enfermedades_cronicas, @antecedentes_familiares, @fecha_nacimiento, @id_medico);
    
    UPDATE medicos
    SET nombres = CONCAT(nombres, '')
    WHERE id_medicos = @id_medico;

COMMIT TRANSACTION;
END;

EXEC InsertarExpediente 'Pedro', 'Martínez', 'Hernández', 'Polvo', 'Diabetes', 'Hipertensión', '1992-07-15', 5;

SELECT * FROM expedientes;
SELECT * FROM medicos;

DROP PROCEDURE InsertarExpediente;

--3 agg nuevo rol y cambiar un rol que ya existe





CREATE PROCEDURE InsertarActualizarRol
    @rol_nuevo VARCHAR(50),
    @id_rol_actualizar INT,
    @rol_actualizado VARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION
    INSERT INTO roles (nombre_rol)
    VALUES (@rol_nuevo);
    
    UPDATE roles
    SET nombre_rol = @rol_actualizado
    WHERE id_rol = @id_rol_actualizar;

COMMIT TRANSACTION;
END;

EXEC InsertarActualizarRol 'Cirujano', 1, 'Medico';

SELECT * FROM roles;

DROP PROCEDURE InsertarActualizarRol;

--4 agg una nueva receta y cambiar la info de una receta que ya existe









CREATE PROCEDURE InsertarActualizarReceta
    @informacion_nueva VARCHAR(MAX),
    @id_diagnostico INT,
    @id_cita INT,
    @id_receta_actualizar INT,
    @nueva_informacion VARCHAR(MAX)
AS
BEGIN
    BEGIN TRANSACTION
    INSERT INTO recetas (informacion, id_diagnostico, id_cita)
    VALUES (@informacion_nueva, @id_diagnostico, @id_cita);
    
    UPDATE recetas
    SET informacion = @nueva_informacion
    WHERE id_receta = @id_receta_actualizar;

COMMIT TRANSACTION;
END;

EXEC InsertarActualizarReceta 'Receta E', 1, 1, 2, 'Receta A';

SELECT * FROM recetas;

DROP PROCEDURE InsertarActualizarReceta;

SELECT * FROM citas






----------------------Procedimientos almacenados------------------------------------------------------------------
-------------1---------------------
CREATE PROCEDURE sp_InsertarMedico
@nombres VARCHAR(100),
@apellidos_p VARCHAR(100),
@apellidos_m VARCHAR(100),
@correo VARCHAR(100),
@contraseña VARCHAR(100),
@RFC VARCHAR(13),
@id_rol INT
AS
BEGIN 
INSERT INTO medicos (nombres, apellidos_p, apellidos_m, correo, contraseña, RFC, id_rol)
VALUES (@nombres, @apellidos_p, @apellidos_m, @correo, @contraseña, @RFC, @id_rol);
END;
EXEC sp_InsertarMedico 
@nombres = 'Pedro',
@apellidos_p = 'García',
@apellidos_m = 'López',
@correo = 'pedro.garcia@correo.com',
@contraseña = 'pedro123',
@RFC = 'PEGG901010HDF',
@id_rol = 1;

EXEC sp_InsertarMedico 
@nombres = 'Lucía',
@apellidos_p = 'Hernández',
@apellidos_m = 'Martínez',
@correo = 'lucia.hernandez@correo.com',
@contraseña = 'lucía123',
@RFC = 'LUHM920415MDF',
@id_rol = 2;

EXEC sp_InsertarMedico 
@nombres = 'Carlos',
@apellidos_p = 'Santos',
@apellidos_m = 'Pérez',
@correo = 'carlos.santos@correo.com',
@contraseña = 'carlos123',
@RFC = 'CASP880705HDF',
@id_rol = 3;
SELECT * FROM medicos;








------------------2----------------------
CREATE PROCEDURE sp_ActualizarMedico
@id_medicos INT,
@correo VARCHAR(100)
AS
BEGIN
UPDATE medicos SET correo = @correo 
WHERE id_medicos = @id_medicos;
END;

EXEC sp_ActualizarMedico @correo = 'perez@correo.com',@id_medicos = 1 ;
EXEC sp_ActualizarMedico @correo = 'lopez@correo.com',@id_medicos = 2;
EXEC sp_ActualizarMedico @correo = 'ramirez@correo.com',@id_medicos = 3;
EXEC sp_ActualizarMedico @correo = 'carlos.santos@correo.com',@id_medicos = 7;
SELECT * FROM medicos;

-------------3----------------------------------------------------







CREATE PROCEDURE sp_EliminarExpediente
 @id_expediente INT
AS
BEGIN

DELETE FROM recetas WHERE id_receta IN (SELECT id_receta FROM expedientes WHERE id_expediente = @id_expediente);
DELETE FROM diagnosticos WHERE id_expediente = @id_expediente;
DELETE FROM citas WHERE id_expediente = @id_expediente;
DELETE FROM exploraciones WHERE id_expediente = @id_expediente;
DELETE FROM expedientes WHERE id_expediente = @id_expediente;
END;
EXEC sp_EliminarExpediente @id_expediente = 5;
EXEC sp_EliminarExpediente @id_expediente = 3;
EXEC sp_EliminarExpediente @id_expediente = 4;
EXEC sp_EliminarExpediente @id_expediente = 6;

SELECT * FROM expedientes
----------------4-------------------------------
CREATE PROCEDURE sp_InsertarExpediente
@nombres VARCHAR(100),
@apellidos_p VARCHAR(100),
@apellidos_m VARCHAR(100),
@alergias VARCHAR(255),
@enfermedades_cronicas VARCHAR(255),
@antecedentes_familiares VARCHAR(255),
@fecha_nacimiento DATE,
@id_medico INT,
@id_receta INT
AS
BEGIN
INSERT INTO expedientes (nombres, apellidos_p, apellidos_m, alergias, enfermedades_cronicas, antecedentes_familiares, fecha_nacimiento, id_medico, id_receta)
VALUES (@nombres, @apellidos_p, @apellidos_m, @alergias, @enfermedades_cronicas, @antecedentes_familiares, @fecha_nacimiento, @id_medico, @id_receta);
END;
EXEC sp_InsertarExpediente 
@nombres = 'José',
@apellidos_p = 'Martínez',
@apellidos_m = 'Hernández',
@alergias = 'Polen',
@enfermedades_cronicas = 'Asma',
@antecedentes_familiares = 'Diabetes',
@fecha_nacimiento = '1985-02-15',
@id_medico = 1,
@id_receta = Null;
EXEC sp_InsertarExpediente 
@nombres = 'María',
@apellidos_p = 'González',
@apellidos_m = 'Sánchez',
@alergias = 'Ninguna',
@enfermedades_cronicas = 'Hipertensión',
@antecedentes_familiares = 'Cardiopatías',
@fecha_nacimiento = '1992-06-25',
@id_medico = 2,
@id_receta = Null;
EXEC sp_InsertarExpediente 
@nombres = 'Luis',
@apellidos_p = 'Ramírez',
@apellidos_m = 'Ortiz',
@alergias = 'Penicilina',
@enfermedades_cronicas = 'Ninguna',
@antecedentes_familiares = 'Hipertensión',
@fecha_nacimiento = '1978-11-30',
@id_medico = 3,
@id_receta = Null;

SELECT *FROM expedientes
----------------------------5-------------------------------------
CREATE PROCEDURE sp_EliminarMedico
    @id_medicos INT
AS
BEGIN
    DELETE FROM recetas
    WHERE id_cita IN (SELECT id_cita FROM citas WHERE id_medico = @id_medicos);
    DELETE FROM diagnosticos
    WHERE id_expediente IN (SELECT id_expediente FROM expedientes WHERE id_medico = @id_medicos);
    DELETE FROM citas
    WHERE id_medico = @id_medicos;
    DELETE FROM exploraciones
    WHERE id_expediente IN (SELECT id_expediente FROM expedientes WHERE id_medico = @id_medicos);
    DELETE FROM expedientes
    WHERE id_medico = @id_medicos;
    DELETE FROM medicos WHERE id_medicos = @id_medicos;
END;
EXEC sp_EliminarMedico @id_medicos = 1;
EXEC sp_EliminarMedico @id_medicos = 6;
EXEC sp_EliminarMedico @id_medicos = 7;
SELECT * FROM medicos
SELECT * FROM diagnosticos
SELECT * FROM citas
SELECT * FROM expedientes
SELECT * FROM recetas
SELECT * FROM exploraciones

----------------------6----------------------------
CREATE PROCEDURE sp_ActualizarExploraciones 
@id_exploracion INT,
@peso DECIMAL(5,2)
AS
BEGIN
UPDATE exploraciones SET peso = @peso
WHERE id_exploracion = @id_exploracion;
END;

EXEC sp_ActualizarExploraciones @peso = 54.29 ,@id_exploracion = 2 ;

SELECT * FROM exploraciones


--Vistas
SELECT * FROM vw_recetasTratamientos
SELECT * FROM vw_medicosRol;
SELECT * FROM vw_clienteMedico;
--TRANSACT
EXEC InsertarMedico;
EXEC InsertarExpediente;
EXEC InsertarActualizarRol
EXEC InsertarActualizarReceta
--SP
EXEC sp_InsertarMedico
EXEC sp_sp_ActualizarMedico
EXEC sp_EliminarExpediente
EXEC sp_InsertarExpediente
EXEc sp_EliminarMedico
EXEC sp_ActualizarExploraciones