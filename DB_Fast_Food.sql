--Crear Base de datos
CREATE DATABASE DB_Fast_Food

--Crear 10 Tablas
USE DB_Fast_Food

CREATE TABLE OrigenesOrden(
	OrigenID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(255));

CREATE TABLE Categorias(
	CategoriaID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255));

CREATE TABLE Productos(
	ProductoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL, --Mandatorio
	CategoriaID INT,
	Precio DECIMAL (10,2) NOT NULL);

CREATE TABLE Clientes(
	ClienteID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	Direccion VARCHAR(255));


CREATE TABLE TiposPago(
	TipoPagoID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(255) NOT NULL);


CREATE TABLE Mensajeros(
	MensajeroID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	EsExterno BIT NOT NULL);


CREATE TABLE Empleados(
	EmpleadoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	Posicion VARCHAR (255),
	Departamento VARCHAR (255),
	SucursalID INT,
	Rol VARCHAR (255));

CREATE TABLE Sucursales(
	SucursalID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	Direccion VARCHAR(255)
	);

CREATE TABLE Ordenes(
	OrdenID INT PRIMARY KEY IDENTITY,
	ClienteID INT ,
	EmpleadoID INT,
	SucursalID INT ,
	MensajeroID INT ,
	TipoPagoID INT ,
	OrigenID INT ,
	HorarioVenta VARCHAR(50), --Jornadas: mañana, tarde, noche
	TotalCompra DECIMAL (10,2), 
	KilometrosRecorrer DECIMAL (10,2),
	FechaDespacho DATETIME,
	FechaEntrega DATETIME,
	FechaOrdenTomada DATETIME,
	FechaOrdenLista DATETIME);

CREATE TABLE DetalleOrdenes(
	PRIMARY KEY (OrdenID, ProductoID),
	OrdenID INT ,
	ProductoiD INT ,
	Cantidad INT,
	Precio DECIMAL (10,2) NOT NULL);
	
--Definir Relaciones entre tablas 

--FK DetalleOrdenes - Ordenes - OrdenID
ALTER TABLE DetalleOrdenes
ADD CONSTRAINT FK_Ordenes_DetalleOrdenes_OrdenID
FOREIGN KEY (OrdenID) REFERENCES Ordenes(OrdenID);

--FK DetalleOrdenes - Ordenes - ProductoID
ALTER TABLE DetalleOrdenes
ADD CONSTRAINT FK_Ordenes_DetalleOrdenes_ProductoID
FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID);

--FK Ordenes-Clientes
ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Clientes
FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID);


--FK Ordenes-Empleados
ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Empleados
FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID);

--FK Ordenes-Sucursales
ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Sucursales
FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID);

--FK Ordenes-Mensajeros
ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Mensajeros
FOREIGN KEY (MensajeroID) REFERENCES Mensajeros(MensajeroID);

--FK Ordenes-TipoPago
ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_TipoPago
FOREIGN KEY (TipoPagoID) REFERENCES TiposPago(TipoPagoID);

--FK Ordenes-OrigenesOrden
ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_OrigenesOrden
FOREIGN KEY (OrigenID) REFERENCES OrigenesOrden(OrigenID);

--FK Productos-Categorias
ALTER TABLE Productos
ADD CONSTRAINT FK_Productos_Categorias
FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID);

--FK Empleados-Sucursales
ALTER TABLE Empleados
ADD CONSTRAINT FK_Empleados_Sucursales
FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID);

/* INSERCIÓN DE DATOS */

-- Insertar datos en Categorias
INSERT INTO Categorias (Nombre) VALUES
('Comida Rápida'), ('Postres'), ('Bebidas'), ('Ensaladas'), ('Desayunos'),
('Cafetería'), ('Helados'), ('Comida Vegana'), ('Carnes'), ('Pizzas');

Select * from Categorias

-- Insertar datos en Productos
INSERT INTO Productos (Nombre, CategoriaID, Precio) VALUES
('Hamburguesa Deluxe', 1, 9.99), ('Cheeseburger', 1, 7.99), ('Pizza Margarita', 10, 11.99), ('Pizza Pepperoni', 10, 12.99), ('Helado de Chocolate', 7, 2.99),
('Helado de Vainilla', 7, 2.99), ('Ensalada César', 4, 5.99), ('Ensalada Griega', 4, 6.99), ('Pastel de Zanahoria', 2, 3.99), ('Brownie', 2, 2.99);

Select * from Productos

-- Insertar datos en Sucursales
INSERT INTO Sucursales (Nombre, Direccion) VALUES
('Sucursal Central', '1234 Main St'), ('Sucursal Norte', '5678 North St'), ('Sucursal Este', '9101 East St'), ('Sucursal Oeste', '1121 West St'), ('Sucursal Sur', '3141 South St'),
('Sucursal Playa', '1516 Beach St'), ('Sucursal Montaña', '1718 Mountain St'), ('Sucursal Valle', '1920 Valley St'), ('Sucursal Lago', '2122 Lake St'), ('Sucursal Bosque', '2324 Forest St');

Select * from Sucursales

-- Insertar datos en Empleados
INSERT INTO Empleados (Nombre, Posicion, Departamento, SucursalID, Rol) VALUES
('John Doe', 'Gerente', 'Administración', 1, 'Vendedor'), ('Jane Smith', 'Subgerente', 'Ventas', 1, 'Vendedor'), ('Bill Jones', 'Cajero', 'Ventas', 1, 'Vendedor'), ('Alice Johnson', 'Cocinero', 'Cocina', 1, 'Vendedor'), ('Tom Brown', 'Barista', 'Cafetería', 1, 'Vendedor'),
('Emma Davis', 'Repartidor', 'Logística', 1, 'Mensajero'), ('Lucas Miller', 'Atención al Cliente', 'Servicio', 1, 'Vendedor'), ('Olivia García', 'Encargado de Turno', 'Administración', 1, 'Vendedor'), ('Ethan Martinez', 'Mesero', 'Restaurante', 1, 'Vendedor'), ('Sophia Rodriguez', 'Auxiliar de Limpieza', 'Mantenimiento', 1, 'Vendedor');

Select * from Empleados

-- Insertar datos en Clientes
INSERT INTO Clientes (Nombre, Direccion) VALUES
('Cliente Uno', '1000 A Street'), ('Cliente Dos', '1001 B Street'), ('Cliente Tres', '1002 C Street'), ('Cliente Cuatro', '1003 D Street'), ('Cliente Cinco', '1004 E Street'),
('Cliente Seis', '1005 F Street'), ('Cliente Siete', '1006 G Street'), ('Cliente Ocho', '1007 H Street'), ('Cliente Nueve', '1008 I Street'), ('Cliente Diez', '1009 J Street');

Select * from Clientes

-- Insertar datos en OrigenesOrden
INSERT INTO OrigenesOrden (Descripcion) VALUES
('En línea'), ('Presencial'), ('Teléfono'), ('Drive Thru'), ('App Móvil'),
('Redes Sociales'), ('Correo Electrónico'), ('Publicidad'), ('Recomendación'), ('Evento');

Select * from OrigenesOrden

-- Insertar datos en TiposPago
INSERT INTO TiposPago (Descripcion) VALUES
('Efectivo'), ('Tarjeta de Crédito'), ('Tarjeta de Débito'), ('PayPal'), ('Transferencia Bancaria'),
('Criptomonedas'), ('Cheque'), ('Vale de Comida'), ('Cupón de Descuento'), ('Pago Móvil');

Select * from TiposPago

-- Insertar datos en Mensajeros:
INSERT INTO Mensajeros (Nombre, EsExterno) VALUES
('Mensajero Uno', 0), ('Mensajero Dos', 1), ('Mensajero Tres', 0), ('Mensajero Cuatro', 1), ('Mensajero Cinco', 0),
('Mensajero Seis', 1), ('Mensajero Siete', 0), ('Mensajero Ocho', 1), ('Mensajero Nueve', 0), ('Mensajero Diez', 1);

Select * from Mensajeros

-- Insertar datos en Ordenes
INSERT INTO Ordenes (ClienteID, EmpleadoID, SucursalID, MensajeroID, TipoPagoID, OrigenID, HorarioVenta, TotalCompra, KilometrosRecorrer, FechaDespacho, FechaEntrega, FechaOrdenTomada, FechaOrdenLista) VALUES
(1, 1, 1, 1, 1, 1, 'Mañana', 50.00, 5.5, '2023-01-10 08:30:00', '2023-01-10 09:00:00', '2023-01-10 08:00:00', '2023-01-10 08:15:00'),
(2, 2, 2, 2, 2, 2, 'Tarde', 75.00, 10.0, '2023-02-15 14:30:00', '2023-02-15 15:00:00', '2023-02-15 13:30:00', '2023-02-15 14:00:00'),
(3, 3, 3, 3, 3, 3, 'Noche', 20.00, 2.0, '2023-03-20 19:30:00', '2023-03-20 20:00:00', '2023-03-20 19:00:00', '2023-03-20 19:15:00'),
(4, 4, 4, 4, 4, 4, 'Mañana', 30.00, 0.5, '2023-04-25 09:30:00', '2023-04-25 10:00:00', '2023-04-25 09:00:00', '2023-04-25 09:15:00'),
(5, 5, 5, 5, 5, 5, 'Tarde', 55.00, 8.0, '2023-05-30 15:30:00', '2023-05-30 16:00:00', '2023-05-30 15:00:00', '2023-05-30 15:15:00'),
(6, 6, 6, 6, 6, 1, 'Noche', 45.00, 12.5, '2023-06-05 20:30:00', '2023-06-05 21:00:00', '2023-06-05 20:00:00', '2023-06-05 20:15:00'),
(7, 7, 7, 7, 7, 2, 'Mañana', 65.00, 7.5, '2023-07-10 08:30:00', '2023-07-10 09:00:00', '2023-07-10 08:00:00', '2023-07-10 08:15:00'),
(8, 8, 8, 8, 8, 3, 'Tarde', 85.00, 9.5, '2023-08-15 14:30:00', '2023-08-15 15:00:00', '2023-08-15 14:00:00', '2023-08-15 14:15:00'),
(9, 9, 9, 9, 9, 4, 'Noche', 95.00, 3.0, '2023-09-20 19:30:00', '2023-09-20 20:00:00', '2023-09-20 19:00:00', '2023-09-20 19:15:00'),
(10, 10, 10, 10, 10, 5, 'Mañana', 100.00, 15.0, '2023-10-25 09:30:00', '2023-10-25 10:00:00', '2023-10-25 09:00:00', '2023-10-25 09:15:00');

Select * from Ordenes

-- Insertar datos en DetalleOrdenes
INSERT INTO DetalleOrdenes (OrdenID, ProductoID, Cantidad, Precio) VALUES
(1, 1, 3, 23.44),
(1, 2, 5, 45.14),
(1, 3, 4, 46.37),
(1, 4, 4, 42.34),
(1, 5, 1, 18.25),
(1, 6, 4, 20.08),
(1, 7, 2, 13.31),
(1, 8, 2, 20.96),
(1, 9, 4, 30.13),
(1, 10, 3, 38.34);

Select * from DetalleOrdenes



--UPDATE Y DELETE

--ACTUALIZACIONES DE EJEMPLO (UPDATE)

-- Aumentar el precio de todos los productos en la categoría 1
UPDATE Productos SET Precio = Precio + 1 WHERE CategoriaID = 1;

-- Cambiar la posición de todos los empleados del departamento 'Cocina' a 'Chef'
UPDATE Empleados SET Posicion = 'Chef' WHERE Departamento = 'Cocina';

-- Actualizar la dirección de una sucursal específica
UPDATE Sucursales SET Direccion = '1234 New Address St' WHERE SucursalID = 1;

--ELIMINACIONES DE EJEMPLO (DELETE)

/*1. Eliminar una orden específica
Imaginemos que quieres eliminar una orden específica, 
por ejemplo, la orden con OrdenID = 10. 
Esta operación eliminaría la orden junto con sus detalles asociados 
(deberías asegurarte de eliminar o actualizar cualquier dato relacionado 
para mantener la integridad referencial).*/

DELETE FROM DetalleOrdenes WHERE OrdenID = 10;
DELETE FROM Ordenes WHERE OrdenID = 10;

/*2. Eliminar todos los productos de una categoría específica
Si decides dejar de ofrecer todos los "Postres" 
(supongamos que Categorias.CategoriaID = 2 para "Postres"), 
podrías querer eliminar todos los productos asociados a esa categoría.*/

DELETE FROM Productos WHERE CategoriaID = 2;
--Antes de ejecutar este comando, deberías considerar si hay órdenes que incluyen estos productos y decidir cómo manejar esas referencias.

/*3. Eliminar empleados de una sucursal que cerró
Si una sucursal cierra, por ejemplo, 
SucursalID = 10 (Sucursal Bosque), 
podrías necesitar eliminar a todos los empleados asociados con esa sucursal.*/

DELETE FROM Empleados WHERE SucursalID = 10;



--¿Cuál es la cantidad total de registros únicos en la tabla de órdenes?

SELECT COUNT(DISTINCT OrdenID) AS CantidadTotalRegistrosUnicos
FROM Ordenes;

--¿Cuántos empleados existen en cada departamento?

SELECT COUNT(DISTINCT EmpleadoID) AS NumeroEmpleados, Departamento
FROM Empleados
GROUP BY Departamento;

--¿Cuántos productos hay por código de categoría?

SELECT COUNT(DISTINCT ProductoID) AS CantidadProductos, CategoriaID
FROM Productos
GROUP BY CategoriaID
ORDER BY CantidadProductos ASC;

--¿Cuántos clientes se han importado a la tabla de clientes?

SELECT COUNT(DISTINCT ClienteID) AS CantidadClientes
FROM Clientes;

/*¿Cuáles son las sucursales con un promedio de ventas por orden superior a un valor específico, 
ordenadas por el promedio de kilómetros recorridos para las entregas de mayor a menor?*/

SELECT SucursalID,
       AVG(TotalCompra) AS PromedioTotalCompra,
       AVG(KilometrosRecorrer) AS PromedioKilometrosRecorrer
FROM Ordenes
GROUP BY SucursalID
ORDER BY PromedioKilometrosRecorrer DESC;


--Consultas 3er Avance

--1. ¿Cuál es el total de ventas (TotalCompra) a nivel global?
SELECT SUM(TotalCompra) AS TotalVentasGlobal
FROM Ordenes

--2. ¿Cuál es el precio promedio de los productos dentro de cada categoría?

SELECT CategoriaID, AVG(Precio) AS AvgPriceCategory
FROM Productos
GROUP BY CategoriaID;

--3. ¿Cuál es el valor de la orden mínima y máxima por cada sucursal?

SELECT SucursalID, MIN(TotalCompra) AS OrdenMinima, MAX(TotalCompra) AS OrdenMaxima
FROM Ordenes
GROUP BY  SucursalID;

--4. ¿Cuál es el mayor número de kilómetros recorridos para una entrega?

SELECT MAX(KilometrosRecorrer) AS EntregaMaxKilometros
FROM Ordenes

--5. ¿Cuál es la cantidad promedio de productos por orden?

SELECT AVG(Cantidad) AS AvgCantidadPorOrden
FROM DetalleOrdenes

--6. ¿Cuál es el total de ventas por cada tipo de pago?

SELECT SUM(TotalCompra) AS TotalVentaPorTipodePago
FROM Ordenes
GROUP BY TipoPagoID

--7. ¿Cuál sucursal tiene la venta promedio más alta?

SELECT TOP 1
	SucursalID, 
	AVG(TotalCompra) AS AvgTotalVentasSucursal
	FROM Ordenes
	GROUP BY SucursalID
	ORDER BY AvgTotalVentasSucursal DESC;

--8. ¿Cuáles son las sucursales que han generado ventas por orden por encima de $100, y cómo se comparan en términos del total de ventas?

SELECT SucursalID, TotalCompra
FROM Ordenes
WHERE TotalCompra > 100;

SELECT SUM(TotalCompra) AS TotalVentas
FROM Ordenes

--9. ¿Cómo se comparan las ventas promedio antes y después del 1 de julio de 2023?

SELECT 
	(SELECT AVG(TotalCompra) FROM Ordenes WHERE FechaOrdenTomada < '2023-07-01 00:00:01.000') AS AvgVentasAntes1Julio,
	(SELECT AVG(TotalCompra) FROM Ordenes WHERE FechaOrdenTomada >= '2023-07-01 00:00:01.000') AS AvgVentasDespués1Julio;


---10. ¿Durante qué horario del día (mañana, tarde, noche) se registra la mayor cantidad de ventas, 
--cuál es el valor promedio de estas ventas, y cuál ha sido la venta máxima alcanzada?

SELECT * FROM Ordenes

SELECT TOP 1
	HorarioVenta, 
	SUM(TotalCompra) AS TotalVentas,
	AVG(TotalCompra) AS AvgVentas,
	MAX(TotalCompra) AS MaxVenta
FROM Ordenes
GROUP BY HorarioVenta
ORDER BY TotalVentas DESC;

/*
--------------------
UNIÓN DE TABLAS  4 AVANCE
--------------------
*/

-- 1. ¿Cómo puedo obtener una lista de todos los productos junto con sus categorías?

SELECT p.ProductoID, p.Nombre AS NombreProducto, c.Nombre AS NombreCategoria
FROM Productos p
INNER JOIN Categorias c ON p.CategoriaID = c.CategoriaID;

-- 2. ¿Cómo puedo saber a qué sucursal está asignado cada empleado?

SELECT e.EmpleadoID, e.Nombre, e.SucursalID, s.Nombre
FROM Empleados e
INNER JOIN Sucursales s ON e.SucursalID = s.SucursalID


-- 3. ¿Existen productos que no tienen una categoría asignada?

SELECT * 
FROM Productos p
LEFT JOIN Categorias c ON p.CategoriaID=c.CategoriaID
WHERE p.CategoriaID is not null

-- 4. ¿Cómo puedo obtener un detalle completo de las órdenes, incluyendo cliente, empleado que tomó la orden, y el mensajero que la entregó?

SELECT 
	o.*,
	c.Nombre AS NombreCliente,
	e.Nombre AS NombreVendedor,
	m.Nombre AS NombreMensajero
from Ordenes o
INNER JOIN Clientes c ON c.ClienteID = o.ClienteID
INNER JOIN Empleados e ON e.EmpleadoID = o.EmpleadoID
INNER JOIN Mensajeros m ON m.MensajeroID = o.MensajeroID;

-- 5. ¿Cuántos productos --de cada tipo-- se han vendido en cada sucursal?

--En el code review se hizo mención de que se debía omitir la frase "de cada tipo" de la consulta.
--La siguiente consulta devuelve la cantidad de productos vendidos en cada sucursal según cada producto individual.

SELECT 
	p.Nombre AS Producto,
    s.Nombre AS Sucursal,
	SUM(d.Cantidad) AS Cantidad

FROM DetalleOrdenes d
INNER JOIN Ordenes o ON d.OrdenID = o.OrdenID
INNER JOIN Productos p ON d.ProductoID = p.ProductoID
INNER JOIN Sucursales s ON s.SucursalID = o.SucursalID
GROUP BY p.Nombre, s.Nombre

/* 6. ¿Qué porcentaje de clientes son recurrentes versus nuevos clientes cada mes? 
NOTA: La consulta se enfocaría en la frecuencia de órdenes por cliente para inferir la fidelidad.*/

SELECT T2.Nombre AS Cliente, COUNT(OrdenID) AS OrdenesRealizadas, MONTH(T1.FechaOrdenLista) AS Mes,
	CASE
	WHEN COUNT(OrdenID) = 1 THEN 'Nuevo'
	ELSE 'Recurrente'
	END AS FidelidadCliente
FROM Ordenes AS T1
INNER JOIN Clientes AS T2 ON T1.ClienteID=T2.ClienteID
GROUP BY T2.Nombre, MONTH(T1.FechaOrdenLista)

-------------------Expansión de datos--------------------

-- Insertar datos en Tabla Ordenes
INSERT INTO Ordenes (ClienteID, EmpleadoID, SucursalID, MensajeroID, TipoPagoID, OrigenID, HorarioVenta, TotalCompra, KilometrosRecorrer, FechaDespacho, FechaEntrega, FechaOrdenTomada, FechaOrdenLista) VALUES
(1,5,1,10,4,9,'Noche',86.73,18.69,'2023-12-17 20:45:27','2023-05-01 08:06:59','2023-11-09 15:08:22','2023-11-24 07:29:49'),
(4,5,3,4,4,5,'Mañana',101.04,16.59,'2023-02-24 07:54:21','2023-09-26 02:54:08','2023-10-03 13:38:59','2023-04-26 15:56:43'),
(7,10,2,5,8,7,'Mañana',113.53,18.85,'2023-09-14 01:13:02','2023-07-29 02:40:01','2023-01-30 19:20:32','2023-09-07 02:51:45'),
(9,5,8,5,7,9,'Tarde',37.63,6.64,'2023-07-10 20:49:50','2023-11-29 16:35:55','2023-06-05 09:33:34','2023-07-22 04:33:41'),
(7,7,8,10,1,6,'Noche',70.67,7.53,'2023-10-20 20:39:32','2023-11-18 18:47:43','2023-12-09 11:53:48','2023-10-01 11:38:12'),
(6,10,9,1,1,5,'Noche',106.64,19.33,'2023-02-21 20:48:13','2023-12-14 16:17:25','2023-07-20 02:25:10','2023-05-25 13:43:50'),
(4,6,10,5,8,7,'Noche',62.13,14.01,'2023-09-21 09:18:53','2023-08-06 03:37:27','2023-01-10 04:56:32','2023-05-10 21:47:29'),
(8,8,2,4,7,3,'Noche',28.66,17.82,'2023-08-16 20:41:06','2023-11-16 15:59:29','2023-09-03 22:01:06','2023-11-24 03:28:33'),
(8,4,6,3,3,1,'Tarde',79.2,5.08,'2023-12-11 12:06:10','2023-11-28 22:15:37','2023-08-26 07:23:17','2023-06-27 08:20:43'),
(3,8,6,3,2,1,'Mañana',50.03,15.9,'2023-08-29 18:25:35','2023-06-21 11:55:41','2023-10-11 02:13:56','2023-11-23 22:55:43'),
(10,4,8,3,4,6,'Noche',102.72,9.64,'2023-02-04 05:13:54','2023-08-25 20:53:31','2023-01-13 11:33:17','2023-08-01 20:15:28'),
(4,2,3,7,8,5,'Noche',112.44,10.05,'2023-07-01 04:55:37','2023-05-11 19:34:03','2023-07-24 18:09:06','2023-05-28 14:03:13'),
(4,1,6,1,6,2,'Tarde',74.05,13.15,'2023-05-30 05:59:59','2023-02-06 11:23:49','2023-01-03 18:29:29','2023-09-17 12:27:58'),
(5,6,2,10,8,9,'Mañana',109.75,1.94,'2023-07-27 20:06:48','2023-09-28 02:09:41','2023-03-08 13:05:25','2023-04-27 04:20:15'),
(7,4,4,6,7,10,'Noche',90.43,15.62,'2023-08-25 12:39:06','2023-07-29 23:33:24','2023-11-20 18:40:05','2023-11-27 21:36:48'),
(10,1,7,5,5,9,'Noche',90.89,6.8,'2023-11-17 07:15:14','2023-06-18 11:41:29','2023-03-21 00:53:18','2023-03-23 00:23:36'),
(6,8,10,7,3,10,'Noche',58.42,6.26,'2023-03-20 22:17:50','2023-05-12 00:36:37','2023-10-06 14:59:55','2023-11-11 12:51:37'),
(9,6,9,10,3,8,'Noche',69.12,12.94,'2023-10-30 02:00:00','2023-03-31 14:30:00','2023-10-21 05:30:00','2023-01-12 14:00:00'),
(8,10,5,5,8,6,'Noche',115.39,2.08,'2023-07-02 09:30:00','2023-11-23 23:30:00','2023-02-03 21:30:00','2023-04-23 21:30:00'),
(10,3,7,2,9,2,'Noche',43.88,13.31,'2023-09-13 07:30:00','2023-11-24 07:30:00','2023-02-23 15:30:00','2023-05-24 09:30:00'),
(2,9,4,9,1,4,'Noche',36.54,19.15,'2023-06-06 11:00:00','2023-09-28 13:30:00','2023-05-06 23:30:00','2023-09-29 13:30:00'),
(8,4,3,3,6,6,'Mañana',107.54,4.26,'2023-09-17 06:30:00','2023-08-09 21:00:00','2023-01-29 06:30:00','2023-05-28 21:00:00'),
(7,1,10,9,4,4,'Tarde',100.46,1.65,'2023-06-26 12:00:00','2023-07-30 00:00:00','2023-07-31 18:00:00','2023-01-29 18:00:00'),
(10,8,1,4,1,5,'Tarde',48.2,7.02,'2023-09-14 09:00:00','2023-07-19 15:00:00','2023-09-21 03:00:00','2023-09-25 15:00:00'),
(5,2,5,7,10,6,'Noche',93.65,5.16,'2023-10-20 16:30:00','2023-02-19 10:00:00','2023-06-21 06:00:00','2023-03-09 00:00:00'),
(6,3,3,8,2,1,'Tarde',102.23,18.19,'2023-05-03 16:30:00','2023-10-09 18:00:00','2023-01-30 22:00:00','2023-08-26 00:30:00'),
(6,5,4,6,10,7,'Tarde',85.89,2.8,'2023-11-14 06:30:00','2023-11-09 00:00:00','2023-10-29 06:30:00','2023-10-16 06:30:00'),
(3,9,5,2,6,4,'Noche',109.07,5.89,'2023-02-01 09:00:00','2023-05-10 12:30:00','2023-06-24 15:00:00','2023-04-15 12:30:00'),
(7,3,2,8,5,3,'Tarde',33.74,10.24,'2023-07-20 03:00:00','2023-06-19 18:00:00','2023-08-14 18:00:00','2023-05-30 06:00:00'),
(6,4,5,1,7,8,'Mañana',108.29,1.57,'2023-06-29 06:00:00','2023-01-12 12:00:00','2023-04-14 15:00:00','2023-08-18 18:00:00'),
(8,9,9,6,9,10,'Noche',76.47,2.5,'2023-07-07 12:30:00','2023-06-21 12:30:00','2023-07-19 00:00:00','2023-11-10 00:00:00'),
(8,3,4,7,3,2,'Mañana',108.29,8.38,'2023-07-27 00:00:00','2023-03-23 03:00:00','2023-06-30 03:00:00','2023-06-29 00:00:00'),
(6,7,7,3,5,3,'Tarde',91.67,12.15,'2023-09-01 00:00:00','2023-11-04 03:00:00','2023-09-10 12:00:00','2023-08-11 03:00:00'),
(10,9,3,8,6,9,'Tarde',54.02,15.25,'2023-01-21 18:00:00','2023-10-07 06:00:00','2023-05-13 03:00:00','2023-10-18 12:00:00'),
(5,10,9,4,2,10,'Tarde',114.56,17.45,'2023-09-12 06:00:00','2023-07-30 06:00:00','2023-07-15 03:00:00','2023-01-26 00:00:00'),
(2,3,7,4,4,8,'Tarde',63.77,19.15,'2023-02-15 12:00:00','2023-09-06 03:00:00','2023-03-15 06:00:00','2023-10-03 06:00:00'),
(4,9,1,9,3,4,'Tarde',35.3,7.13,'2023-06-29 18:00:00','2023-09-09 06:00:00','2023-09-05 00:00:00','2023-06-07 12:00:00'),
(6,6,8,2,9,1,'Mañana',56.88,14.85,'2023-03-24 12:00:00','2023-09-16 06:00:00','2023-11-06 06:00:00','2023-11-22 12:00:00'),
(1,2,2,6,5,6,'Noche',59.89,7.62,'2023-11-30 06:00:00','2023-02-08 18:00:00','2023-03-31 12:00:00','2023-01-17 18:00:00'),
(5,3,1,3,10,5,'Noche',70.48,18.02,'2023-03-18 00:00:00','2023-02-28 00:00:00','2023-10-01 06:00:00','2023-06-15 18:00:00'),
(7,5,5,5,6,8,'Tarde',90.82,5.71,'2023-03-13 18:00:00','2023-05-06 12:00:00','2023-08-05 06:00:00','2023-07-27 18:00:00'),
(3,4,10,8,8,2,'Tarde',53.3,4.89,'2023-06-29 00:00:00','2023-03-13 06:00:00','2023-02-20 18:00:00','2023-04-24 06:00:00'),
(2,5,4,2,7,10,'Mañana',38.52,19.08,'2023-06-09 18:00:00','2023-01-16 06:00:00','2023-05-03 12:00:00','2023-10-11 18:00:00'),
(5,8,8,3,6,7,'Mañana',66.7,12.1,'2023-09-18 00:00:00','2023-02-27 06:00:00','2023-07-04 06:00:00','2023-07-11 00:00:00'),
(9,2,7,6,5,3,'Tarde',50.65,14.61,'2023-09-11 12:00:00','2023-08-11 00:00:00','2023-07-27 00:00:00','2023-01-21 12:00:00'),
(1,7,9,5,3,5,'Noche',79.26,12.29,'2023-04-26 06:00:00','2023-11-17 06:00:00','2023-01-07 00:00:00','2023-01-11 12:00:00'),
(5,4,6,6,2,6,'Mañana',52.99,3.61,'2023-02-17 12:00:00','2023-08-01 06:00:00','2023-11-03 00:00:00','2023-03-02 00:00:00'),
(3,7,3,10,7,1,'Tarde',111.89,16.08,'2023-02-02 00:00:00','2023-01-18 06:00:00','2023-09-10 00:00:00','2023-08-07 00:00:00'),
(9,3,5,7,4,6,'Noche',41.3,19.06,'2023-05-07 06:00:00','2023-09-29 06:00:00','2023-02-05 00:00:00','2023-01-04 06:00:00'),
(10,6,4,8,10,7,'Mañana',89.22,7.35,'2023-03-01 00:00:00','2023-11-05 06:00:00','2023-11-01 12:00:00','2023-06-07 12:00:00'),
(4,8,9,3,9,4,'Tarde',58.74,1.49,'2023-10-31 06:00:00','2023-09-12 00:00:00','2023-10-02 00:00:00','2023-03-31 12:00:00'),
(8,1,2,1,2,3,'Mañana',99.54,4.12,'2023-02-27 06:00:00','2023-06-05 00:00:00','2023-09-18 00:00:00','2023-01-05 12:00:00'),
(1,3,5,10,4,2,'Noche',86.7,9.92,'2023-10-23 00:00:00','2023-02-01 00:00:00','2023-10-26 00:00:00','2023-08-08 00:00:00'),
(7,2,6,2,10,9,'Mañana',67.04,6.68,'2023-02-22 00:00:00','2023-11-03 00:00:00','2023-08-17 06:00:00','2023-09-12 12:00:00'),
(2,6,3,6,1,7,'Mañana',53.15,1.57,'2023-07-24 12:00:00','2023-09-25 06:00:00','2023-10-27 12:00:00','2023-03-17 00:00:00'),
(3,1,9,1,8,5,'Tarde',36.62,17.45,'2023-07-20 00:00:00','2023-02-14 12:00:00','2023-03-23 12:00:00','2023-08-24 12:00:00'),
(9,1,10,5,4,10,'Mañana',69.43,8.64,'2023-11-06 00:00:00','2023-01-17 00:00:00','2023-05-16 06:00:00','2023-08-08 00:00:00'),
(9,8,4,9,3,2,'Mañana',92.42,17.74,'2023-05-08 00:00:00','2023-06-22 00:00:00','2023-09-21 12:00:00','2023-05-06 12:00:00'),
(6,2,1,4,7,8,'Noche',47.79,18.71,'2023-01-10 00:00:00','2023-08-29 12:00:00','2023-04-30 00:00:00','2023-01-23 12:00:00'),
(1,9,7,7,5,9,'Noche',102.95,11.18,'2023-07-03 06:00:00','2023-02-14 00:00:00','2023-10-16 12:00:00','2023-08-26 06:00:00'),
(5,1,8,2,3,4,'Noche',71.96,13.52,'2023-11-11 12:00:00','2023-02-02 06:00:00','2023-03-12 12:00:00','2023-09-03 00:00:00'),
(10,2,6,10,8,3,'Noche',70.0,4.6,'2023-07-25 00:00:00','2023-07-30 00:00:00','2023-11-13 00:00:00','2023-05-17 00:00:00'),
(2,4,8,5,5,5,'Tarde',114.68,5.98,'2023-04-07 12:00:00','2023-08-11 00:00:00','2023-01-23 12:00:00','2023-08-24 06:00:00'),
(4,3,5,4,6,6,'Noche',95.74,19.86,'2023-06-13 12:00:00','2023-08-09 00:00:00','2023-03-20 00:00:00','2023-10-14 06:00:00'),
(7,6,10,9,7,1,'Mañana',84.49,17.9,'2023-01-09 12:00:00','2023-10-24 06:00:00','2023-04-27 00:00:00','2023-10-09 12:00:00'),
(3,5,4,1,9,3,'Mañana',95.23,5.22,'2023-10-30 00:00:00','2023-05-29 06:00:00','2023-09-18 00:00:00','2023-09-17 06:00:00'),
(1,10,3,3,2,4,'Mañana',69.17,9.94,'2023-09-14 00:00:00','2023-01-31 06:00:00','2023-08-17 00:00:00','2023-08-15 06:00:00'),
(5,5,2,7,1,2,'Mañana',35.49,10.5,'2023-05-10 12:00:00','2023-10-06 00:00:00','2023-05-03 00:00:00','2023-10-02 12:00:00'),
(2,7,1,8,6,9,'Tarde',106.54,16.95,'2023-11-03 06:00:00','2023-08-18 00:00:00','2023-09-20 00:00:00','2023-09-22 06:00:00'),
(4,10,7,10,5,2,'Noche',46.14,11.55,'2023-06-25 00:00:00','2023-09-05 00:00:00','2023-08-09 06:00:00','2023-02-21 00:00:00'),
(6,9,2,2,4,10,'Mañana',35.65,1.19,'2023-02-10 00:00:00','2023-06-23 06:00:00','2023-07-25 12:00:00','2023-10-03 00:00:00'),
(8,2,5,6,10,1,'Tarde',77.23,3.53,'2023-05-25 00:00:00','2023-10-20 00:00:00','2023-01-29 00:00:00','2023-06-25 00:00:00'),
(8,6,1,10,9,8,'Tarde',94.72,13.25,'2023-06-06 06:00:00','2023-11-24 06:00:00','2023-04-02 00:00:00','2023-07-20 00:00:00'),
(10,7,8,4,3,2,'Tarde',32.02,7.03,'2023-10-30 00:00:00','2023-07-17 00:00:00','2023-08-05 00:00:00','2023-11-24 00:00:00'),
(2,1,3,5,8,6,'Noche',81.86,18.17,'2023-11-10 06:00:00','2023-07-02 00:00:00','2023-10-25 00:00:00','2023-08-02 06:00:00'),
(3,6,6,9,4,7,'Noche',114.51,7.14,'2023-03-05 06:00:00','2023-09-27 06:00:00','2023-04-04 00:00:00','2023-05-07 00:00:00'),
(7,8,4,2,2,4,'Noche',40.5,10.33,'2023-09-19 00:00:00','2023-01-19 06:00:00','2023-06-06 06:00:00','2023-06-07 00:00:00'),
(2,10,10,3,1,3,'Mañana',44.8,16.14,'2023-06-18 00:00:00','2023-09-27 00:00:00','2023-08-30 12:00:00','2023-06-13 00:00:00'),
(1,4,4,9,3,10,'Noche',98.31,3.1,'2023-03-28 06:00:00','2023-06-10 00:00:00','2023-11-12 00:00:00','2023-08-03 00:00:00'),
(5,9,5,1,7,1,'Tarde',32.82,17.77,'2023-05-09 00:00:00','2023-08-22 06:00:00','2023-11-14 12:00:00','2023-03-13 12:00:00'),
(9,4,2,4,8,2,'Tarde',50.89,9.86,'2023-08-24 00:00:00','2023-03-26 00:00:00','2023-07-25 00:00:00','2023-01-07 00:00:00'),
(9,10,1,6,6,8,'Mañana',57.51,10.53,'2023-11-21 06:00:00','2023-01-12 00:00:00','2023-05-31 06:00:00','2023-07-05 06:00:00'),
(8,7,7,7,4,6,'Tarde',73.47,15.95,'2023-05-30 06:00:00','2023-09-22 00:00:00','2023-10-09 00:00:00','2023-09-20 06:00:00'),
(4,7,3,10,7,3,'Mañana',91.19,18.67,'2023-10-20 06:00:00','2023-06-01 00:00:00','2023-06-18 12:00:00','2023-07-16 06:00:00'),
(6,1,2,7,3,9,'Mañana',88.99,2.68,'2023-06-30 00:00:00','2023-07-20 00:00:00','2023-06-28 00:00:00','2023-07-12 00:00:00'),
(1,6,5,8,9,8,'Mañana',68.19,18.33,'2023-03-14 06:00:00','2023-08-25 00:00:00','2023-09-06 00:00:00','2023-07-14 06:00:00'),
(3,2,8,5,2,5,'Tarde',111.42,4.52,'2023-07-11 00:00:00','2023-10-01 00:00:00','2023-06-11 06:00:00','2023-06-26 12:00:00'),
(7,9,9,3,8,7,'Tarde',95.92,4.71,'2023-11-15 06:00:00','2023-05-30 00:00:00','2023-10-17 06:00:00','2023-09-07 00:00:00'),
(10,5,3,2,6,10,'Mañana',69.35,10.99,'2023-09-19 00:00:00','2023-05-18 06:00:00','2023-07-26 00:00:00','2023-09-12 00:00:00'),
(2,2,4,4,4,1,'Noche',48.53,2.59,'2023-02-09 00:00:00','2023-07-31 06:00:00','2023-03-15 12:00:00','2023-02-06 00:00:00'),
(5,7,10,6,1,2,'Noche',54.59,6.76,'2023-08-22 06:00:00','2023-06-19 00:00:00','2023-10-10 00:00:00','2023-01-22 00:00:00'),
(7,10,6,1,5,5,'Tarde',80.14,19.26,'2023-06-20 00:00:00','2023-08-23 06:00:00','2023-11-30 00:00:00','2023-02-20 00:00:00'),
(6,10,7,8,2,9,'Mañana',61.82,10.79,'2023-07-13 06:00:00','2023-01-06 00:00:00','2023-05-01 06:00:00','2023-08-03 00:00:00'),
(4,6,2,5,5,6,'Noche',112.35,7.33,'2023-01-10 12:00:00','2023-11-22 00:00:00','2023-08-15 06:00:00','2023-08-26 12:00:00'),
(8,8,5,9,10,7,'Tarde',56.3,17.89,'2023-07-01 06:00:00','2023-02-16 00:00:00','2023-09-23 06:00:00','2023-09-11 00:00:00'),
(4,5,3,3,8,10,'Mañana',77.58,16.45,'2023-09-29 06:00:00','2023-04-03 00:00:00','2023-08-14 06:00:00','2023-05-21 00:00:00'),
(3,8,6,7,1,1,'Mañana',74.02,12.64,'2023-06-05 06:00:00','2023-01-18 00:00:00','2023-06-25 00:00:00','2023-08-07 06:00:00'),
(9,7,1,10,7,6,'Noche',92.71,5.52,'2023-10-17 00:00:00','2023-11-02 06:00:00','2023-08-03 00:00:00','2023-07-01 12:00:00'),
(1,5,2,2,6,3,'Tarde',60.49,2.09,'2023-02-01 06:00:00','2023-04-10 00:00:00','2023-06-01 06:00:00','2023-03-30 12:00:00'),
(5,6,9,5,4,7,'Tarde',80.77,11.27,'2023-10-17 06:00:00','2023-08-14 00:00:00','2023-03-24 00:00:00','2023-01-07 06:00:00'),
(7,7,8,8,9,8,'Noche',72.11,4.39,'2023-06-28 00:00:00','2023-01-26 00:00:00','2023-04-20 12:00:00','2023-03-18 06:00:00'),
(3,10,4,10,3,5,'Noche',45.69,4.85,'2023-02-20 06:00:00','2023-06-05 12:00:00','2023-01-16 06:00:00','2023-05-01 12:00:00'),
(9,5,10,5,2,8,'Noche',40.79,16.97,'2023-03-08 00:00:00','2023-04-19 00:00:00','2023-02-14 06:00:00','2023-08-31 00:00:00'),
(10,4,3,3,4,6,'Mañana',61.67,6.24,'2023-03-02 06:00:00','2023-10-09 00:00:00','2023-01-15 12:00:00','2023-08-22 00:00:00'),
(4,4,9,4,9,5,'Tarde',95.14,19.14,'2023-06-28 06:00:00','2023-07-19 06:00:00','2023-08-08 06:00:00','2023-07-12 12:00:00'),
(6,8,2,1,8,9,'Tarde',53.32,14.27,'2023-05-12 06:00:00','2023-08-29 00:00:00','2023-03-31 00:00:00','2023-06-07 06:00:00'),
(2,9,1,6,5,1,'Tarde',91.12,4.44,'2023-08-23 06:00:00','2023-05-26 00:00:00','2023-11-27 00:00:00','2023-03-06 00:00:00'),
(8,4,6,8,7,8,'Mañana',80.29,11.74,'2023-03-15 00:00:00','2023-10-09 06:00:00','2023-03-07 12:00:00','2023-07-06 06:00:00'),
(7,1,5,2,3,2,'Noche',70.11,5.62,'2023-02-26 00:00:00','2023-09-11 00:00:00','2023-06-28 00:00:00','2023-06-23 06:00:00'),
(10,8,7,9,4,10,'Noche',62.07,7.74,'2023-01-02 06:00:00','2023-09-19 06:00:00','2023-01-22 12:00:00','2023-07-17 00:00:00'),
(5,2,9,3,9,6,'Mañana',34.77,7.45,'2023-08-28 06:00:00','2023-06-15 06:00:00','2023-10-18 06:00:00','2023-02-27 12:00:00'),
(6,3,6,7,7,5,'Tarde',111.71,10.18,'2023-11-13 06:00:00','2023-04-01 00:00:00','2023-05-03 00:00:00','2023-01-05 06:00:00'),
(6,5,5,10,8,3,'Tarde',79.1,17.71,'2023-11-23 12:00:00','2023-07-20 00:00:00','2023-03-12 00:00:00','2023-10-23 06:00:00'),
(3,9,7,8,4,7,'Tarde',69.05,8.1,'2023-02-14 00:00:00','2023-10-06 00:00:00','2023-09-06 12:00:00','2023-03-22 12:00:00'),
(7,3,1,4,6,4,'Tarde',59.51,13.6,'2023-06-28 00:00:00','2023-10-31 06:00:00','2023-05-06 00:00:00','2023-10-25 00:00:00'),
(6,4,3,9,3,2,'Mañana',107.36,7.15,'2023-02-23 00:00:00','2023-06-16 06:00:00','2023-09-19 12:00:00','2023-08-31 06:00:00'),
(10,3,10,1,2,9,'Mañana',65.18,13.79,'2023-06-10 12:00:00','2023-10-15 06:00:00','2023-05-05 00:00:00','2023-11-09 00:00:00'),
(4,2,7,5,10,1,'Noche',77.74,6.47,'2023-02-09 06:00:00','2023-10-13 00:00:00','2023-08-14 00:00:00','2023-09-26 00:00:00'),
(8,3,4,7,1,9,'Noche',109.9,7.3,'2023-06-06 00:00:00','2023-09-08 00:00:00','2023-08-24 00:00:00','2023-09-26 00:00:00'),
(10,9,8,2,5,5,'Tarde',76.14,6.9,'2023-09-19 00:00:00','2023-08-01 00:00:00','2023-01-21 06:00:00','2023-11-07 06:00:00'),
(8,5,2,3,6,4,'Tarde',63.08,12.74,'2023-10-17 06:00:00','2023-06-26 00:00:00','2023-11-16 06:00:00','2023-05-22 00:00:00'),
(4,1,10,1,1,3,'Mañana',69.72,11.05,'2023-05-18 00:00:00','2023-09-08 06:00:00','2023-03-13 00:00:00','2023-10-25 06:00:00'),
(10,10,6,4,9,2,'Mañana',54.04,15.24,'2023-09-29 00:00:00','2023-09-14 06:00:00','2023-08-10 06:00:00','2023-02-16 00:00:00'),
(8,9,9,10,3,10,'Noche',78.17,4.21,'2023-06-01 00:00:00','2023-06-23 00:00:00','2023-07-12 12:00:00','2023-10-17 12:00:00'),
(10,1,5,7,7,5,'Noche',54.56,11.71,'2023-06-06 00:00:00','2023-09-11 12:00:00','2023-05-03 06:00:00','2023-06-05 06:00:00'),
(3,3,1,6,10,8,'Mañana',73.32,17.89,'2023-07-19 06:00:00','2023-07-18 00:00:00','2023-06-20 00:00:00','2023-10-19 12:00:00'),
(7,4,8,1,3,3,'Mañana',51.22,12.36,'2023-01-10 06:00:00','2023-07-20 06:00:00','2023-02-16 06:00:00','2023-08-04 00:00:00'),
(6,7,4,9,2,10,'Noche',66.24,17.58,'2023-05-31 06:00:00','2023-07-07 06:00:00','2023-08-01 06:00:00','2023-05-29 00:00:00'),
(1,8,10,4,8,5,'Noche',99.51,10.12,'2023-05-09 06:00:00','2023-06-09 00:00:00','2023-01-02 06:00:00','2023-09-26 12:00:00'),
(5,10,2,8,10,9,'Mañana',71.44,3.36,'2023-06-20 00:00:00','2023-11-03 12:00:00','2023-06-01 06:00:00','2023-09-14 12:00:00'),
(3,4,7,2,3,6,'Tarde',32.54,6.51,'2023-07-04 06:00:00','2023-03-10 00:00:00','2023-11-21 00:00:00','2023-10-09 00:00:00'),
(7,5,3,5,4,7,'Tarde',36.23,10.24,'2023-09-18 00:00:00','2023-05-08 06:00:00','2023-09-28 00:00:00','2023-05-25 00:00:00'),
(6,6,6,6,1,5,'Noche',80.76,10.98,'2023-11-24 00:00:00','2023-04-21 06:00:00','2023-07-14 12:00:00','2023-10-05 06:00:00'),
(1,2,9,4,9,10,'Mañana',71.53,17.91,'2023-01-03 00:00:00','2023-07-26 06:00:00','2023-02-01 06:00:00','2023-01-25 00:00:00'),
(5,3,1,2,3,6,'Tarde',49.35,5.06,'2023-10-25 06:00:00','2023-02-15 06:00:00','2023-05-31 06:00:00','2023-03-15 06:00:00');


-- Insertar datos en Tabla DetalleOrdenes
INSERT INTO DetalleOrdenes (OrdenID, ProductoID, Cantidad, Precio) VALUES
(106,3,5,7.38),
(30,9,3,13.9),
(84,2,3,3.04),
(127,4,5,3.18),
(95,9,4,13.26),
(104,10,3,12.81),
(65,6,5,16.24),
(48,9,5,14.93),
(43,8,5,11.54),
(111,6,5,8.09),
(127,1,2,7.98),
(133,9,1,17.07),
(107,10,3,3.13),
(44,9,5,16.07),
(133,7,2,2.48),
(130,9,4,3.2),
(13,1,1,10.73),
(92,2,4,16.4),
(4,3,2,5.23),
(19,3,2,15.84),
(68,2,5,5.55),
(71,2,5,2.14),
(83,8,2,11.99),
(74,9,1,12.16),
(69,1,4,17.96),
(127,9,5,12.29),
(11,5,5,9.77),
(84,4,5,13.57),
(18,4,4,3.71),
(88,7,2,15.5),
(15,8,1,10.97),
(31,10,3,13.11),
(12,8,3,12.27),
(145,6,5,7.59),
(73,10,3,7.67),
(9,2,3,4.89),
(80,6,1,15.22),
(124,9,5,8.89),
(12,7,5,7.37),
(52,10,2,14.49),
(45,1,4,5.48),
(20,8,5,15.86),
(41,6,1,12.99),
(134,9,5,14.83),
(80,7,1,16.36),
(58,3,5,4.88),
(53,9,4,12.03),
(89,9,3,13.48),
(111,2,5,2.28),
(101,7,2,7.11),
(37,1,3,11.47),
(19,1,5,5.71),
(101,2,4,8.1),
(106,7,3,13.82),
(115,7,3,14.87),
(32,3,4,2.18),
(124,8,4,16.14),
(85,8,2,17.41),
(84,6,4,6.99),
(144,9,5,3.14),
(12,1,1,5.19),
(126,6,3,11.14),
(11,2,2,14.07),
(113,1,5,6.4),
(77,10,2,10.35),
(35,4,1,17.98),
(76,2,4,13.06),
(30,1,5,2.77),
(79,2,5,17.53),
(25,9,5,8.76),
(25,5,3,11.07),
(27,10,5,13.1),
(138,4,4,12.48),
(6,1,5,9.08),
(68,6,5,17.23),
(18,2,3,14.04),
(29,4,3,3.08),
(31,8,3,14.77),
(122,8,5,2.99),
(16,7,3,17.52),
(65,9,1,17.28),
(106,5,1,8.97),
(82,3,2,9.42),
(28,3,2,13.19),
(5,3,5,10.37),
(55,2,3,17.32),
(78,5,4,11.89),
(128,9,4,5.66),
(114,5,4,14.26),
(88,4,1,17.92),
(8,2,3,10.33),
(78,6,5,3.75),
(80,2,1,10.62),
(76,3,4,7.59);

SELECT * FROM DetalleOrdenes
Select * from Ordenes

--Nuevas consultas estratégicas

--Cantidad total de ventas
SELECT SUM(TotalCompra) AS TotalVentas FROM Ordenes 


--Vendedor con más ventas 
SELECT TOP 1 e.Nombre, SUM(o.TotalCompra) AS TotalVentas
FROM ORDENES o
INNER JOIN Empleados e ON o.EmpleadoID = e.EmpleadoID
GROUP BY e.EmpleadoID, e.Nombre;

--Origen de compra con más ventas
SELECT TOP 1 oo.Descripcion, SUM(o.TotalCompra) AS TotalVentas
FROM ORDENES o
INNER JOIN OrigenesOrden oo ON o.OrigenID = oo.OrigenID
GROUP BY oo.Descripcion;

--Horario con mayores ventas
SELECT TOP 1 
HorarioVenta, SUM(TotalCompra) AS TotalVentas
FROM Ordenes
GROUP BY HorarioVenta
ORDER BY HorarioVenta DESC;

--Sucursal con mayores ventas
SELECT TOP 1 
    S.Nombre, 
    SUM(o.TotalCompra) AS TotalVentas
FROM Ordenes o
INNER JOIN Sucursales S ON o.SucursalID = S.SucursalID
GROUP BY S.SucursalID, S.Nombre
ORDER BY TotalVentas DESC;

--Sucursal con menores ventas
SELECT TOP 3
    S.Nombre, 
    SUM(o.TotalCompra) AS TotalVentas
FROM Ordenes o
INNER JOIN Sucursales S ON o.SucursalID = S.SucursalID
GROUP BY S.SucursalID, S.Nombre
ORDER BY TotalVentas ASC;

--Productos con mayores ventas
SELECT TOP 3
    p.Nombre, 
    SUM(o.TotalCompra) AS TotalVentas
FROM Ordenes o
INNER JOIN DetalleOrdenes d ON d.OrdenID = o.OrdenID
INNER JOIN Productos p ON d.ProductoiD=p.ProductoID
GROUP BY p.Nombre
ORDER BY TotalVentas ASC;



--Creación de Indices 
--Se crean indices en algunas de las columnas que se usan en consultas frecuentes que no son primary key, ya que las primary key ya tienen asignado un indice por defecto.
CREATE INDEX idx_HorarioVenta ON Ordenes(HorarioVenta)
CREATE INDEX idx_Precio ON DetalleOrdenes(Precio)
CREATE INDEX idx_Producto ON Productos(Nombre)
CREATE INDEX idx_Cliente ON Clientes(Nombre)
CREATE INDEX idx_Sucursal ON Sucursales(Nombre)
CREATE INDEX idx_Empleado ON Empleados(Nombre)
CREATE INDEX idx_TipoPago ON TiposPago(Descripcion)
