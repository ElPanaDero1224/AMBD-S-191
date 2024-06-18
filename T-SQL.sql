
--TSQL

--declaracion de variables
--declare: Coloca la variable
--set inicializa la variable
--Es necesario el @ para las variables

declare @idCliente int
--inicializar o asignar valor
set @idCliente = 9

--if 

--IF @idCliente = 8
--	Select * from clientes WHERE id_cliente = @idCliente

--para ejecutar el codigo necesitamos dar clic derecho y seleccionar la opción "execute".


--Cuando la condicion no se cumple no sucede nada, pero cuando si aparece la tabla en result

/*

--para delimitar un if necesitamos usar "Begin" y "End"
declare @edad int
set @idCliente = 9
if @idCliente = 9
	begin
	set @edad = 25
	Select * from clientes WHERE id_cliente = @idCliente
	print @edad
--If exist sirve para determinar si es verdad un valor
	IF EXISTS(SELECT * FROM Clientes where id_cliente = 100)
	print 'Si existe'
	end
ELSE
--para delimitar un else necesitamos usar "begin" y "end"
	PRINT 'ERROR:'
	PRINT 'id no autorizado para la consulta'
*/



--While
declare @contador int = 0
while @contador <=10
BEGIN
	print @contador
	set @contador = @contador + 1
END





print