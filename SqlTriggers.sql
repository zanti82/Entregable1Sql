use rambed_ecommerce;

-- trigger para actulizar el stock cuando sea aprovada la transaccion
DELIMITER $$

CREATE TRIGGER t_pago_actualiza_venta
after insert on pagos
for each row
 begin
	if new.estadoTransaccion = 'Aprobada' then
		
        update venta
        set estadoVenta = 'Pagada'
        where idVenta = new.idVenta;
	end if;
end $$

DELIMITER ;


-- trigger para invenatrio no negativo
DELIMITER $$

CREATE TRIGGER trg_no_stock_negativo
BEFORE UPDATE ON inventario
FOR EACH ROW
BEGIN
    IF NEW.cantidadStock < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El stock no puede ser negativo';
    END IF;
END$$

DELIMITER ;

-- rigger para auditar inventario entrada manuaul
DELIMITER $$

CREATE TRIGGER trg_auditoria_update_inventario
AFTER UPDATE ON inventario
FOR EACH ROW
BEGIN
    -- esto para cuando cambia el stock manual
    
    IF OLD.cantidadStock <> NEW.cantidadStock THEN

        INSERT INTO auditoria_inventario (
            idVariante,
            tipoMovimiento,
            cantidad,
            stockAntes,
            stockDespues,
            referencia
        )
        VALUES (
            NEW.idVariante,
            'ajuste',
            NEW.cantidadStock - OLD.cantidadStock,
            OLD.cantidadStock,
            NEW.cantidadStock,
            'Ajuste manual de inventario'
        );

    END IF;
END$$

DELIMITER ;
