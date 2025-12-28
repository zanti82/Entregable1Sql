use rambed_ecommerce;

DELIMITER $$
-- creamos el procedure para el registor de ventas

CREATE PROCEDURE sp_registrar_venta(
    IN p_fecha DATETIME,
    IN p_idCliente INT,
    IN p_estadoEnvio VARCHAR(50)
)
BEGIN
    INSERT INTO venta (fechaVenta, idCliente, estadoEnvio)
    VALUES (p_fecha, p_idCliente, p_estadoEnvio);
END$$

DELIMITER ;

-- usamos el procedure con un call, priemro buscamos un cleint registrado, luego usamos le procedure

select * from clientes;

CALL sp_registrar_venta('2024-11-15', 1090123456, 'enviado');

--  revisamos la tabla ventas

select * from venta;

-- ahora agregamos los detalles de compra a la venta con otro procedure, mirnado que la venta fue con id 22



DELIMITER $$

CREATE PROCEDURE sp_agregar_detalle_venta(
    IN p_idVenta INT,
    IN p_idVariante INT,
    IN p_unidades INT,
    IN p_precio DECIMAL(10,2)
)
BEGIN
    INSERT INTO variante_venta (idVenta, idVariante, unidades, precioVenta)
    VALUES (p_idVenta, p_idVariante, p_unidades, p_precio);
END$$

DELIMITER ;

-- miramos las referencias y sus varinates para ver los precios y asignar este info a la venta.
-- buscamos la info con las vista creada anteriormente

SELECT * FROM vista_inventario_actual;

-- agremos el datalle de a la venta 22 con la referencia 17 que e sun jena regular  stone talla 30

CALL sp_agregar_detalle_venta(22, 17, 2, 98000);

-- revisamos esta venta en variante_venta

select * from variante_venta;


DELIMITER $$
-- con este registramos le pago de la venta

CREATE PROCEDURE sp_registrar_pago(
    IN p_idVenta INT,
    IN p_metodoPago VARCHAR(50),
    IN p_estado VARCHAR(50),
    IN p_idTransaccion VARCHAR(100)
)
BEGIN
    INSERT INTO pagos (idVenta, metodoPago, estadoTransaccion, idTransaccionPasarela)
    VALUES (p_idVenta, p_metodoPago, p_estado, p_idTransaccion);
END$$

DELIMITER ;
-- llamamos la venta anterior que fue la 22 y le asiganoe le estado del pago

CALL sp_registrar_pago(22, 'tarjeta credito', 'exitosa', 'MP-889977');

-- revisamo el estado del pago

select * from pagos;



