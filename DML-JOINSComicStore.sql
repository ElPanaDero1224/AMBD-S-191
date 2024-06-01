USE ComicStore;

--inner JOIN

SELECT c.id_compra, cl.nombre  AS CLIENTE, c.fecha_compra, c.total
FROM Compras c
JOIN Clientes cl on c.id_cliente = cl.id_cliente;

---left

SELECT c.id_compra, cl.nombre  AS CLIENTE, c.fecha_compra, c.total
FROM Compras c
left JOIN Clientes cl on c.id_cliente = cl.id_cliente;

--right


SELECT c.id_compra, cl.nombre  AS CLIENTE, c.fecha_compra, c.total
FROM Compras c
right JOIN Clientes cl on c.id_cliente = cl.id_cliente;

--full

SELECT *
FROM Clientes as cl
FULL JOIN Compras as c
on c.id_cliente = cl.id_cliente


--Crea una consulta para obtener el nombre del cómic con los disponibles en el inventario

SELECT c.nombre AS nombre, i.cantidad_disponible as "Cantidad disponible"
FROM Inventario as i
INNER JOIN Comics as c ON c.id_comic = i.id_comic;


--Crea una consulta para desplegar los detalles de las compras realizadas por cada cliente y los cómics comprados
SELECT Cl.nombre, Co.id_compra, C.nombre, CC.cantidad
FROM Compras as Co
JOIN Comic_Compras as CC on CC.id_compra = Co.id_compra
JOIN Clientes as cl on Cl.id_cliente = Co.id_cliente
JOIN Comics as C ON C.id_comic = CC.id_comic;

--Crea una consulta para obtener todas las compras junto con la cantidad disponible de cómics en el inventario incluidos los que no han sido comprados

SELECT c.id_compra, Co.nombre, i.cantidad_disponible
FROM Compras AS c
INNER JOIN Comic_Compras AS CC ON CC.id_compra = c.id_compra
JOIN Comics AS Co ON C.id_compra = C.id_compra
JOIN Inventario AS i ON Co.id_comic = i.id_comic;


--Consulta para enlistar todos los cómics y su cantidad disponible en el inventario

SELECT C.nombre, I.cantidad_disponible
FROM Comics AS C
JOIN Inventario AS i ON C.id_comic = i.id_comic;

--Crea una consulta todos datos de los comics, comics compras e inventario disponible

SELECT *
FROM Compras AS c
LEFT JOIN Comic_Compras AS CC ON CC.id_compra = c.id_compra
JOIN Comics AS Co ON C.id_compra = C.id_compra
JOIN Inventario AS i ON Co.id_comic = i.id_comic;

--Crea una consulta que muestre solo los clientes que compraron algo con su id de compra nombre del comic ,cantidad de compra y los disponibles en inventario

SELECT Cl. nombre AS CLIENTE, C.id_compra AS COMPRA, Cm.nombre AS COMIC, CC.cantidad as CANTIDAD, i.cantidad_disponible
FROM Clientes AS Cl
JOIN Compras as C ON c.id_cliente = Cl.id_cliente
join Comic_Compras AS CC ON CC.id_compra = C.id_compra
JOIN Comics AS Cm ON Cm.id_comic = CC.id_comic
JOIN Inventario AS i ON Cm.id_comic = i.id_comic;
