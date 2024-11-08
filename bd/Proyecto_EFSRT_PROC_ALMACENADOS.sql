USE PROYECTO_EFSRT
GO

-- PROCEDIMIENTOS ALMACENADOS - USUARIOS
-- Registrar usuario
CREATE OR ALTER PROC REGISTRAR_USUARIO(
	@Nombres VARCHAR(100),
	@Apellidos VARCHAR(100),
	@Correo VARCHAR(100),
	@Clave VARCHAR(100),
	@Activo BIT,
	@Mensaje VARCHAR(500) OUTPUT,
	@Resultado INT OUTPUT
)
AS
BEGIN
	SET @Resultado = 0

	IF NOT EXISTS (SELECT * FROM USUARIO WHERE Correo = @Correo)
		BEGIN
			INSERT INTO USUARIO(Nombres, Apellidos, Correo, Clave, Activo) VALUES
			(@Nombres, @Apellidos, @Correo, @Clave, @Activo)

			SET @Resultado = SCOPE_IDENTITY()
		END
	ELSE
		SET @Mensaje = 'El correo del usuario ya existe'
END
GO

-- Editar usuario
CREATE OR ALTER PROC EDITAR_USUARIO(
	@IdUsuario INT,
	@Nombres VARCHAR(100),
	@Apellidos VARCHAR(100),
	@Correo VARCHAR(100),
	@Activo BIT,
	@Mensaje VARCHAR(500) OUTPUT,
	@Resultado BIT OUTPUT
)
AS
BEGIN
	SET @Resultado = 0

	IF NOT EXISTS (SELECT * FROM USUARIO WHERE Correo = @Correo AND IdUsuario != @IdUsuario)
		BEGIN
			UPDATE TOP(1) USUARIO SET
				Nombres = @Nombres,
				Apellidos = @Apellidos,
				Correo = @Correo,
				Activo = @Activo
			WHERE IdUsuario = @IdUsuario

			SET @Resultado = 1
		END
	ELSE
		SET @Mensaje = 'El correo del usuario ya existe'
END
GO

-- PROCEDIMIENTOS ALMACENADOS - CATEGORIAS
-- Registrar Categoria
CREATE OR ALTER PROC REGISTRAR_CATEGORIA(
	@Descripcion varchar(100),
	@Activo bit,
	@Mensaje varchar(500)output,
	@Resultado int output
)
AS
BEGIN
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion)
	BEGIN
		INSERT INTO CATEGORIA(Descripcion,Activo) VALUES
		(@Descripcion,@Activo)

		SET @Resultado = SCOPE_IDENTITY()
	END
	ELSE
	  SET @Mensaje = 'La categoria ya existe'
END

SELECT * FROM CATEGORIA
GO


-- Editar Categoria
CREATE OR ALTER PROC EDITAR_CATEGORIA(
	@IdCategoria int,
	@Descripcion varchar(100),
	@Activo bit,
	@Mensaje varchar(500) output,
	@Resultado bit output
)
AS
BEGIN 
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion AND IdCategoria != @IdCategoria)
	BEGIN
		UPDATE TOP (1) CATEGORIA SET
			Descripcion = @Descripcion,
			Activo = @Activo
		WHERE IdCategoria = @IdCategoria

		SET @Resultado = 1
	END
	ELSE
		SET @Mensaje = 'La categoria ya existe'
END

SELECT * FROM CATEGORIA
GO

-- Eliminar Categoria
CREATE OR ALTER PROC ELIMINAR_CATEGORIA(
	@IdCategoria INT,
	@Mensaje VARCHAR(500) OUTPUT,
	@Resultado BIT OUTPUT
)
AS
BEGIN
	SET @Resultado = 0
	
	BEGIN 
		UPDATE TOP (1) CATEGORIA SET
			Eliminado = 'Si'
		WHERE IdCategoria = @IdCategoria
		SET @Resultado = 1
	END
		SET @Mensaje = 'La categoria se encuentra relacionado a un producto'
END
GO

-- PROCEDIMIENTOS ALMACENADOS - MARCAS
-- Registrar Marca
CREATE OR ALTER PROC REGISTRAR_MARCA(
	@Descripcion VARCHAR(100),
	@Activo BIT,
	@Mensaje VARCHAR(500)OUTPUT,
	@Resultado INT OUTPUT
)
AS
BEGIN 
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion)
	BEGIN 
		INSERT INTO MARCA(Descripcion,Activo) VALUES
		(@Descripcion,@Activo)

		SET @Resultado = SCOPE_IDENTITY()
	END
	ELSE
		SET @Mensaje = 'La marca ya existe'
END
GO

-- Editar Categoria
CREATE OR ALTER PROC EDITAR_MARCA(
	@IdMarca int,
	@Descripcion varchar(100),
	@Activo bit,
	@Mensaje varchar(500) output,
	@Resultado bit output
)
AS
BEGIN 
	SET @Resultado = 0
	IF NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion AND IdMarca != @IdMarca)
	BEGIN
		UPDATE TOP (1) MARCA SET
			Descripcion = @Descripcion,
			Activo = @Activo
		WHERE IdMarca = @IdMarca

		SET @Resultado = 1
	END
	ELSE
		SET @Mensaje = 'La marca ya existe'
END
GO

-- Eliminar Marca
CREATE OR ALTER PROC ELIMINAR_MARCA
	@IdMarca INT,
	@Mensaje VARCHAR(500) OUTPUT,
	@Resultado BIT OUTPUT
AS
BEGIN
	SET @Resultado = 0
	
	BEGIN 
		UPDATE TOP (1) MARCA SET
			Eliminado = 'Si'
		WHERE IdMarca = @IdMarca
		SET @Resultado = 1
	END
		SET @Mensaje = 'La marca se encuentra relacionada a un producto'
END
GO

-- PROCEDIMIENTOS ALMACENADOS - PRODUCTOS
-- Listar producto
CREATE OR ALTER PROC LISTAR_PRODUCTOS
AS
BEGIN
	SELECT p.IdProducto, p.Nombre, p.Descripcion,
		   m.IdMarca, m.Descripcion [Marca],
		   c.IdCategoria, c.Descripcion [Categoria],
		   p.Precio, p.Stock, p.RutaImagen, p.NombreImagen, p.Activo
	FROM PRODUCTO p
	INNER JOIN MARCA m ON m.IdMarca = p.IdMarca
	INNER JOIN CATEGORIA c ON c.IdCategoria = p.IdCategoria
	WHERE p.Eliminado = 'No'
END
GO

-- Registrar producto
CREATE OR ALTER PROC REGISTRAR_PRODUCTO(
	@Nombre VARCHAR(100),
	@Descripcion VARCHAR(100),
	@IdMarca VARCHAR(100),
	@IdCategoria VARCHAR(100),
	@Precio DECIMAL(10,2),
	@Stock INT,
	@Activo BIT,
	@Mensaje VARCHAR(500) OUTPUT,
	@Resultado INT OUTPUT
)
AS
BEGIN
	SET @Resultado = 0
	IF NOT EXISTS(SELECT * FROM PRODUCTO WHERE Nombre = @Nombre)
		BEGIN
			INSERT INTO PRODUCTO(Nombre, Descripcion, IdMarca, IdCategoria, Precio, Stock, Activo) VALUES
			(@Nombre, @Descripcion, @IdMarca, @IdCategoria, @Precio, @Stock, @Activo)

			SET @Resultado = SCOPE_IDENTITY()
		END
	ELSE
		SET @Mensaje = 'El producto ya existe'
END
GO

-- Editar producto
CREATE OR ALTER PROC EDITAR_PRODUCTO(
	@IdProducto INT,
	@Nombre VARCHAR(100),
	@Descripcion VARCHAR(100),
	@IdMarca VARCHAR(100),
	@IdCategoria VARCHAR(100),
	@Precio DECIMAL(10,2),
	@Stock INT,
	@Activo BIT,
	@Mensaje VARCHAR(500) OUTPUT,
	@Resultado INT OUTPUT
)
AS
BEGIN
	SET @Resultado = 0
	IF NOT EXISTS(SELECT * FROM PRODUCTO WHERE Nombre = @Nombre AND IdProducto != @IdProducto)
		BEGIN
			UPDATE PRODUCTO SET
				Nombre = @Nombre,
				Descripcion = @Descripcion,
				IdMarca = @IdMarca,
				IdCategoria = @IdCategoria,
				Precio = @Precio,
				Stock = @Stock,
				Activo = @Activo
			WHERE IdProducto = @IdProducto

			SET @Resultado = 1
		END
	ELSE
		SET @Mensaje = 'El producto ya existe'
END
GO

-- Eliminar producto
CREATE OR ALTER PROC ELIMINAR_PRODUCTO(
	@IdProducto INT,
	@Mensaje VARCHAR(500) OUTPUT,
	@Resultado BIT OUTPUT
)
AS
BEGIN
	SET @Resultado = 0
	IF NOT EXISTS(SELECT * FROM DETALLE_VENTA dv
	INNER JOIN PRODUCTO p ON p.IdProducto = dv.IdProducto
	WHERE p.IdProducto = dv.IdProducto)
	BEGIN 
		UPDATE TOP (1) PRODUCTO SET
			Eliminado = 'Si'
		WHERE IdProducto = @IdProducto
		SET @Resultado = 1
	END
	ELSE
		SET @Mensaje = 'El producto se encuentra relacionado a una venta'
END
GO

-- PROCEDIMIENTOS ALMACENADOS - CLIENTES
-- Login y registro de Clientes
CREATE OR ALTER PROCEDURE sp_RegistrarCliente
    @Nombres varchar(100),
    @Apellidos varchar(100),
    @Correo varchar(100),
    @Clave varchar(150),
    @Resultado bit OUTPUT,
    @Mensaje varchar(255) OUTPUT
AS
BEGIN
    SET @Resultado = 0;
    SET @Mensaje = '';

    IF EXISTS (SELECT 1 FROM CLIENTE WHERE Correo = @Correo)
    BEGIN
        SET @Mensaje = 'El correo ya está registrado.';
        RETURN;
    END

    BEGIN TRY
        INSERT INTO CLIENTE (Nombres, Apellidos, Correo, Clave)
        VALUES (@Nombres, @Apellidos, @Correo, @Clave);

        SET @Resultado = 1;
        SET @Mensaje = 'Cliente registrado exitosamente.';
    END TRY
    BEGIN CATCH
        SET @Resultado = 0;
        SET @Mensaje = 'Error al registrar el cliente: ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- Probando
DECLARE @Registrado bit;
DECLARE @Mensaje varchar(255);
EXEC sp_RegistrarCliente 
    @Nombres = 'Juan',
    @Apellidos = 'Pérez',
    @Correo = 'juan.pere@example.com',
    @Clave = '5ac0852e770506dcd80f1a36d20ba7878bf82244b836d9324593bd14bc56dcb5',
    @Resultado = @Registrado OUTPUT,
    @Mensaje = @Mensaje OUTPUT;
SELECT @Registrado AS Registrado, @Mensaje AS Mensaje;
GO

-- Validar Clientes
CREATE OR ALTER PROCEDURE sp_ValidarCliente
    @Correo varchar(100),
    @Clave varchar(150),
    @Iniciado bit OUTPUT,
    @Mensaje varchar(255) OUTPUT
AS
BEGIN
    SET @Iniciado = 0;
    SET @Mensaje = '';

    IF EXISTS (SELECT 1 FROM CLIENTE WHERE Correo = @Correo AND Clave = @Clave AND Eliminado = 'No')
    BEGIN
        SET @Iniciado = 1;
        SET @Mensaje = 'Inicio de sesión exitoso.';
    END
    ELSE
    BEGIN
        SET @Iniciado = 0;
        SET @Mensaje = 'Correo o clave incorrectos, o la cuenta ha sido eliminada.';
    END
END
GO

-- Probando
DECLARE @Iniciado bit;
DECLARE @Mensaje varchar(255);

EXEC sp_ValidarCliente
    @Correo = 'juan.pere@example.com',
    @Clave = '5ac0852e770506dcd80f1a36d20ba7878bf82244b836d9324593bd14bc56dcb5',
    @Iniciado = @Iniciado OUTPUT,
    @Mensaje = @Mensaje OUTPUT;
SELECT @Iniciado AS Iniciado, @Mensaje AS Mensaje;
GO

-- PROCEDIMIENTOS ALMACENADOS - DETALLE VENTAS
-- Listar detalle ventas
CREATE OR ALTER PROC LISTAR_VENTAS(
	@FechaInicio VARCHAR(10),
	@FechaFin VARCHAR(10),
	@IdTransaccion VARCHAR(50)
)
AS
BEGIN
	
	SET DATEFORMAT dmy;

	SELECT CONVERT(char(10), v.FechaVenta, 103) [FechaVenta], 
		   CONCAT(c.Nombres, ' ', c.Apellidos) [NombreCliente], 
		   p.Nombre, p.Precio, dv.Cantidad, dv.Total, v.IdTransaccion
	FROM DETALLE_VENTA dv
	INNER JOIN PRODUCTO p ON p.IdProducto = dv.IdProducto
	INNER JOIN VENTA v ON v.IdVenta = dv.IdVenta
	INNER JOIN CLIENTE c ON c.IdCliente = v.IdCliente
	WHERE CONVERT(date, v.FechaVenta) BETWEEN @FechaInicio AND @FechaFin 
	AND v.IdTransaccion =  IIF(@IdTransaccion = '', v.IdTransaccion, @IdTransaccion)

END
GO

-- Probando
EXEC LISTAR_VENTAS '27/06/2024', '27/06/2024', ''
GO

-- PROCEDIMIENTOS ALMACENADOS - RESUMEN CAPA ADMIN
-- Conteo de registros
CREATE OR ALTER PROC RESUMEN_INDEX
AS
BEGIN
	SELECT
		(SELECT COUNT(*) FROM CLIENTE WHERE Eliminado = 'No') [TotalCliente],
		(SELECT ISNULL(SUM(Cantidad),0) FROM DETALLE_VENTA) [TotalVenta],
		(SELECT COUNT(*) FROM PRODUCTO WHERE Eliminado = 'No') [TotalProducto],
		(SELECT COUNT(*) FROM CATEGORIA WHERE Eliminado = 'No') [TotalCategoria],
		(SELECT COUNT(*) FROM MARCA WHERE Eliminado = 'No') [TotalMarca]
END
GO

-- PROCEDIMIENTOS ALMACENADOS - CARRITO
-- Validar carrito
CREATE OR ALTER PROC VALIDAR_CARRITO(
	@IdCliente INT,
	@IdProducto INT,
	@Resultado BIT OUTPUT
)
AS
BEGIN
	IF EXISTS(SELECT * FROM CARRITO WHERE IdCliente = @IdCliente AND IdProducto = @IdProducto)
		SET @Resultado = 1
	ELSE
		SET @Resultado = 0
END
GO

-- Operaciones carrito
CREATE OR ALTER PROC OPERACION_CARRITO(
	@IdCliente INT,
	@IdProducto INT, 
	@Sumar BIT,
	@Mensaje VARCHAR(500) OUTPUT,
	@Resultado BIT OUTPUT
)
AS
BEGIN
	SET @Resultado = 1
	SET @Mensaje = ''

	DECLARE @existecarrito BIT = IIF(EXISTS(SELECT * FROM CARRITO WHERE IdCliente = @IdCliente AND IdProducto = @IdProducto),1,0)
	DECLARE @stock INT = (SELECT Stock FROM PRODUCTO WHERE IdProducto = @IdProducto)

	BEGIN TRY
		BEGIN TRANSACTION OPERACION
			IF(@Sumar = 1)
				BEGIN
					IF(@stock > 0)
						BEGIN
							IF(@existecarrito = 1)
								BEGIN
									UPDATE CARRITO SET Cantidad = Cantidad + 1 WHERE IdCliente = @IdCliente AND IdProducto = @IdProducto
								END
							ELSE
								BEGIN
									INSERT INTO CARRITO(IdCliente, IdProducto, Cantidad) VALUES(@IdCliente, @IdProducto, 1)
								END
							UPDATE PRODUCTO SET Stock = Stock - 1 WHERE IdProducto = @IdProducto
						END
					ELSE
						BEGIN
							SET @Resultado = 0
							SET @Mensaje = 'Producto agotado'
						END
				END
			ELSE
				BEGIN
					UPDATE CARRITO SET Cantidad = Cantidad - 1 WHERE IdCliente = @IdCliente AND IdProducto = @IdProducto
					UPDATE PRODUCTO SET Stock = Stock + 1 WHERE IdProducto = @IdProducto
				END

		COMMIT TRANSACTION OPERACION
	END TRY
	BEGIN CATCH
		SET @Resultado = 0
		SET @Mensaje = ERROR_MESSAGE()
		ROLLBACK TRANSACTION OPERACION
	END CATCH
END
GO

-- Funcion obtener carrito
CREATE OR ALTER FUNCTION OBTENER_CARRITO(
	@IdCliente INT
)
RETURNS TABLE
AS
RETURN(
	SELECT p.IdProducto, m.Descripcion[Marca], p.Nombre, p.Precio, c.Cantidad, p.RutaImagen, p.NombreImagen
	FROM CARRITO c
	INNER JOIN PRODUCTO p ON p.IdProducto = c.IdProducto
	INNER JOIN MARCA m ON m.IdMarca = p.IdMarca
	WHERE c.IdCliente = @IdCliente
)
GO

-- Probando
SELECT * FROM OBTENER_CARRITO(1)
GO

-- Eliminar carrito
CREATE OR ALTER PROC ELIMINAR_CARRITO(
	@IdCliente INT,
	@IdProducto INT,
	@Resultado BIT OUTPUT
)
AS
BEGIN
	SET @Resultado = 1
	DECLARE @cantidad INT = (SELECT Cantidad FROM CARRITO WHERE IdCliente = @IdCliente AND IdProducto = @IdProducto)

	BEGIN TRY
		BEGIN TRANSACTION OPERACION
			UPDATE PRODUCTO SET Stock = Stock + @cantidad WHERE IdProducto = @IdProducto
			DELETE TOP(1) FROM CARRITO WHERE IdCliente = @IdCliente AND IdProducto = @IdProducto
		COMMIT TRANSACTION OPERACION
	END TRY
	BEGIN CATCH
		SET @Resultado = 0
		ROLLBACK TRANSACTION OPERACION
	END CATCH
END
GO

-- Detalle de venta como parametro
CREATE TYPE [DBO].[EDetalle_Venta] AS TABLE (
[IdProducto] int null,
[Cantidad] int null, 
[Total]decimal (18,2) null)
GO

-- Registrar venta
CREATE OR ALTER PROCEDURE usp_RegistrarVenta(
@IdCliente int,
@TotalProducto int,
@MontoTotal decimal (18, 2),
@Contacto varchar(100),
@IdDistrito varchar(6),
@Telefono varchar(10),
@Direccion varchar(100),
@IdTransaccion varchar(50),
@DetalleVenta [EDetalle_Venta] READONLY,
@Resultado bit output,
@Mensaje varchar(500) output
) as
begin
	begin try
		declare @idventa int =0
		set @Resultado = 1
		set @Mensaje = ''

		begin transaction registro

		insert into VENTA(IdCliente, TotalProducto, MontoTotal, Contacto, IdDistrito, Telefono, Direccion, IdTransaccion)
		values(@IdCliente, @TotalProducto, @MontoTotal, @Contacto, @IdDistrito, @Telefono, @Direccion, @IdTransaccion)

		set @idventa = SCOPE_IDENTITY()

		INSERT INTO DETALLE_VENTA(IdVenta, IdProducto, Cantidad, Total)
		select @idventa, IdProducto, Cantidad, Total from @DetalleVenta

		Delete from CARRITO where IdCliente = @IdCliente

		commit transaction registro 
	end try 
	begin catch
		set @Resultado = 0
		set @Mensaje = ERROR_MESSAGE()
		rollback transaction registro 
	end catch
end 
go 

-- Listar compras
CREATE OR ALTER FUNCTION fn_ListarCompra(
@idcliente int
)
RETURNS TABLE 
AS
RETURN 
(
select p.RutaImagen, p.NombreImagen, p.Nombre, p.Precio, DV.Cantidad, DV.Total, V.IdTransaccion from DETALLE_VENTA DV
INNER JOIN PRODUCTO p on p.IdProducto = DV.IdProducto
INNER JOIN VENTA V ON V.IdVenta = DV.IdVenta
where V.IdCliente = @idcliente
)
GO
