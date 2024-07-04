CREATE PROCEDURE sp_insertPeliHistorial
	@title NVARCHAR(100),
	@genre NVARCHAR(50),
	@dt DATE,
	@usr INT
AS
BEGIN
	BEGIN TRANSACTION;
	BEGIN TRY
		-- Insertar en la tabla Peliculas
		INSERT INTO Peliculas (Titulo, Genero, FechaEstreno)
		VALUES (@title, @genre, @dt);

		-- Obtener el ID generado
		DECLARE @mv INT;
		SET @mv = SCOPE_IDENTITY();
		PRINT @mv; -- Imprime el ID generado

		-- Insertar en la tabla HistorialVisualizacion
		INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion)
		VALUES (@usr, @mv, GETDATE());

		-- Confirmar la transacción
		COMMIT;
	END TRY
	BEGIN CATCH
		-- Manejar errores
		ROLLBACK;
		DECLARE @ErrorMessage NVARCHAR(4000);
		SET @ErrorMessage = ERROR_MESSAGE();
		PRINT @ErrorMessage;
	END CATCH;
END;






EXEC sp_insertPeliHistorial 'El gato con botas 2', 'Infantil', '2022-12-21', 5;
EXEC sp_insertPeliHistorial 'Openheimer', 'Drama', '2023-07-21', 12;
EXEC sp_insertPeliHistorial 'Barbie', 'Comedia', '2023-07-21', 12;

DELETE FROM HistorialVisualizacion WHERE HistorialID = 27;
DELETE FROM Peliculas WHERE PeliculaID = 1018;
SELECT * FROM Peliculas;
SELECT * FROM HistorialVisualizacion;
SELECT * FROM Usuarios;







CREATE PROCEDURE sp_insertUserSuscripcionVisual
	@nombre NVARCHAR(100),
	@email NVARCHAR(100),
	@passw NVARCHAR(100),
	@suscripcion NVARCHAR(50),
	@ff date,
	@pelicula int
AS
BEGIN
	BEGIN TRANSACTION;
	BEGIN TRY
	INSERT INTO Usuarios(Nombre, Email, Pass, FechaRegistro)
	VALUES (@nombre, @email, @passw, GETDATE());

	DECLARE @usr INT;
	SET @usr = SCOPE_IDENTITY()

	INSERT INTO Suscripciones(UsuarioID,FechaInicio, FechaFin, Tipo)
	VALUES (@usr ,GETDATE(), @ff, @suscripcion)

	INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion)
	VALUES (@usr, @pelicula, GETDATE());

		COMMIT;
	END TRY
	BEGIN CATCH
		ROLLBACK;
		DECLARE @ErrorMessage NVARCHAR(4000);
		SET @ErrorMessage = ERROR_MESSAGE();
		PRINT @ErrorMessage;
	END CATCH;
END;



SELECT * FROM Peliculas;
SELECT * FROM HistorialVisualizacion;
SELECT * FROM Usuarios;
SELECT * FROM Suscripciones;
DROP PROCEDURE IF EXISTS sp_insertUserSuscripcionVisual;
EXEC sp_insertUserSuscripcionVisual 'Jorge Emiliano', 'jorge@example.com', 'holaMundo', 'Anual', '2025-07-3', 2;
EXEC sp_insertUserSuscripcionVisual 'Mauricio Monroy', 'Mauricio@example.com', 'adiosMundo', 'Anual', '2025-07-3', 2;
EXEC sp_insertUserSuscripcionVisual 'Alonso Ortiz', 'Alonso@example.com', 'Mundo', 'Anual', '2025-07-3', 7;



Select * from HistorialVisualizacion;





DROP PROCEDURE IF EXISTS  sp_updateMail;

CREATE PROCEDURE sp_updateMail
	@id INT,
	@email NVARCHAR(100),
	@ff date
AS
BEGIN
	BEGIN TRANSACTION;
	BEGIN TRY
	UPDATE Usuarios SET Email = @email WHERE UsuarioID = @id;
	UPDATE Suscripciones SET Tipo = 'Anual' WHERE UsuarioID = @id;
	UPDATE Suscripciones SET FechaInicio = GETDATE() WHERE UsuarioID = @id;
	UPDATE Suscripciones SET FechaFin = @ff WHERE UsuarioID = @id;
		COMMIT;
	END TRY
	BEGIN CATCH
		ROLLBACK;
		DECLARE @ErrorMessage NVARCHAR(4000);
		SET @ErrorMessage = ERROR_MESSAGE();
		PRINT @ErrorMessage;
	END CATCH;
END;

EXEC sp_updateMail 4, 'FourLoko@example.com', '2025-07-3'
EXEC sp_updateMail 7, 'pepsi@example.com', '2025-07-3'
EXEC sp_updateMail 1, 'cocacola@example.com', '2025-07-3'

SELECT * FROM Suscripciones;
SELECT * FROM Usuarios;





DROP PROCEDURE IF EXISTS  sp_upda;

CREATE PROCEDURE sp_deleteMovie
	@id INT
AS
BEGIN
	BEGIN TRANSACTION;
	BEGIN TRY
	DELETE FROM HistorialVisualizacion WHERE PeliculaID = @id;
	DELETE FROM Peliculas WHERE PeliculaID = @id;
		COMMIT;
	END TRY
	BEGIN CATCH
		ROLLBACK;
		DECLARE @ErrorMessage NVARCHAR(4000);
		SET @ErrorMessage = ERROR_MESSAGE();
		PRINT @ErrorMessage;
	END CATCH;
END;


EXEC sp_deleteMovie 1022
EXEC sp_deleteMovie 2
EXEC sp_deleteMovie 3


SELECT * FROM Peliculas;
select * from HistorialVisualizacion




CREATE PROCEDURE sp_deleteEverUser
	@id INT
AS
BEGIN
	BEGIN TRANSACTION;
	BEGIN TRY
	DELETE FROM HistorialVisualizacion WHERE UsuarioID = @id;
	DELETE FROM Suscripciones WHERE UsuarioID = @id
	DELETE FROM Usuarios WHERE UsuarioID = @id
		COMMIT;
	END TRY
	BEGIN CATCH
		ROLLBACK;
		DECLARE @ErrorMessage NVARCHAR(4000);
		SET @ErrorMessage = ERROR_MESSAGE();
		PRINT @ErrorMessage;
	END CATCH;
END;

EXEC sp_deleteEverUser 7;
EXEC sp_deleteEverUser 6;
EXEC sp_deleteEverUser 4;


SELECT * FROM Usuarios
SELECT * FROM Suscripciones
SELECT * FROM HistorialVisualizacion