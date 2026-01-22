use rambed_ecommerce;

-- VISTAS ACTUALES
-- invenatario

SELECT * FROM vista_inventario_actual;

update inventario set cantidadStock = 5 where idVariante = 10;

SELECT idVariante, cantidadStock FROM vista_inventario_actual where idVariante= 10;

-- revisamos que quede actulizado el stock con la funcion guardada

SELECT fn_stock_variante(10);

select * from auditoria_inventario; -- aca vemos que el trigger esta funcionando


-- PROCEDIMIENTOS

-- ventas, creamo la venta con un id registrado

CALL sp_registrar_venta('2026-01-22', 1090123456, 'Pendiente');

-- asignamos variante a la venta la venta 11 fue la anterior, asiganos varinate 10, 2 und y variante 1, 1und

CALL sp_agregar_detalle_venta(11, 10, 2, 98000);
CALL sp_agregar_detalle_venta(11, 1, 1, 100000);

-- revisamos estados de venta

SELECT fn_total_venta(11);
SELECT fn_stock_variante(10);

-- revisamos auditoria

select * from auditoria_inventario;




