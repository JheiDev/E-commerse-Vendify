USE PROYECTO_EFSRT
GO

-- Insercion de Datos USUARIO
INSERT INTO USUARIO(Nombres,Apellidos,Correo,Clave) VALUES
		('Cristhian','Vasquez','cristhian@gmail.com','12345'),
		('David','Fernandez','david@gmail.com','12345'),
		('Jheicer','Rodriguez','jheicer@gmail.com','12345')
GO

SELECT * FROM USUARIO
GO

-- Insercion de Datos CATEGORIA
INSERT INTO CATEGORIA (Descripcion) VALUES ('Smartphones'),
		('Tablets'),
		('Laptops'),
		('Desktops'),
		('Accesorios para Computadoras'),
		('Redes y Conectividad'),
		('Componentes de PC'),
		('Software'),
		('Gadgets'),
		('Impresoras y Escáneres'),
		('Almacenamiento'),
		('Periféricos'),
		('Cámaras y Fotografía'),
		('Monitores'),
		('Electrónica de Audio y Video'),
		('Drones'),
		('Robótica'),
		('Realidad Virtual'),
		('Wearables'),
		('Domótica')
GO

SELECT * FROM CATEGORIA
GO

--Insercion de Datos MARCA
INSERT INTO MARCA (Descripcion) VALUES ('Apple'),
		('Samsung'),
		('Microsoft'),
		('Dell'),
		('HP'),
		('Lenovo'),
		('Asus'),
		('Acer'),
		('Sony'),
		('LG'),
		('Huawei'),
		('Xiaomi'),
		('Google'),
		('Intel'),
		('AMD'),
		('Nvidia'),
		('Cisco'),
		('TP-Link'),
		('Netgear'),
		('Brother'),
		('Canon'),
		('Epson'),
		('Razer'),
		('Logitech'),
		('Corsair'),
		('Kingston'),
		('Western Digital'),
		('Seagate'),
		('Anker')
GO

SELECT * FROM MARCA
GO

--Insercion de Datos PRODUCTO
--Insercion de Datos PRODUCTO
INSERT INTO PRODUCTO (Nombre, Descripcion, IdMarca, IdCategoria, Precio, Stock, RutaImagen, NombreImagen) 
VALUES 
		('iPhone 13', 'Smartphone de última generación de Apple', 1, 1, 999.99, 50, 'D:\FOTOS_PRODUCTOS', '1.jpg'),
		('Samsung Galaxy S21', 'Smartphone de alta gama de Samsung', 2, 1, 799.99, 75, 'D:\FOTOS_PRODUCTOS', '2.jpg'),
		('Microsoft Surface Pro 7', 'Tablet y laptop de Microsoft con pantalla táctil', 3, 2, 899.99, 30, 'D:\FOTOS_PRODUCTOS', '3.jpg'),
		('Dell XPS 13', 'Laptop ultrafina y ligera de Dell', 4, 3, 1199.99, 20, 'D:\FOTOS_PRODUCTOS', '4.jpg'),
		('HP Spectre x360', 'Laptop convertible de HP con pantalla táctil', 5, 3, 1299.99, 25, 'D:\FOTOS_PRODUCTOS', '5.jpg'),
		('Lenovo ThinkPad X1 Carbon', 'Laptop empresarial de alta gama de Lenovo', 6, 3, 1399.99, 15, 'D:\FOTOS_PRODUCTOS', '6.jpg'),
		('Asus ROG Strix', 'Laptop gaming de Asus con alto rendimiento', 7, 3, 1499.99, 10, 'D:\FOTOS_PRODUCTOS', '7.jpg'),
		('Acer Predator Helios 300', 'Laptop gaming de Acer con gran capacidad de procesamiento', 8, 3, 1099.99, 12, 'D:\FOTOS_PRODUCTOS', '8.jpg'),
		('Sony WH-1000XM4', 'Auriculares inalámbricos con cancelación de ruido de Sony', 9, 6, 349.99, 100, 'D:\FOTOS_PRODUCTOS', '9.jpg'),
		('LG OLED CX', 'Televisor OLED 4K de LG', 10, 14, 1999.99, 8, 'D:\FOTOS_PRODUCTOS', '10.jpg'),
		('Huawei P40 Pro', 'Smartphone de alta gama de Huawei', 11, 1, 899.99, 40, 'D:\FOTOS_PRODUCTOS', '11.jpg'),
		('Xiaomi Mi 11', 'Smartphone de última generación de Xiaomi', 12, 1, 699.99, 60, 'D:\FOTOS_PRODUCTOS', '12.jpg'),
		('Google Pixel 5', 'Smartphone de Google con Android puro', 13, 1, 699.99, 45, 'D:\FOTOS_PRODUCTOS', '13.jpg'),
		('Intel Core i9-10900K', 'Procesador de décima generación de Intel', 14, 7, 499.99, 100, 'D:\FOTOS_PRODUCTOS', '14.jpg'),
		('AMD Ryzen 9 5900X', 'Procesador de alta gama de AMD', 15, 7, 549.99, 85, 'D:\FOTOS_PRODUCTOS', '15.jpg'),
		('Nvidia GeForce RTX 3080', 'Tarjeta gráfica de última generación de Nvidia', 16, 7, 699.99, 30, 'D:\FOTOS_PRODUCTOS', '16.jpg'),
		('Cisco Catalyst 9500', 'Switch de red de alta capacidad de Cisco', 17, 6, 2999.99, 5, 'D:\FOTOS_PRODUCTOS', '17.jpg'),
		('TP-Link Archer AX6000', 'Router Wi-Fi 6 de alta velocidad de TP-Link', 18, 6, 349.99, 50, 'D:\FOTOS_PRODUCTOS', '18.jpg'),
		('Netgear Nighthawk AX12', 'Router Wi-Fi 6 de alta gama de Netgear', 19, 6, 499.99, 35, 'D:\FOTOS_PRODUCTOS', '19.jpg')
GO

SELECT * FROM PRODUCTO
GO

--Insercion de Datos CLIENTE
INSERT INTO CLIENTE (Nombres, Apellidos, Correo, Clave) 
VALUES 
		('Carlos', 'González', 'carlos@gmail.com', 'password456'),
		('María', 'Fernández', 'maria@gmail.com', 'password789'),
		('Luisa', 'Martínez', 'luisa@gmail.com', 'password101'),
		('Jorge', 'Rodríguez', 'jorge@gmail.com', 'password202')
GO

SELECT * FROM CLIENTE
GO

--Inserciones de Datos CARRITO
INSERT INTO CARRITO (IdCliente, IdProducto, Cantidad) 
VALUES 
		(1, 1, 2),
		(2, 3, 1),
		(3, 2, 4),
		(4, 5, 1),
		(1, 4, 2),
		(2, 6, 3),
		(3, 7, 1),
		(4, 8, 2),
		(1, 9, 1),
		(2, 10, 2)
GO

SELECT * FROM CARRITO
GO

--Inserciones de Datos VENTA
INSERT INTO VENTA (IdCliente, TotalProducto, MontoTotal, Contacto, IdDistrito, Telefono, Direccion, IdTransaccion)
VALUES 
		(1, 3, 1499.97, 'Juan Pérez', '001', '123456789', 'Calle Falsa 123', 'TX123456'),
		(2, 2, 1599.98, 'Carlos González', '002', '987654321', 'Avenida Siempre Viva 456', 'TX654321'),
		(3, 5, 2599.95, 'María Fernández', '003', '456789123', 'Plaza Mayor 789', 'TX789123'),
		(4, 4, 2199.96, 'Luisa Martínez', '004', '321654987', 'Calle Luna 987', 'TX987654')
GO

SELECT * FROM VENTA
GO

--Inserciones de Datos DETALLE_VENTA
INSERT INTO DETALLE_VENTA (IdVenta, IdProducto, Cantidad, Total) 
VALUES 
		(1, 1, 1, 999.99),
		(1, 2, 2, 499.98),
		(2, 3, 1, 899.99),
		(2, 4, 1, 699.99),
		(3, 5, 2, 1299.98),
		(3, 6, 1, 1199.99),
		(3, 7, 2, 99.98),
		(4, 8, 1, 1099.99),
		(4, 9, 2, 219.98),
		(4, 10, 1, 879.99)
GO

SELECT * FROM DETALLE_VENTA
GO

--Inserciones de Datos DEPARTAMENTO
INSERT INTO DEPARTAMENTO (IdDepartamento, Descripcion) 
VALUES 
		('01', 'Lima'),
		('02', 'Arequipa'),
		('03', 'Cusco')
GO

SELECT * FROM DEPARTAMENTO
GO

--Inserciones de Datos PROVINCIA
INSERT INTO PROVINCIA (IdProvincia, Descripcion, IdDepartamento) 
VALUES 
		('0101', 'Lima', '01'),
		('0102', 'Callao', '01'),

		('0201', 'Arequipa', '02'),
		('0202', 'Camana', '02'),

		('0301', 'Cusco', '03'),
		('0302', 'Urubamba', '03')
GO

SELECT * FROM PROVINCIA
GO

--Inserciones de Datos DISTRITO
INSERT INTO DISTRITO (IdDistrito, Descripcion, IdProvincia, IdDepartamento) 
VALUES 
		('010101', 'Miraflores', '0101', '01'),
		('010102', 'San Isidro', '0101', '01'),
		('010201', 'Bellavista', '0102', '01'),
		('010202', 'La Perla', '0102', '01'),

		('020101', 'Yanahuara', '0201', '02'),
		('020102', 'Cayma', '0201', '02'),
		('020201', 'Mariscal Caceres', '0202', '02'),
		('020202', 'Samuel Pastor', '0202', '02'),

		('030101', 'Santiago', '0301', '03'),
		('030102', 'San Sebastian', '0301', '03'),
		('030201', 'Ollantaytambo', '0302', '03'),
		('030202', 'Urubamba', '0302', '03')
GO

SELECT * FROM DISTRITO
GO

