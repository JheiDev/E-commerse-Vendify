CREATE DATABASE PROYECTO_EFSRT
GO

USE PROYECTO_EFSRT
GO

--Tabla Categoria
CREATE TABLE CATEGORIA (
	IdCategoria int primary key identity,
	Descripcion varchar(100),
	Activo bit default 1,
	Eliminado char(2) default 'No',
	FechaRegistro datetime default getdate()
)
GO

--Tabla Marca
CREATE TABLE MARCA (
	IdMarca int primary key identity,
	Descripcion varchar(100),
	Activo bit default 1,
	Eliminado char(2) default 'No',
	FechaRegistro datetime default getdate()
)
GO

--Tabla Producto
CREATE TABLE PRODUCTO (
	IdProducto int primary key identity,
	Nombre varchar(500),
	Descripcion varchar(500),
	IdMarca int references Marca(IdMarca),
	IdCategoria int references Categoria(IdCategoria),
	Precio decimal(10,2) default 0,
	Stock int,
	RutaImagen varchar(100),
	NombreImagen varchar(100),
	Activo bit default 1,
	Eliminado char(2) default 'No',
	FechaRegistro datetime default getdate()	
)
GO

--Tabla Cliente
CREATE TABLE CLIENTE(
	IdCliente int primary key identity,
	Nombres varchar(100),
	Apellidos varchar(100),
	Correo varchar(100),
	Clave varchar(150),
	Reestablecer bit default 0,
	Eliminado char(2) default 'No',
	FechaRegistro datetime default getdate()
)
GO

--Tabla Usuario
CREATE TABLE USUARIO(
	IdUsuario int primary key identity,
	Nombres varchar(100),
	Apellidos varchar(100),
	Correo varchar(150),
	Clave varchar(150),
	Reestablecer bit default 1,
	Activo bit default 1,
	Eliminado char(2) default 'No',
	FechaRegistro datetime default getdate()
)
GO

--Tabla Carrito
CREATE TABLE CARRITO(
	IdCarrito int primary key identity,
	IdCliente int references CLIENTE(IdCliente),
	IdProducto int references PRODUCTO(IdProducto),
	Cantidad int
)
GO

--Tabla Venta
CREATE TABLE VENTA(
	IdVenta int primary key identity,
	IdCliente int references CLIENTE(IdCliente),
	TotalProducto int,
	MontoTotal decimal(10,2),
	Contacto varchar(50),
	IdDistrito varchar(10),
	Telefono varchar(50),
	Direccion varchar(500),
	IdTransaccion varchar(50),
	FechaVenta datetime default getdate()
)
GO

--Tabla Detale_Venta
CREATE TABLE DETALLE_VENTA(
	IdDetalleVenta int primary key identity,
	IdVenta int references VENTA(IdVenta),
	IdProducto int references PRODUCTO(IdProducto),
	Cantidad int,
	Total decimal(10,2)
)
GO

--Tabla Departamento
CREATE TABLE DEPARTAMENTO(
	IdDepartamento varchar(2) not null,
	Descripcion varchar(45) not null
)
GO

--Tabla Provincia
CREATE TABLE PROVINCIA(
	IdProvincia varchar(4) not null,
	Descripcion varchar(45) not null,
	IdDepartamento varchar(2) not null
)
GO

--Table Distrito
CREATE TABLE DISTRITO(
	IdDistrito varchar(6) not null,
	Descripcion varchar(45) not null,
	IdProvincia varchar(4) not null,
	IdDepartamento varchar(2) not null
)
GO

