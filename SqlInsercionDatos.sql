use rambed_ecommerce;

-- datos para clientes

INSERT INTO clientes (idCliente, nombreCliente, direccionCliente, correoCliente, telefonoCliente) VALUES
(1023456789, 'Juan Pérez', 'Cra 10 #45-32, Bogotá', 'juan.perez@gmail.com', '3001234567'),
(1034567890, 'María Gómez', 'Cl 80 #25-14, Medellín', 'maria.gomez@gmail.com', '3012345678'),
(1045678901, 'Carlos Rodríguez', 'Av 6N #23-45, Cali', 'carlos.rodriguez@gmail.com', '3023456789'),
(1056789012, 'Laura Martínez', 'Cra 15 #12-30, Barranquilla', 'laura.martinez@gmail.com', '3034567890'),
(1067890123, 'Andrés López', 'Cl 33 #18-22, Bucaramanga', 'andres.lopez@gmail.com', '3045678901'),
(1078901234, 'Diana Ramírez', 'Cra 7 #19-55, Pereira', 'diana.ramirez@gmail.com', '3056789012'),
(1089012345, 'Felipe Torres', 'Av Circunvalar #8-40, Santa Marta', 'felipe.torres@gmail.com', '3067890123'),
(1090123456, 'Natalia Herrera', 'Cl 60 #9-18, Manizales', 'natalia.herrera@gmail.com', '3078901234'),
(1101234567, 'Jorge Castillo', 'Cra 4 #11-62, Ibagué', 'jorge.castillo@gmail.com', '3089012345'),
(1112345678, 'Paola Sánchez', 'Cl 21 #5-70, Villavicencio', 'paola.sanchez@gmail.com', '3090123456');

--  revisamos tablas
select * from clientes;

-- datos para tallas

INSERT INTO tallas (nombreTalla) VALUES
("28"),("30"),("32"),("34"),("36"),("40");

--  revisamos tablas
select * from tallas;

INSERT INTO referencias (idReferencia, nombreReferencia, estiloReferencia) VALUES
(2501, 'Jean Clásico Azul', 'Clásico'),
(2502, 'Jean Slim Oscuro', 'Slim'),
(2503, 'Jean Cargo Urbano', 'Cargo'),
(2504, 'Jean Skinny Negro', 'Skinny'),
(2505, 'Jean Regular Stone', 'Regular'),
(2506, 'Jean Oversize Claro', 'Oversize');

--  revisamos ref
select * from referencias;

insert into colores (color) values 
("azulOscuro"), 
("azulMedio"), 
("azulClaro"),
("azulPetro"),
("negro"),
("gris"),
("dirty");

--  revisamos colores
select * from colores;

-- TABLA DE VARIANTES, COLORES POR CADA REFERENECIA CON VARIAS TALLAS

INSERT INTO variantes (idReferencia, idTalla, idColor) VALUES
-- Ref 2501 | azulOscuro | tallas 28–34
(2501, 1, 1),
(2501, 2, 1),
(2501, 3, 1),
(2501, 4, 1),

-- Ref 2502 | azulMedio | tallas 30–36
(2502, 2, 2),
(2502, 3, 2),
(2502, 4, 2),
(2502, 5, 2),

-- Ref 2503 | negro | tallas 32–40
(2503, 3, 5),
(2503, 4, 5),
(2503, 5, 5),
(2503, 6, 5),

-- Ref 2504 | gris | tallas 28–34
(2504, 1, 6),
(2504, 2, 6),
(2504, 3, 6),
(2504, 4, 6),

-- Ref 2505 | azulPetro | tallas 30–36
(2505, 2, 4),
(2505, 3, 4),
(2505, 4, 4),
(2505, 5, 4),

-- Ref 2506 | dirty | tallas 32–40
(2506, 3, 7),
(2506, 4, 7),
(2506, 5, 7),
(2506, 6, 7);

-- revisamos tabla de varinates

select * from variantes;

-- asignamos le stock inicial 

INSERT INTO inventario (idVariante, cantidadStock) VALUES
(1, 3),
(2, 5),
(3, 2),
(4, 4),

(5, 1),
(6, 3),
(7, 5),
(8, 2),

(9, 4),
(10, 0),
(11, 3),
(12, 5),

(13, 2),
(14, 4),
(15, 1),
(16, 3),

(17, 5),
(18, 2),
(19, 4),
(20, 1),

(21, 3),
(22, 5),
(23, 2),
(24, 4);

-- generamos 10 ventas para luego estudiarlas, estas son exitosas
-- luego anexamos los triggers y validaciones para crear mas ventas
select * from inventario;

INSERT INTO venta (fechaVenta, idCliente, estadoVenta, estadoEnvio) VALUES
('2024-10-05 10:15:00', 1023456789, 'Pagada', 'Enviado'),
('2024-10-12 16:40:00', 1034567890, 'Pagada', 'Enviado'),
('2024-10-20 11:05:00', 1045678901, 'Pagada', 'Enviado'),

('2024-11-03 14:20:00', 1023456789,'Pagada', 'Enviado'),
('2024-11-10 09:50:00', 1034567890, 'Pagada', 'Enviado'),
('2024-11-22 18:10:00', 1045678901,'Pagada', 'Enviado'),

('2024-12-02 12:30:00', 1023456789, 'Pagada', 'Enviado'),
('2024-12-09 15:45:00', 1034567890,'Pagada', 'Enviado'),
('2024-12-18 17:25:00', 1045678901, 'Pagada', 'Enviado'),
('2024-12-27 10:00:00', 1023456789, 'Pagada', 'Enviado');


-- asigancion de varinates y unidades a las ventas anteriores
--  revisamos las ventas

select * from venta;

INSERT INTO variante_venta (idVenta, idVariante, unidades, precioVenta) VALUES
-- Venta 1
(1, 1, 1, 85000),
(1, 2, 2, 85000),

-- Venta 2
(2, 3, 1, 85000),
(2, 4, 1, 85000),
(2, 5, 2, 92000),

-- Venta 3
(3, 6, 1, 92000),

-- Venta 4
(4, 7, 2, 92000),
(4, 8, 1, 92000),

-- Venta 5
(5, 9, 1, 110000),
(5, 10, 2, 110000),
(5, 11, 1, 110000),

-- Venta 6
(6, 12, 1, 110000),

-- Venta 7
(7, 13, 2, 80000),
(7, 14, 1, 80000),

-- Venta 8
(8, 15, 1, 80000),
(8, 16, 2, 80000),

-- Venta 9
(9, 17, 1, 98000),
(9, 18, 2, 98000),
(9, 19, 1, 98000),

-- Venta 10
(10, 20, 2, 105000);

-- en la siguiente sentencia priemeor se eliminar la columna monto
-- esta no la neceistamos ya que es un dato calculado.

select * from variante_venta;

ALTER table pagos DROP COLUMN monto;

-- ahora asgignaos el estado de pago de cada transaccion, como todas fueorn exitosas 
INSERT INTO pagos (idVenta, metodoPago, estadoTransaccion, idTransaccionPasarela) VALUES
(1, 'tarjeta_credito', 'Aprobada', 'MP-TRX-0001'),
(2, 'tarjeta_debito', 'Aprobada', 'MP-TRX-0002'),
(3, 'efectivo', 'Aprobada', 'MP-TRX-0003'),
(4, 'tarjeta_credito', 'Aprobada', 'MP-TRX-0004'),
(5, 'tarjeta_debito', 'Aprobada', 'MP-TRX-0005'),
(6, 'efectivo', 'Aprobada', 'MP-TRX-0006'),
(7, 'tarjeta_credito', 'Aprobada', 'MP-TRX-0007'),
(8, 'tarjeta_debito', 'Aprobada', 'MP-TRX-0008'),
(9, 'tarjeta_credito', 'Aprobada', 'MP-TRX-0009'),
(10, 'efectivo', 'Aprobada', 'MP-TRX-0010');

