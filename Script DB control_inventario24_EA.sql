-- CREACION DE BASE DE DATOS
create database control_Inventario24;

use control_Inventario24;

-- CREACION DE TABLAS
create table categoria(
    cod_categoria int not null primary key,
    descripcion char(30) not null
); 

create table producto(
    cod_producto int not null primary key,
    descripcion char(30) not null,
    precio_unitario dec(10,2) not null,
    precio_docena dec(10,2),
    precio_mayor dec(10,2),
    existencia int not null,
    tipo_empaque char(20),
    cod_categoria int not null, index(cod_categoria),
    foreign key(cod_categoria) references categoria(cod_categoria)
);

create table proveedor(
    cod_proveedor int not null primary key,
    nit char(10) not null,
    razon_social char(30) not null,
    direccion char(30) not null,
    telefono char(10) not null,
    pagina_web char(40),
    correo_electronico char(40),
    contacto_principal char(15) not null
);

create table cliente(
    nit char(10) not null primary key,
    dpi char(20) not null,
    nombre char(30) not null,
    direccion char(30),
    telefono char(10),
    email char(20)
);

create table compra(
    num_documento int not null primary key,
    fecha date not null,
    cod_proveedor int not null, index(cod_proveedor),
    foreign key(cod_proveedor) references proveedor(cod_proveedor),
    cod_producto int not null, index(cod_producto),
    foreign key(cod_producto) references producto(cod_producto),
    cantidad int not null,
    precio dec(10,2) not null,
    total dec(10,2) not null
);

create table factura(
    num_factura int not null primary key,
    fecha date not null,
    nit char(10) not null, index(nit),
    foreign key(nit) references cliente(nit),
    cod_producto int not null, index(cod_producto),
    foreign key(cod_producto) references producto(cod_producto),
    precio dec(10,2) not null,
    cantidad int not null,
    total_factura dec(10,2) not null
);


create table inventario(
     cod_producto int not null, 
     tipo_registro char(10) not null,
     fecha date not null,
     precio dec(10,2) not null,
     entradas int,
     salidas int,
    index(cod_producto),
    foreign key(cod_producto) references producto(cod_producto)
);


use control_inventario24;

-- INSERTAR DATOS EN TABLAS
insert into categoria (cod_categoria, descripcion) values 
(1, 'Electronica'),
(2, 'Alimentos'),
(3, 'Ropa'),
(4, 'Hogar'),
(5, 'Muebles'),
(6, 'Juguetes'),
(7, 'Libros'),
(8, 'Deportes'),
(9, 'Belleza'),
(10, 'Automotriz');

select * from categoria;

--
insert into producto (cod_producto, descripcion, precio_unitario, precio_docena, precio_mayor, existencia, tipo_empaque, cod_categoria) values 
(1, 'Televisor LCD', 500.00, 4800.00, 450.00, 20, 'Caja', 1),
(2, 'Laptop HP', 800.00, 7600.00, 750.00, 15, 'Caja', 1),
(3, 'Arroz Integral', 1.50, 18.00, 1.20, 100, 'Saco', 2),
(4, 'Camiseta Polo', 15.00, 150.00, 12.00, 50, 'Paquete', 3),
(5, 'Sofá Moderno', 300.00, NULL, 280.00, 5, 'Unidad', 4),
(6, 'Mesa de Comedor', 150.00, NULL, 140.00, 10, 'Unidad', 5),
(7, 'Muñeca de Trapo', 25.00, NULL, 20.00, 30, 'Caja', 6),
(8, 'Pelota de Fútbol', 10.00, NULL, 8.00, 25, 'Caja', 8),
(9, 'Perfume Floral', 50.00, NULL, 45.00, 10, 'Botella', 9),
(10, 'Aceite de Motor', 30.00, NULL, 28.00, 12, 'Botella', 10),
(11, 'Cámara Digital', 400.00, 3800.00, 370.00, 8, 'Caja', 1),
(12, 'Cereal Integral', 3.00, 36.00, 2.80, 60, 'Paquete', 2);

select * from producto;

-- ALTERAR LONGITUD DE COLUMNA
alter table proveedor modify column correo_electronico char(40);
alter table proveedor modify column pagina_web char(40);

insert into proveedor (cod_proveedor, nit, razon_social, direccion, telefono, pagina_web, correo_electronico, contacto_principal) values 
(1, '1234567890', 'Electro S.A.', 'Av. Siempre Viva 123', '1234567890', 'www.electrosa.com', 'info@electrosa.com', 'Juan Pérez'),
(2, '0987654321', 'Alimentos Deliciosos', 'Calle Falsa 456', '0987654321', 'www.alimentosdeliciosos.com', 'contacto@alimentosdeliciosos.com', 'María López'),
(3, '1122334455', 'Ropa y Estilo', 'Boulevard Central 789', '1122334455', 'www.ropayestilo.com', 'ventas@ropayestilo.com', 'Carlos Ruiz'),
(4, '2233445566', 'Muebles Modernos', 'Calle de los Muebles 321', '2233445566', 'www.mueblesmodernos.com', 'info@mueblesmodernos.com', 'Ana Torres'),
(5, '3344556677', 'Juguetes Fantásticos', 'Calle de los Juguetes 654', '3344556677', 'www.juguetesfantasticos.com', 'ventas@juguetesfantasticos.com', 'Luis Martínez');

select * from proveedor;

-- ALTERAR LONGITUD DE COLUMNA
alter table cliente modify column email char(40);

insert into cliente (nit, dpi, nombre, direccion, telefono, email) values 
('1234567890', '1234567890123', 'Juan Pérez', 'Calle 1', '1234567890', 'juanperez@email.com'),
('0987654321', '0987654321098', 'María López', 'Calle 2', '0987654321', 'marialopez@email.com'),
('1122334455', '1122334455112', 'Carlos Ruiz', 'Calle 3', '1122334455', 'carlosruiz@email.com'),
('2233445566', '2233445566222', 'Ana Torres', 'Calle 4', '2233445566', 'anatorres@email.com'),
('3344556677', '3344556677333', 'Luis Martínez', 'Calle 5', '3344556677', 'luismartinez@email.com');

select * from cliente;

--
insert into compra (num_documento, fecha, cod_proveedor, cod_producto, cantidad, precio, total) values 
(1, '2024-01-01', 1, 1, 5, 500.00, 2500.00),
(2, '2024-01-02', 2, 3, 20, 1.50, 30.00),
(3, '2024-01-03', 3, 4, 10, 15.00, 150.00),
(4, '2024-01-04', 4, 5, 2, 300.00, 600.00),
(5, '2024-01-05', 5, 6, 15, 25.00, 375.00);

select * from compra;

--
insert into factura (num_factura, fecha, nit, cod_producto, precio, cantidad, total_factura) values 
(1, '2024-01-11', '1234567890', 1, 500.00, 1, 500.00),
(2, '2024-01-12', '0987654321', 3, 1.50, 10, 15.00),
(3, '2024-01-13', '1122334455', 4, 15.00, 2, 30.00),
(4, '2024-01-14', '2233445566', 5, 300.00, 1, 300.00),
(5, '2024-01-15', '3344556677', 6, 25.00, 5, 125.00);

select * from factura;

--
insert into inventario (cod_producto, tipo_registro, fecha, precio, entradas, salidas) values 
(1, 'compra', '2024-01-01', 500.00, 5, 0),
(1, 'venta', '2024-01-11', 500.00, 0, 1),
(3, 'compra', '2024-01-02', 1.50, 20, 0),
(3, 'venta', '2024-01-12', 1.50, 0, 10),
(4, 'compra', '2024-01-03', 15.00, 10, 0),
(4, 'venta', '2024-01-13', 15.00, 0, 2),
(5, 'compra', '2024-01-04', 300.00, 2, 0),
(6, 'compra', '2024-01-05', 25.00, 15, 0);

select * from inventario;



-- // CONSULTAS REALIZADAS

-- PRODUCTOS MAS COSTOSOS EN ORDEN DESCENDENTE
select descripcion as producto, precio_unitario, existencia, tipo_empaque 
from producto
order by precio_unitario desc
limit 5;


-- LISTA DE PROVEEDORES CON SUS PRODUCTOS 
select * from proveedor;
select * from compra;

select pr.razon_social as proveedor, pd.descripcion as producto, pd.existencia as existencia, cp.cantidad as reabastecimiento
from proveedor pr
right join compra cp
on pr.cod_proveedor = cp.cod_proveedor
left join producto pd
on cp.cod_producto = pd.cod_producto
order by proveedor, producto asc;


-- LISTA DE PRODUCTOS CON NIVEL BAJO DE EXISTENCIA
select descripcion as producto, existencia
from producto
where existencia < 15
order by precio_unitario desc;



-- EJEMPLOS DE SENTENCIAS SQL
insert into cliente values('2020144','212150502625','Omar Torres','12 calle 12-45 zona 9','54440210','Otorres@gmail.com');
select * from cliente where nit = '2020144';

update cliente set telefono = '55454545'
where nit = '2020144';

delete from producto 
where cod_producto = 11;

select * from producto 
where cod_producto = 11;

