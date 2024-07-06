CREATE PROCEDURE sp_AgregarComicsInventario
    @nombre NVARCHAR(255),
    @anio INT,
    @precio DECIMAL(7,2),
    @idautor INT,
    @cantidaddisponible INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO Comics (nombre, anio, precio, id_autor)
        VALUES (@nombre, @anio, @precio, @idautor);

        DECLARE @idcomic INT;
        SET @idcomic = SCOPE_IDENTITY();

        DECLARE @disponibilidad BINARY;
        IF @cantidaddisponible = 0
        BEGIN
            SET @disponibilidad = 0x00;
        END
        ELSE
        BEGIN
            SET @disponibilidad = 0x01;
        END

        -- Insertar en la tabla Inventario
        INSERT INTO Inventario (id_comic, cantidad_disponible, disponibilidad)
        VALUES (@idcomic, @cantidaddisponible, @disponibilidad);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        PRINT @ErrorMessage;
    END CATCH;
END;


EXEC sp_AgregarComicsInventario 'Vinland Saga 1', 2005, 12.25, 300, 25;
EXEC sp_AgregarComicsInventario 'Berserk 1', 1989, 12.25, 303, 10;
EXEC sp_AgregarComicsInventario 'PLANETES', 1999, 12.25, 300, 5;



SELECT * FROM Comics;
SELECT * FROM Autores;
SELECT * FROM Inventario;



#Ejercicio 2

CREATE PROCEDURE sp_eliminarUsuarioydatos
    @idusuario INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @idcompra INT;
        DECLARE @cursor CURSOR;
        -- Crear un cursor para recorrer cada id_compra
        SET @cursor = CURSOR FOR 
        SELECT id_compra 
        FROM Compras 
        WHERE id_cliente = @idusuario;
        OPEN @cursor;
        FETCH NEXT FROM @cursor INTO @idcompra;
        WHILE @@FETCH_STATUS = 0
        BEGIN
            DELETE FROM Comic_Compras WHERE id_compra = @idcompra;
            FETCH NEXT FROM @cursor INTO @idcompra;
        END;
        CLOSE @cursor;
        DEALLOCATE @cursor;
        -- Eliminar compras y cliente
        DELETE FROM Compras WHERE id_cliente = @idusuario;
        DELETE FROM Clientes WHERE id_cliente = @idusuario;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        PRINT @ErrorMessage;
    END CATCH;
END;



EXEC sp_eliminarUsuarioydatos 10;
EXEC sp_eliminarUsuarioydatos 9;
EXEC sp_eliminarUsuarioydatos 8;

Select * from Comic_Compras;
SELECT * FROM Compras;
select * from Clientes;


#EJERCICIO 3


CREATE PROCEDURE sp_ingresarAutoresycomic
    @nombre VARCHAR(100),
	@po VARCHAR(100),
	@ncomic VARCHAR(255),
	@anio INT,
	@precio DECIMAL(7,2)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
       INSERT INTO Autores(nombre, pais_origen)
	   VALUES (@nombre, @po);
	   DECLARE @idautor INT
	   SET @idautor = SCOPE_IDENTITY()
	   INSERT INTO Comics(nombre, anio, precio, id_autor)
	   VALUES (@ncomic, @anio, @precio, @idautor)
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        PRINT @ErrorMessage;
    END CATCH;
END;

SELECT * FROM Autores;
SELECT * FROM Comics;


EXEC sp_ingresarAutoresyComic 'Eiichiro Oda', 'Japón', 'One Piece', 1997, 9.99;
EXEC sp_ingresarAutoresyComic 'Masashi Kishimoto', 'Japón', 'Naruto', 1999, 8.99;
EXEC sp_ingresarAutoresyComic 'Hajime Isayama', 'Japón', 'Attack on Titan', 2009, 10.50;


#EJERCICIO 4


CREATE PROCEDURE sp_generarCompra
    @idcliente INT,
    @idcomic INT,
    @cantidad INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @cantidad_disponible INT, @precio FLOAT, @idcompra INT;

        -- Verificar la disponibilidad del comic
        SELECT @cantidad_disponible = cantidad_disponible
        FROM Inventario
        WHERE id_comic = @idcomic;

        IF @cantidad_disponible >= @cantidad
        BEGIN
            -- Insertar una nueva compra
            INSERT INTO Compras (fecha_compra, id_cliente, total)
            VALUES (GETDATE(), @idcliente, 0);

            -- Obtener el ID de la compra recién insertada
            SET @idcompra = SCOPE_IDENTITY();

            -- Insertar en la tabla Comic_Compras
            INSERT INTO Comic_Compras (cantidad, id_compra, id_comic)
            VALUES (@cantidad, @idcompra, @idcomic);

            -- Obtener la cantidad comprada
            SELECT @cantidad = cantidad
            FROM Comic_Compras
            WHERE id_compra = @idcompra;

            -- Obtener el precio del comic
            SELECT @precio = precio
            FROM Comics
            WHERE id_comic = @idcomic;

            -- Actualizar el total de la compra
            UPDATE Compras
            SET total = @precio * @cantidad
            WHERE id_compra = @idcompra;

            -- Actualizar la cantidad disponible en el inventario
            UPDATE Inventario
            SET cantidad_disponible = cantidad_disponible - @cantidad
            WHERE id_comic = @idcomic;
        END
        ELSE
        BEGIN
            -- Si la cantidad no está disponible, imprimir un mensaje
            PRINT 'La cantidad de comics no está disponible';
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, hacer rollback y mostrar el mensaje de error
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        PRINT @ErrorMessage;
    END CATCH;
END;


EXEC sp_generarCompra 1, 18, 5;
EXEC sp_generarCompra 2, 1, 1;
EXEC sp_generarCompra 4, 4, 3;

SELECT * FROM Clientes;
SELECT * FROM Compras
SELECT * FROM Inventario
SELECT * FROM Comic_Compras












#EJERCICIO 5
#Borrar comics y todo lo relacionado
CREATE PROCEDURE sp_borrarC
    @idcomic INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DECLARE @idcompra TABLE (id_compra INT);  

        INSERT INTO @idcompra (id_compra)
        SELECT id_compra FROM Comic_Compras WHERE id_comic = @idcomic;
        DECLARE @id_compra INT;
        DECLARE cur CURSOR FOR
        SELECT id_compra FROM @idcompra;
        OPEN cur;
        FETCH NEXT FROM cur INTO @id_compra;
        WHILE @@FETCH_STATUS = 0
        BEGIN
			DELETE FROM Comic_Compras WHERE id_comic = @idcomic AND id_compra = @id_compra;
            DELETE FROM Compras WHERE id_compra = @id_compra;
            FETCH NEXT FROM cur INTO @id_compra;
        END
		    
			DELETE FROM Inventario WHERE id_comic = @idcomic;
            DELETE FROM Comics WHERE id_comic = @idcomic;

        CLOSE cur;
        DEALLOCATE cur;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si ocurre un error, hacer rollback y mostrar el mensaje de error
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        PRINT @ErrorMessage;
    END CATCH;
END;

EXEC sp_borrarC 2;
EXEC sp_borrarC 3;
EXEC sp_borrarC 1;
EXEC sp_borrarC 6;


SELECT * FROM Comic_Compras
SELECT * FROM Compras
SELECT * FROM Comics
SELECT * FROM Inventario