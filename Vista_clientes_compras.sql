USE ComicStore;

CREATE VIEW VISTA_ClientesCompras AS
SELECT c.id_cliente, c.nombre AS CLIENTE, c.correo_electronico, cm.id_compra, cm.fecha_compra, cm.total
FROM Clientes as c
LEFT JOIN Compras as cm on c.id_cliente = cm.id_cliente;

SELECT * FROM VISTA_ClientesCompras;


SELECT * FROM Vista_ComicsInventario;

SELECT * FROM Vista_ClientesComprasComicsComic_Compras;