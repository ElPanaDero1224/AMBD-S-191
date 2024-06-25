--Procedimientos predetefinidos (no se hace otra cosa mas que ejecutarlo)

--Explorar las propiedades de la base de datos
--Palabra reservada (EXEC)
EXEC sp_helpdb

EXEC sp_helpdb 'ComicStore'



--(SP_HELP)
--Muestra las propiedades que tiene una tabla de una BD

EXEC sp_help 'Clientes'

--Llaves primarias de unas tablas

EXEC sp_helpindex'Clientes'

--informacion de los usuarios y procesos actuales
EXEC sp_who

--Rendimiento del servidor
EXEC sp_monitor

--Espcaio usado por la BD

EXEC sp_spaceused

--En que puerto se esta trabajando (puerto de escucha del SQL Server)
exec sp_readerrorlog 0,1

--nuestros propios procedimientos almacenados

CREATE PROCEDURE sp_ObtenerHistorial
	@usuarioId int
AS
BEGIN
	SELECT h.HistorialID, p.Titulo, h.fechaVisualizacion
	FROM HistorialVisualizacion AS h
	JOIN Peliculas AS p ON h.PeliculaID = p.PeliculaID
	WHERE h.UsuarioID = @usuarioId
	ORDER BY h.FechaVisualizacion DESC
END;

--Para correr el procedimiento se tiene que usar el comando EXEC y el nombre del procedimiento
--muestra las peliculas que el usuario vio

EXEC sp_ObtenerHistorial 1;


CREATE PROCEDURE sp_insertarPeliculas
@titulo NVARCHAR(100),
@genero NVARCHAR(50),
@fechaEstreno DATE
AS
BEGIN
	INSERT INTO Peliculas (Titulo, Genero, FechaEstreno) 
	VALUES(@titulo, @genero, @fechaEstreno)
END;

EXEC sp_insertarPeliculas @titulo = 'Intensamente 2', @genero = 'Infantil', @fechaEstreno = '2024-06-13'

SELECT * FROM Peliculas;

