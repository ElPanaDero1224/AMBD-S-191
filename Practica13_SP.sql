--Crea un procedimiento almacenado con el cual podremos Insertar usuarios atreves de los parámetros
--Se hace la creacion del procedimiento

CREATE PROCEDURE sp_ingresar
--declaracion de las variables
	@Nombre NVARCHAR(100),
	@Email NVARCHAR(100),
	@Passw NVARCHAR(100),
	@Fecha date
	AS
--inicio del metodo
BEGIN
	INSERT INTO Usuarios(Nombre, Email, Pass, FechaRegistro) VALUES(@Nombre, @Email, @Passw, @Fecha)
END;

select * from Usuarios;

EXEC sp_ingresar @Nombre = 'Samuel Elizalde', @Email = 'samuel@example.com', @Passw = 'hola', @Fecha = '2024-06-26'
EXEC sp_ingresar @Nombre = 'Josue Elizalde', @Email = 'Josue@example.com', @Passw = 'Adios', @Fecha = '2024-06-11'
EXEC sp_ingresar @Nombre = 'Nohemi Elizalde', @Email = 'Nohemi@example.com', @Passw = 'saludos', @Fecha = '2023-06-11'
EXEC sp_ingresar @Nombre = 'Asher Fraga', @Email = 'Asher@example.com', @Passw = 'lvnmtb', @Fecha = '2022-07-12'



-- Crea un procedimiento almacenado para Editar una Suscripción (tipo de suscripcion)


CREATE PROCEDURE sp_altSuscripcion
--declaracion de las variables
	@tipo NVARCHAR(50),
	@idusuario int
	AS
BEGIN
	UPDATE Suscripciones SET Tipo = @tipo WHERE UsuarioID = @idusuario;
	
END;

select * from Suscripciones;

EXEC sp_altSuscripcion @tipo = 'Anual', @idusuario = 2
EXEC sp_altSuscripcion @tipo = 'Semestral', @idusuario = 1
EXEC sp_altSuscripcion @tipo = 'Anual', @idusuario = 6
EXEC sp_altSuscripcion @tipo = 'Bimestral', @idusuario = 5




-- Crea un procedimiento para Eliminar un registro en la tabla de Historial Visualización

CREATE PROCEDURE sp_borrarHistorialVisualizacion
--declaracion de las variables
	@id int
	AS
BEGIN
	DELETE FROM HistorialVisualizacion WHERE HistorialID = @id;
END;

EXEC sp_borrarHistorialVisualizacion @id = 13;
EXEC sp_borrarHistorialVisualizacion @id = 16;
EXEC sp_borrarHistorialVisualizacion @id = 5;

select * from HistorialVisualizacion;






--Crea un procedimiento para consultar los usuarios con su suscripción, que use como parámetro el tipo de suscripción

CREATE PROCEDURE sp_UsuariosSuscripcion
--declaracion de las variables
	@tipo NVARCHAR(50)
	AS
BEGIN

select u.Nombre, s.Tipo
from Suscripciones as s
right join Usuarios as u on s.UsuarioID = u.UsuarioID
WHERE S.Tipo = @tipo;

END;

EXEC sp_UsuariosSuscripcion @tipo = 'Bimestral'


--Crea un procedimiento para consultar que películas fueron reproducidas por el usuario pasando como parámetro el género de la película

CREATE PROCEDURE sp_peliculasGenero
	@genero NVARCHAR(50)
	AS
BEGIN
	select u.Nombre, p.Titulo, p.Genero
	from HistorialVisualizacion AS h
	JOIN Usuarios as u ON h.UsuarioID = U.UsuarioID
	JOIN Peliculas as p ON P.PeliculaID = H.PeliculaID
	WHERE p.Genero = @genero
END;

EXEC sp_peliculasGenero @genero = 'Drama'
EXEC sp_peliculasGenero @genero = 'Crime'
EXEC sp_peliculasGenero @genero = 'Sci-Fi'






select * from Peliculas;

