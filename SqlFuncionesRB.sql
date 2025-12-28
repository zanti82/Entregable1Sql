USE rambed_ecommerce;

DELIMITER $$
-- creamos la funcion que nos muestra la venta total por el id del variante vnenta

CREATE FUNCTION fn_total_venta(p_idVenta INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(unidades * precioVenta)
    INTO total
    FROM variante_venta
    WHERE idVenta = p_idVenta;

    RETURN IFNULL(total, 0);
END$$

DELIMITER ;

-- ensayamos la funcion por id de la variante_venta
SELECT fn_total_venta(2);

DELIMITER $$

-- funcion que deveulve valor del stock por varinate del inventario

CREATE FUNCTION fn_stock_variante(p_idVariante INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE stock INT;

    SELECT cantidadStock
    INTO stock
    FROM inventario
    WHERE idVariante = p_idVariante;

    RETURN IFNULL(stock, 0);
END$$

DELIMITER ;

-- usamos la funcion con el id de la variante
SELECT fn_stock_variante(1);

DELIMITER $$
-- creamos la funcion para sumar el stock total que se tiene

CREATE FUNCTION fn_total_stock()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalStock INT;

    SELECT SUM(cantidadStock)
    INTO totalStock
    FROM inventario;

    RETURN IFNULL(totalStock, 0);
END$$

DELIMITER ;
-- usamos la funcion para ver todo el stock 

SELECT fn_total_stock();