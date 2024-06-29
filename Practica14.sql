


--Procedimiento para agregar autores a la DB
CREATE PROCEDURE sp_InsertAutor
	@nombre NVARCHAR(100),
	@pais NVARCHAR(100)
AS
BEGIN

insert into Autores(nombre, pais_origen) 
VALUES(@nombre, @pais)
END;

--Ejecucion de los procedimientos
EXEC sp_InsertAutor @nombre = 'Takehiko Inoue', @pais = 'Japon'
EXEC sp_InsertAutor @nombre = 'Tsubasa Yamaguchi', @pais = 'Japon'
EXEC sp_InsertAutor @nombre = 'Osamu Tezuka', @pais = 'Japon'

select * from Autores;





--Procedimiento para ingresar clientes a la tabla
CREATE PROCEDURE sp_InsertCliente
	@nombre NVARCHAR(100),
	@correo NVARCHAR(100),
	@passw NVARCHAR(100)
AS
BEGIN
insert into Clientes(nombre, correo_electronico, pass) VALUES (@nombre, @correo, @passw)
END;

--ejecucion de los procedimientos para realizar la insercion

EXEC sp_InsertCliente @nombre = 'Sebastian Catillos', @correo = 'Sebastian@example.com', @passw = '123454321'
EXEC sp_InsertCliente @nombre = 'Arthur Morgan', @correo = 'Arthur@example.com', @passw = 'isabm'
EXEC sp_InsertCliente @nombre = 'Mark Greyson', @correo = 'Mark Greyson@example.com', @passw = 'ultraman'

select * from Clientes;









--Procedimientos para editar el precio de un comic

CREATE PROCEDURE sp_UpdatePrecio
    @precio decimal(7,2),
    @idcomic int
AS
BEGIN
    UPDATE Comics 
    SET precio = @precio 
    WHERE id_comic = @idcomic;
END;


EXEC sp_UpdatePrecio @precio = 7.25, @idcomic = 1;
EXEC sp_UpdatePrecio @precio = 20.22, @idcomic = 2;
EXEC sp_UpdatePrecio @precio = 25.22, @idcomic = 3;

Select * from Comics;



--procedimientos para modificar la cantidad de comics en el inventario

CREATE PROCEDURE sp_UpdateInventario
	@cant int,
	@idinventario int
AS
BEGIN
	UPDATE Inventario SET cantidad_disponible = @cant
	WHERE  id_inventario =  @idinventario
END;

select * from Inventario;

EXEC sp_UpdateInventario @cant = 55, @idinventario = 1
EXEC sp_UpdateInventario @cant = 22, @idinventario = 2
EXEC sp_UpdateInventario @cant = 5, @idinventario = 3



--procedimientos para eliminar un dato de comic compras

CREATE PROCEDURE sp_deleteCC
    @idCC int
AS
BEGIN
    DELETE FROM Comic_Compras 
    WHERE id_CC = @idCC;
END;


Select * from Comic_Compras;

EXEC sp_deleteCC @idCC = 1
EXEC sp_deleteCC @idCC = 2
EXEC sp_deleteCC @idCC = 3






--Procedimiento para borrar un autor
CREATE PROCEDURE sp_deleteAutor
 @id int
 AS
BEGIN
	DELETE FROM Autores WHERE id_autor = @id
END;

select * from Autores;

EXEC sp_deleteAutor @id = 306
EXEC sp_deleteAutor @id = 305
EXEC sp_deleteAutor @id = 304


select * from Comics;


--Procedimiento para ver loc comics que sean menores al precio ingresado
CREATE PROCEDURE sp_ViewComicsPrecio
	@precio DECIMAL(7,2)
	AS
BEGIN
SELECT c.nombre, A.nombre, c.precio
FROM Comics AS C
LEFT JOIN Autores AS a ON a.id_autor = c.id_autor
WHERE c.precio <= @precio;
END;

EXEC sp_ViewComicsPrecio @precio = 15.00;
EXEC sp_ViewComicsPrecio @precio = 11.00;
EXEC sp_ViewComicsPrecio @precio = 9.00;



--Procedimiento para ver los comics de un autor
CREATE PROCEDURE sp_ViewComicAutor
	@nombre NVARCHAR(100)
AS
BEGIN
	SELECT C.nombre, C.precio, A.nombre
	FROM Comics AS c 
	JOIN Autores AS a ON c.id_autor = a.id_autor
	WHERE A.nombre = @nombre;
END

EXEC sp_ViewComicAutor @nombre = 'Makoto Yukimura';
EXEC sp_ViewComicAutor @nombre = 'Kentaro Miura';
EXEC sp_ViewComicAutor @nombre = 'Tim Burton';


--Procedimiento para ver las compras de un usuario

CREATE PROCEDURE sp_comprasUsuario
	@nombre NVARCHAR(150)
AS
BEGIN
SELECT cl.nombre, cc.cantidad, c.nombre
FROM Comic_Compras AS cc
JOIN Comics AS c on c.id_comic = cc.id_comic
JOIN Compras AS co on cc.id_compra = co.id_compra
JOIN Clientes AS cl ON co.id_cliente = cl.id_cliente
WHERE cl.nombre = @nombre
END;

EXEC sp_comprasUsuario @nombre = 'Ana Martínez';
EXEC sp_comprasUsuario @nombre = 'Luis Fernández';
EXEC sp_comprasUsuario @nombre = 'Marta Gómez';
Select * from Clientes;