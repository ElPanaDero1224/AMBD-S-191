--ComprasComics
CREATE VIEW Vista_ComprasComic AS
SELECT CC.id_CC, CC.cantidad, C.nombre, cc.id_compra, Co.fecha_compra, Co.total
FROM Comic_Compras AS CC 
JOIN Comics AS C on C.id_comic = CC.id_comic
JOIN Compras AS Co ON Co.id_compra = CC.id_compra

SELECT * FROM Vista_ComprasComic;

--ComicsComprados

CREATE VIEW Vista_ComicsComprados AS
SELECT cl.id_cliente, cl.nombre AS Nombre_cliente, SUM(CC.cantidad) AS Cantidad_Comic_Comprados
FROM Clientes AS Cl
JOIN Compras AS C on C.id_cliente = cl.id_cliente
JOIN Comic_Compras AS CC ON CC.id_compra = c.id_compra
GROUP BY Cl.id_cliente, CL.nombre;

SELECT * FROM Vista_ComicsComprados;


SELECT * FROM Vista_AutoresComics;

SELECT * FROM Vista_ComprasClienteAutores;

