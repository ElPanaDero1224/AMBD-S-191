USE ComicStore;

CREATE TABLE Autores (
id_autor bigint identity(300,1) PRIMARY KEY,
nombre VARCHAR(100),
pais_origen VARCHAR(100)
);

SELECT * FROM Comics;

SELECT * FROM Autores;

ALTER TABLE Comics
ADD id_autor bigint,
FOREIGN KEY (id_autor) REFERENCES Autores(id_autor);


UPDATE Comics SET id_autor = 301 WHERE id_comic = 1;
UPDATE Comics SET id_autor = 300 WHERE id_comic = 2;
UPDATE Comics SET id_autor = 302 WHERE id_comic = 3;
UPDATE Comics SET id_autor = 301 WHERE id_comic = 4;
UPDATE Comics SET id_autor = 303 WHERE id_comic = 5;
UPDATE Comics SET id_autor = 300 WHERE id_comic = 6;
UPDATE Comics SET id_autor = 300 WHERE id_comic = 7;
UPDATE Comics SET id_autor = 301 WHERE id_comic = 8;
UPDATE Comics SET id_autor = 301 WHERE id_comic = 9;
UPDATE Comics SET id_autor = 302 WHERE id_comic = 10;
UPDATE Comics SET id_autor = 303 WHERE id_comic = 11;

UPDATE Autores SET pais_origen = 'Japon' WHERE id_autor = 300;


INSERT INTO Autores(nombre, pais_origen) VALUES
('Tim Burton', 'Estados Unidos'),
('Guillermo Del Toro', 'Mexico'),
('Kentaro Miura', 'Japon');



SELECT A.nombre AS nombre, C.nombre AS Nombre_Comic, I.cantidad_disponible AS Cantidad_Disponible
FROM Autores as A
RIGHT JOIN Comics AS C ON C.id_autor = A.id_autor
INNER JOIN Inventario AS I ON I.id_comic = C.id_comic;

SELECT A.pais_origen AS Pais_origen, A.nombre AS Nombre_autor, C.nombre AS Comic_nombre
FROM Comics AS C
RIGHT JOIN Autores AS A ON A.id_autor = C.id_autor;