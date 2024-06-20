CREATE TABLE Usuarios (
	UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100) NOT NULL,
	Email NVARCHAR(100) NOT NULL UNIQUE,
	Pass NVARCHAR(100) NOT NULL,
	FechaRegistro DATE NOT NULL DEFAULT GETDATE()
);

--10 Usuarios
INSERT INTO Usuarios (Nombre, Email, Pass, FechaRegistro)
VALUES 
('Juan Perez', 'juan.perez@example.com', 'password123', '2012-06-20'),
('Maria Gomez', 'maria.gomez@example.com', 'password456', '2013-07-15'),
('Carlos Ruiz', 'carlos.ruiz@example.com', 'password789', '2014-08-10'),
('Ana Martinez', 'ana.martinez@example.com', 'password101', '2015-09-05'),
('Luis Hernandez', 'luis.hernandez@example.com', 'password112', '2016-10-30'),
('Sofia Lopez', 'sofia.lopez@example.com', 'password131', '2017-11-25'),
('Diego Torres', 'diego.torres@example.com', 'password415', '2018-12-20'),
('Laura Ramirez', 'laura.ramirez@example.com', 'password161', '2019-01-15'),
('Miguel Sanchez', 'miguel.sanchez@example.com', 'password718', '2020-02-10'),
('Elena Fernandez', 'elena.fernandez@example.com', 'password192', '2021-03-05');

SELECT * FROM Usuarios;


CREATE TABLE Peliculas(
	PeliculaID INT IDENTITY(1,1) PRIMARY KEY,
	Titulo NVARCHAR(100) NOT NULL,
	Genero NVARCHAR(50),
	FechaEstreno DATE
);

--11 Películas
INSERT INTO Peliculas (Titulo, Genero, FechaEstreno)
VALUES 
('The Shawshank Redemption', 'Drama', '1994-09-22'),
('The Godfather', 'Crime', '1972-03-24'),
('The Dark Knight', 'Action', '2008-07-18'),
('Pulp Fiction', 'Crime', '1994-10-14'),
('The Lord of the Rings: The Return of the King', 'Fantasy', '2003-12-17'),
('Forrest Gump', 'Drama', '1994-07-06'),
('Inception', 'Sci-Fi', '2010-07-16'),
('Fight Club', 'Drama', '1999-10-15'),
('The Matrix', 'Sci-Fi', '1999-03-31'),
('Goodfellas', 'Crime', '1990-09-19'),
('The Silence of the Lambs', 'Thriller', '1991-02-14');

SELECT * FROM Peliculas;

CREATE TABLE Suscripciones(
	SuscripcionID INT IDENTITY(1,1) PRIMARY KEY,
	UsuarioID INT NOT NULL,
	FechaInicio DATE NOT NULL,
	FechaFin Date,
	Tipo NVARCHAR(50),
	FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
	
);


INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo)
VALUES 
(1, '2024-01-01', '2024-12-31', 'Anual'),
(2, '2024-02-01', '2024-08-01', 'Semestral'),
(3, '2024-03-01', '2024-09-01', 'Semestral'),
(4, '2024-04-01', '2025-04-01', 'Anual'),
(5, '2024-05-01', '2024-11-01', 'Semestral');


INSERT INTO Suscripciones (UsuarioID, FechaInicio, FechaFin, Tipo)
VALUES 
(6, '2024-06-01', NULL, NULL),
(7, '2024-07-01', NULL, NULL);

SELECT * FROM Suscripciones;


CREATE TABLE HistorialVisualizacion(
	HistorialID INT IDENTITY(1,1) PRIMARY KEY,
	UsuarioID INT NOT NULL,
	PeliculaID INT NOT NULL,
	FechaVisualizacion DATETIME NOT NULL DEFAULT GETDATE(),
	FOREIGN KEY(UsuarioID) REFERENCES Usuarios(UsuarioID),
	FOREIGN KEY (PeliculaID) REFERENCES Peliculas(PeliculaID)
);



INSERT INTO HistorialVisualizacion (UsuarioID, PeliculaID, FechaVisualizacion)
VALUES 
(1, 1, '2024-01-01 12:00:00'),
(2, 2, '2024-01-02 13:00:00'),
(3, 3, '2024-01-03 14:00:00'),
(4, 4, '2024-01-04 15:00:00'),
(5, 5, '2024-01-05 16:00:00'),
(6, 6, '2024-01-06 17:00:00'),
(7, 7, '2024-01-07 18:00:00'),
(8, 8, '2024-01-08 19:00:00'),
(9, 9, '2024-01-09 20:00:00'),
(10, 10, '2024-01-10 21:00:00'),
(1, 2, '2024-01-11 12:00:00'),
(2, 3, '2024-01-12 13:00:00'),
(3, 4, '2024-01-13 14:00:00'),
(4, 5, '2024-01-14 15:00:00'),
(5, 6, '2024-01-15 16:00:00'),
(6, 7, '2024-01-16 17:00:00'),
(7, 8, '2024-01-17 18:00:00'),
(8, 9, '2024-01-18 19:00:00'),
(9, 10, '2024-01-19 20:00:00'),
(10, 1, '2024-01-20 21:00:00');





