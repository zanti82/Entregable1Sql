CREATE DATABASE if not exists rambed_Ecommerce;
USE rambed_Ecommerce;

CREATE TABLE clientes (
    idCliente INT PRIMARY KEY,
    nombreCliente VARCHAR(150) NOT NULL,
    direccionCliente VARCHAR(255),
    correoCliente VARCHAR(150) UNIQUE NOT NULL,
    telefonoCliente VARCHAR(20)
);

-- tabla tallas, ej: '30', '32', '36'
CREATE TABLE tallas (
    idTalla INT PRIMARY KEY AUTO_INCREMENT,
    nombreTalla VARCHAR(10) UNIQUE NOT NULL 
);

CREATE TABLE colores (
    idColor INT PRIMARY KEY AUTO_INCREMENT,
    color VARCHAR(10) NOT NULL 
);

-- las refe son defininidas por la empresa 
-- Ej: 'Slim Fit', 'Regular'
CREATE TABLE referencias (
    idReferencia INT PRIMARY KEY,
    nombreReferencia VARCHAR(100) NOT NULL,
    estiloReferencia VARCHAR(50)
   );

CREATE TABLE variantes (
	idVariante INT PRIMARY KEY AUTO_INCREMENT,
    idReferencia INT NOT NULL,
    idTalla INT NOT NULL,
    idColor INT NOT NULL,
      
    CONSTRAINT fk_VarianteRef FOREIGN KEY (idReferencia) REFERENCES referencias(idReferencia),
	CONSTRAINT fk_VarianteTalla FOREIGN KEY (idTalla) REFERENCES tallas(idTalla),
	CONSTRAINT fk_VarianteColor FOREIGN KEY (idColor) REFERENCES colores(idColor)
);

CREATE TABLE inventario (
    idVariante INT PRIMARY KEY,
    cantidadStock INT NOT NULL CHECK (cantidadStock >= 0),
    
    CONSTRAINT fk_InventarioVariante FOREIGN KEY (idVariante) REFERENCES variantes(idVariante)
);

-- para esta tabla manejar: creada, pagada, cancelda
CREATE TABLE venta (
    idVenta INT PRIMARY KEY AUTO_INCREMENT,
    fechaVenta DATETIME NOT NULL,
    idCliente INT NOT NULL,
    estadoVenta ENUM('Creada','Pagada','Cancelada') default	 "creada",
    estadoEnvio ENUM("Pendiente", "Enviado"), 
    
   
    CONSTRAINT fk_VentaCliente FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);

CREATE TABLE variante_venta (
    idVenta INT NOT NULL,
    idVariante INT NOT NULL,
    unidades INT NOT NULL CHECK (unidades > 0),
    precioVenta decimal(10,2),
        
    PRIMARY KEY (idVenta, idVariante), -- PK COMPUESTA
    
    
    CONSTRAINT fk_VarVenta FOREIGN KEY (idVenta) REFERENCES venta(idVenta),
    CONSTRAINT fk_VentaVar FOREIGN KEY (idVariante) REFERENCES variantes(idVariante)
);



-- poner estos valores en los pagos: 'Aprobado', 'Rechazado'
	CREATE TABLE pagos (
		idPago INT PRIMARY KEY AUTO_INCREMENT,
		idVenta INT NOT NULL,
		monto DECIMAL(10, 2) NOT NULL,
		metodoPago VARCHAR(50) NOT NULL,
		estadoTransaccion ENUM("Aprobada", "Rechazada"), 
		idTransaccionPasarela VARCHAR(100), -- este los traemos del MERCADOPAGO
		
	   
		CONSTRAINT fk_PagosVenta FOREIGN KEY (idVenta) REFERENCES venta(idVenta)
	);
    
    -- se crea esta tabla para hacer auditorrias del stock, con triggers
    
    CREATE TABLE auditoria_inventario (
    idAuditoria INT AUTO_INCREMENT PRIMARY KEY,
    idVariante INT NOT NULL,
    tipoMovimiento ENUM('venta','devolucion','ajuste','ingreso') NOT NULL,
    cantidad INT NOT NULL,
    stockAntes INT NOT NULL,
    stockDespues INT NOT NULL,
    referencia VARCHAR(100),
    fechaMovimiento DATETIME DEFAULT NOW()
);





