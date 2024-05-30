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