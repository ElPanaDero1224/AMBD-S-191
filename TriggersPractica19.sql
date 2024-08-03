
--despues de insertar clientes
CREATE TRIGGER tr_afterInsertClientes
ON Clientes
AFTER INSERT 
AS
BEGIN
	DECLARE @nombre NVARCHAR(100);
	SELECT @nombre = i.nombre FROM inserted i;
	PRINT 'Bienvenido ' + @nombre + ' Tu cuena ha sido creada exitosamente';

END


INSERT INTO Clientes (Nombre, Direccion, Telefono, Email)
VALUES ('Samo', 'En mi casa', '12344', '122@gmail.com');




--despues de eliminar una cuenta
CREATE TRIGGER tr_afterDropClientes
ON Clientes
AFTER DELETE
AS
BEGIN
	PRINT 'La cuenta se ha eliminado'
END

SELECT * FROM Clientes;

DELETE FROM Clientes WHERE ClienteID = 9;


--Crea un Trigger para la tabla cuentas que valide si existe el cliente antes de crear una nueva cuenta , avisar cada caso con su respectivo mensaje


-- Crear el trigger
CREATE TRIGGER trgBeforeCuentaInsert
ON Cuentas
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN Clientes c ON i.ClienteID = c.ClienteID
        WHERE c.ClienteID IS NULL
    )
    BEGIN
        RAISERROR('No se puede crear la cuenta. El ClienteID especificado no existe.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    INSERT INTO Cuentas (ClienteID, Saldo)
    SELECT ClienteID, Saldo
    FROM inserted;
END;


CREATE TRIGGER trg_ValidarCliente
ON Cuentas
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN Clientes c ON i.ClienteID = c.ClienteID
        WHERE c.ClienteID IS NULL
    )
    BEGIN
        RAISERROR('El ClienteID proporcionado no existe en la tabla Clientes.', 16, 1);
    END
    ELSE
    BEGIN
	PRINT 'La cuenta ha sido creada con exito'
    END
END;


SELECT * FROM Cuentas;
SELECT * FROM Clientes;

INSERT INTO Cuentas (ClienteID, TipoCuenta, Saldo, FechaApertura)
VALUES (10,  'Debito', 700, '2024-07-10');



CREATE TRIGGER trg_ValidarSaldoNoNegativo
ON Cuentas
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.Saldo < 0
    )
    BEGIN
        RAISERROR('El saldo de la cuenta no puede ser negativo.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

UPDATE Cuentas SET Saldo = -1 WHERE CuentaID = 4;

SELECT * FROM Cuentas;

Select * from Prestamos;
SELECT * FROM PagosPrestamos;


PagosPrestamos: 
PagoID INT
PrestamoID INT
MontoPagado DECIMAL
FechaPago DATE

Prestamos:
CleinteID int
Monto decimal
Tasainteres decimal
FechaInicio date
FechaFin date


DROP TRIGGER trg_NoEliminarPrestamoConPagos


CREATE TRIGGER trg_NoEliminarPrestamoConPagos
ON Prestamos
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM PagosPrestamos pp
        INNER JOIN deleted d ON pp.PrestamoID = d.PrestamoID
    )
    BEGIN
        RAISERROR ('Hay pagos asociados en la tabla PagosPrestamos.', 16, 1);
        
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE FROM Prestamos
        WHERE PrestamoID IN (SELECT PrestamoID FROM deleted);
    END
END;



SELECT * FROM Prestamos;

DELETE FROM Prestamos WHERE PrestamoID = 4


SELECT * FROM PagosPrestamos;
SELECT * FROM Prestamos;

EXEC sp_eliminarPrestamosPagos 1



select * from logClientes;





CREATE TABLE logClientes (logID INT IDENTITY(1,1) PRIMARY KEY,
OPERACION NVARCHAR(10),
FechaHora DATETIME DEFAULT GETDATE()
);


SELECT * FROM Clientes;
SELECT * FROM logClientes;
DELETE  FROM logClientes WHERE logID = 3


UPDATE Clientes SET Nombre = 'Juan' WHERE ClienteID = 3;
SELECT * FROM logClientes;
SELECT * FROM Clientes;

DELETE FROM Clientes WHERE ClienteID = 10

INSERT INTO Clientes (Nombre, Direccion, Telefono, Email)
VALUES ('Saul', 'Una casa', '1236', 'Saul@gmail.com')


drop trigger trg_LogClientes

CREATE TRIGGER trg_LogClientes
ON Clientes
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN

        IF EXISTS (SELECT 1 FROM deleted)
        BEGIN

            INSERT INTO logClientes (OPERACION, FechaHora)
            VALUES ('UPDATE', GETDATE());
        END
        ELSE
        BEGIN
 
            INSERT INTO logClientes (OPERACION, FechaHora)
            VALUES ('INSERT', GETDATE());
        END
    END

    IF EXISTS (SELECT 1 FROM deleted)
    BEGIN

        IF NOT EXISTS (SELECT 1 FROM inserted)
        BEGIN
            INSERT INTO logClientes (OPERACION, FechaHora)
            VALUES ('DELETE', GETDATE());
        END
    END
END;
