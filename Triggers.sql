--Triggers DDL

--Trigger para evitar la eliminacion de una tabla

CREATE TRIGGER cuidado
ON DATABASE 
AFTER DROP_TABLE, ALTER_TABLE
AS
BEGIN
    PRINT 'No es posible eliminar o modificar la tabla hasta eliminar el trigger "cuidado"';
    ROLLBACK TRANSACTION;
    THROW 50000, 'No es posible eliminar o modificar la tabla hasta eliminar el trigger "cuidado"', 1;
END;



--Prevenir eliminacion de procedimientos almacenados

CREATE TRIGGER PreventDelAltDropSP
ON DATABASE
FOR CREATE_PROCEDURE, ALTER_PROCEDURE, DROP_PROCEDURE
AS
BEGIN
    PRINT 'No es posible crear, modificar o eliminar procedimientos almacenados en esta base de datos.';
    ROLLBACK TRANSACTION;
END;


DROP PROCEDURE sp_borrarHistorialVisualizacion;



CREATE TRIGGER actualizarBorrarSuscripcion
ON suscripciones
AFTER sp_altSuscripcion


DROP TABLE HistorialVisualizacion;


--Triggers DML

--Al ingresar un usuario
CREATE TRIGGER trg_DespuesDeIngresarUsuario
ON Usuarios
AFTER INSERT
AS
BEGIN
    DECLARE @UserName NVARCHAR(100), @UserEmail NVARCHAR(100);
    SELECT @UserName = i.Nombre, @UserEmail = i.Email FROM INSERTED i;
    PRINT 'Bienvenido ' + @UserName + '! Tu cuenta con el email ' + @UserEmail + ' ha sido creada exitosamente.';
END;


INSERT INTO Usuarios (Nombre, Email, Pass, FechaRegistro) VALUES ('Samanto', 'sam@gmail.com', 'Hola', GETDATE())


--Al actualizar una suscripcion

CREATE TRIGGER trg_altSuscr
ON Suscripciones
AFTER UPDATE
AS
BEGIN
    DECLARE @UsuarioID INT, @FechaInicio DATE, @FechaFin DATE, @Tipo NVARCHAR(50);
    SELECT @UsuarioID = i.UsuarioID, @FechaInicio = i.FechaInicio, @FechaFin = i.FechaFin, @Tipo = i.Tipo FROM INSERTED i;
    PRINT 'La suscripción del UsuarioID ' + CAST(@UsuarioID AS NVARCHAR) + ' ha sido actualizada a tipo ' + @Tipo + '.';
END;

EXEC sp_altSuscripcion 'Anual', 2;


UPDATE Suscripciones
SET Tipo = 'Básico'
WHERE UsuarioID = 2;
