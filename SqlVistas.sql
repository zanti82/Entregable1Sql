USE rambed_ecommerce;

CREATE VIEW vista_inventario_actual AS
SELECT
    inventario.idVariante,
    referencias.idReferencia,
    referencias.nombreReferencia,
    tallas.nombreTalla,
    colores.color,
    inventario.cantidadStock
FROM inventario
JOIN variantes ON inventario.idVariante = variantes.idVariante
JOIN referencias ON variantes.idReferencia = referencias.idReferencia
JOIN tallas ON variantes.idTalla = tallas.idTalla
JOIN colores ON variantes.idColor = colores.idColor;

SELECT * FROM vista_inventario_actual;

CREATE VIEW venta_detalle AS
SELECT
    venta.idVenta,
    venta.fechaVenta,
    clientes.idCliente,
    clientes.nombreCliente,
    venta.estadoEnvio
FROM venta
JOIN clientes ON venta.idCliente = clientes.idCliente;

SELECT * FROM venta_detalle;

CREATE OR REPLACE VIEW ventas_totales AS
SELECT
    venta.idVenta,
    venta.fechaVenta,
    clientes.nombreCliente,
    SUM(variante_venta.unidades * variante_venta.precioVenta) AS totalVenta
FROM venta
JOIN clientes ON venta.idCliente = clientes.idCliente
JOIN variante_venta ON venta.idVenta = variante_venta.idVenta
GROUP BY venta.idVenta, venta.fechaVenta, clientes.nombreCliente;

SELECT * FROM ventas_totales order by nombreCliente;

CREATE VIEW productos_mas_vendidos AS
SELECT
    referencias.nombreReferencia,
    SUM(variante_venta.unidades) AS unidadesVendidas
FROM variante_venta
JOIN variantes ON variante_venta.idVariante = variantes.idVariante
JOIN referencias ON variantes.idReferencia = referencias.idReferencia
GROUP BY referencias.nombreReferencia;

SELECT * FROM productos_mas_vendidos;
