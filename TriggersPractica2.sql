
CREATE TRIGGER creacion_tablas
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
	PRINT 'Se ha creado una nueva tabla en DBBANK.'
END



CREATE TRIGGER creador_sp
ON DATABASE
FOR CREATE_PROCEDURE
AS
BEGIN
    PRINT 'Se ha creado un nuevo procedimiento almacenado en DBBANK';
END;



DROP TABLE  Prestamos;
DROP TABLE PagosPrestamos;


CREATE TABLE Prestamos(
    PrestamoID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT,
    Monto DECIMAL(18, 2),
    TasaInteres DECIMAL(5,2),
    FechaInicio DATE,
    FechaFin DATE,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

INSERT INTO Prestamos (ClienteID, Monto, TasaInteres, FechaInicio, FechaFin)
VALUES 
    (4, 25000.00, 5.25, '2023-04-01', '2024-04-01'),
    (5, 30000.00, 6.50, '2023-05-01', '2024-05-01'),
    (6, 35000.00, 5.00, '2023-06-01', '2024-06-01'),
    (1, 12000.00, 4.75, '2023-07-01', '2024-07-01'),
    (2, 18000.00, 6.25, '2023-08-01', '2024-08-01');

	SELECT * FROM Prestamos;




CREATE TABLE PagosPrestamos(
    PagoID INT IDENTITY(1,1) PRIMARY KEY,
    PrestamoID INT,
    MontoPagado DECIMAL(18,2),
    FechaPago DATE,
    FOREIGN KEY(PrestamoID) REFERENCES Prestamos(PrestamoID)
);


SELECT * FROM Prestamos;

INSERT INTO PagosPrestamos (PrestamoID, MontoPagado, FechaPago)
VALUES 
    (4, 1250.00, '2023-04-15'),
    (3, 1250.00, '2023-05-15'),
    (2, 1500.00, '2023-05-15'),
    (1, 1500.00, '2023-06-15'),
    (1, 600.00, '2023-08-15'),
    (2, 900.00, '2023-09-15'),
    (3, 1100.00, '2023-10-15'),
    (4, 1300.00, '2023-11-15');






SELECT * FROM PagosPrestamos;
SELECT * FROM Prestamos;


CREATE PROCEDURE sp_ingresarPrestamoPago
    @cli INT,                     
    @valp DECIMAL(18, 2),     
    @tasa DECIMAL(5,2),          
    @de DATE,                    
    @mon DECIMAL(18, 2)          
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
       
        INSERT INTO Prestamos(ClienteID, Monto, TasaInteres, FechaInicio, FechaFin)
        VALUES (@cli, @valp, @tasa, GETDATE(), @de);

        DECLARE @nid INT;
        SET @nid = SCOPE_IDENTITY();  

        INSERT INTO PagosPrestamos(PrestamoID, MontoPagado, FechaPago)
        VALUES (@nid, @mon, GETDATE());

        COMMIT;
    END TRY
    BEGIN CATCH

        ROLLBACK;

        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH;
END;




SELECT * FROM Clientes;

SELECT * FROM PagosPrestamos
SELECT * FROM Prestamos;


EXEC sp_ingresarPrestamoPago 1, 252.90, 5.7, '2024-04-01', 100.20; 



CREATE PROCEDURE sp_obtenerClientesConprestamosYpagos
AS
BEGIN
SELECT c.Nombre, c.Direccion, c.Telefono, c.Email, p.PrestamoID, p.Monto AS MontoPrestamo,
p.TasaInteres,p.FechaInicio, p.FechaFin, pp.PagoID, pp.MontoPagado, pp.FechaPago
FROM PagosPrestamos as pp
JOIN Prestamos as p on pp.PrestamoID = p.PrestamoID
JOIN Clientes as c ON p.ClienteID = c.ClienteID
END


EXEC sp_obtenerClientesConprestamosYpagos;