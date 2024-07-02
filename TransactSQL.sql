--Creacion del procedimiento almacenado
CREATE PROCEDURE sp_agregarSuscripcion
	@usrID int,
	@FI DATE,
	@FF DATE,
	@type NVARCHAR(100)
AS
BEGIN
	BEGIN TRANSACTION;
	BEGIN TRY
	--INSERTAR LA NUEVA SUSCRIPCION
	INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo) VALUES (@usrID, @FI, @FF, @type);
	--Actualizar la fecha de registro del usuario
	UPDATE Usuarios SET FechaRegistro = @FI WHERE UsuarioID = @usrID
	COMMIT;
	END TRY

	BEGIN CATCH
		ROLLBACK;
	DECLARE @ErrorMessage NVARCHAR(4000);
	SET @ErrorMessage = ERROR_MESSAGE();
	PRINT @ErrorMessage;
	END CATCH;
END;

EXEC sp_agregarSuscripcion @usrID = 2, @FI = '2024-07-1', @FF = '2024-09-1', @type = 'Bimestral'

EXEC sp_agregarSuscripcion @usrID = 15, @FI = '2024-07-1', @FF = '2024-09-1', @type = 'Bimestral'
EXEC sp_agregarSuscripcion @usrID = 8, @FI = '2024-07-1', @FF = '2025-01-1', @type = 'Semestral'

SELECT * FROM Suscripciones;
SELECT * FROM Usuarios;