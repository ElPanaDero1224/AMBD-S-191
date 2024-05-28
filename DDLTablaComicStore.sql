CREATE TABLE Clientes(
id_cliente bigint identity(1,1) PRIMARY KEY,
nombre VARCHAR(100),
correo_electronico VARCHAR(255),
pass VARCHAR(255)
);

SELECT * FROM Clientes;

INSERT INTO Clientes (nombre, correo_electronico, pass) VALUES
('Juan Pérez', 'juan.perez@example.com', 'pass123Juan'),
('María García', 'maria.garcia@example.com', 'pass123Maria'),
('Carlos López', 'carlos.lopez@example.com', 'pass123Carlos'),
('Ana Martínez', 'ana.martinez@example.com', 'pass123Ana'),
('Luis Fernández', 'luis.fernandez@example.com', 'pass123Luis'),
('Laura Sánchez', 'laura.sanchez@example.com', 'pass123Laura'),
('José Rodríguez', 'jose.rodriguez@example.com', 'pass123Jose'),
('Marta Gómez', 'marta.gomez@example.com', 'pass123Marta'),
('Pedro Díaz', 'pedro.diaz@example.com', 'pass123Pedro'),
('Lucía Ruiz', 'lucia.ruiz@example.com', 'pass123Lucia'),
('Sergio Torres', 'sergio.torres@example.com', 'pass123Sergio'),
('Elena Ramírez', 'elena.ramirez@example.com', 'pass123Elena');





CREATE TABLE Comics(
id_comic BIGINT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(255),
anio INT,
precio float
);

SELECT * FROM Comics;

INSERT INTO Comics (nombre, anio, precio) VALUES
('Batman: Year One', 1987, 12.99),
('The Dark Knight Returns', 1986, 14.99),
('Watchmen', 1986, 19.99),
('Maus', 1991, 16.50),
('V for Vendetta', 1988, 13.75),
('The Sandman: Preludes and Nocturnes', 1989, 15.99),
('Saga', 2012, 9.99),
('Y: The Last Man', 2002, 10.99),
('Spider-Man: Blue', 2002, 11.99),
('Daredevil: Born Again', 1986, 14.50),
('Sin City: The Hard Goodbye', 1991, 13.25),
('Batman: The Killing Joke', 1988, 12.50),
('Superman: Red Son', 2003, 16.00),
('Fables: Legends in Exile', 2002, 9.75),
('Preacher: Gone to Texas', 1995, 14.00);





CREATE TABLE Comic_Compras(
id_CC BIGINT IDENTITY(1,1) PRIMARY KEY,
cantidad TINYINT,
id_compra BIGINT,
id_comic BIGINT,
FOREIGN KEY(id_compra) REFERENCES Compras(id_compra),
FOREIGN KEY(id_comic) REFERENCES Comics(id_comic)
);

INSERT INTO Comic_Compras(cantidad, id_compra, id_comic) VALUES
(1, 1, 2),
(1, 2, 2),
(1, 3, 2),
(1, 4, 2),
(1, 5, 2),
(1, 6, 2),
(1, 7, 2),
(7, 8, 2),
(5, 9, 2),
(2, 10, 2),
(3, 11, 2),
(4, 12, 2),
(2, 13, 2),
(3, 14, 2),
(1, 15, 2),
(2, 16, 2),
(4, 17, 2);




CREATE TABLE Compras(
id_compra BIGINT IDENTITY(1,1) PRIMARY KEY,
fecha_compra DATE,
id_cliente BIGINT,
total float,
FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

select * from Compras;
INSERT INTO Compras (fecha_compra, id_cliente, total) VALUES
('2024-05-27', 1, 50.00),  
('2024-05-27', 2, 35.00),  
('2024-05-27', 3, 20.00),
('2024-01-01', 4, 40.00),  
('2024-02-15', 5, 35.00),  
('2024-03-22', 6, 22.00),  
('2024-04-30', 7, 15.00),  
('2024-06-10', 8, 78.00),  
('2024-07-20', 8, 18.00),  
('2024-08-30', 8, 88.00),  
('2024-10-05', 9, 9.00),   
('2024-11-15', 9, 11.00),  
('2024-12-25', 9, 13.00), 
('2025-02-01', 10, 17.00), 
('2025-03-15', 10, 8.00),
('2024-01-01', 10, 50.00),
('2024-03-15', 10, 35.00);



CREATE TABLE Inventario(
id_inventario BIGINT IDENTITY(1,1) PRIMARY KEY,
id_comic BIGINT,
cantidad_disponible INT,
disponibilidad BINARY,
FOREIGN KEY(id_comic) REFERENCES Comics(id_comic)
);

select * from Inventario;

INSERT INTO Inventario (id_comic, cantidad_disponible, disponibilidad) VALUES
(1, 10, 1),
(2, 0, 0),
(3, 15, 1),
(4, 5, 1),
(5, 20, 1),
(6, 8, 1),
(7, 12, 1),
(8, 0, 0),
(9, 6, 1),
(10, 3, 1),
(11, 7, 1),
(12, 9, 1),
(13, 14, 1),
(14, 11, 1),
(15, 4, 1);


