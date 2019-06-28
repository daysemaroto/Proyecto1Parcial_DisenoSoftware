
drop database tecnoimport;
create database tecnoimport;
use tecnoimport;


CREATE USER ‘usuario’@'%' IDENTIFIED BY 'contraseña';
GRANT REPLICATION SLAVE ON *.* TO 'usuario'@'%'  ;

drop table if exists cliente;
create table cliente(
  nombre varchar(50),
  apellido varchar(50),
  idCliente int(10),
  edad varchar(10),
  telefono varchar(45),
  email varchar(45),
  direccion varchar(45), 
primary key (idCliente)
);


drop table if exists vendedor;
create table vendedor(
  nombre varchar(50),
  apellido varchar(50),
  idVendedor int(10),
  edad varchar(10),
  telefono varchar(45),
  email varchar(45),
  direccion varchar(45),
  idCliente int(10),
primary key (idVendedor),
foreign key(idCliente) references cliente(idCliente)
);


drop table if exists matriz;
create table matriz(
  nombre varchar(50),
  idMatriz int(10),
  telefono varchar(45),
  direccion varchar(45),
  primary key (idMatriz)
);

drop table if exists sucursal;
create table sucursal(
  nombre varchar(50),
  idSucursal int(10),
  telefono varchar(45),
  direccion varchar(45),
  primary key (idSucursal)
);


drop table if exists bodega;
create table bodega(
   nombre varchar(50),
   idBodega int(10),
   telefono varchar(45),
   direccion varchar(45),
   idTipolocal int(10),
	primary key (idBodega)
);


drop table if exists administrador;
create table administrador(
   nombre varchar(50),
   apellido varchar(50),
   idAdmin int(10),
   edad varchar(10),
   telefono varchar(45),
   email varchar(45),
   direccion varchar(45),
   idMatriz int(10),
   idSucursal int(10),
   primary key (idAdmin),
   foreign key(idMatriz) references matriz(idMatriz),
   foreign key(idSucursal) references sucursal(idSucursal)
);

drop table if exists gerente;
create table gerente(
	nombre varchar(50),
	apellido varchar(50),
	idGerente int(10),
    idAdmin int(10),
    idMatriz int(10),
    idSucursal int(10),
	primary key (idGerente),
    foreign key(idMatriz) references matriz(idMatriz),
    foreign key(idSucursal) references sucursal(idSucursal)
);

drop table if exists jefebodega;
create table jefebodega(
  nombre varchar(50),
  apellido varchar(50),
  idJefe varchar(15),
  edad varchar(10),
  telefono varchar(45),
  email varchar(45),
  direccion varchar(45),
  idBodega int(10),
primary key (idJefe),
foreign key(idBodega) references bodega(idBodega)
);


drop table if exists articulo;
create table articulo(
	idArticulo int(5),
	nombre varchar(50),
	categoria varchar(50),
	descripcion varchar(500),
	precio float(5),
	tiempoMaximoEntrega float(2),
	primary key (idArticulo)
);

drop table if exists pedido;
create table pedido(
	estado varchar(10),
	costoTotal float(5),
	FechaPedido DATETIME,
	idCliente int(10),
	idVendedor int(10),
	idPedido int(5),
primary key (idPedido),
foreign key(idVendedor) references vendedor(idVendedor),
foreign key(idCliente) references cliente(idCliente)
);

drop table if exists factura_electronica;
create table factura_electronica(
	idFactura_electronica int(5),
    idCliente int(10),
	idPedido int(4),
	fechaRecibido DATETIME,
primary key (idFactura_electronica),
foreign key(idCliente) references cliente(idCliente),
foreign key(idPedido) references pedido(idPedido)
);


drop table if exists formaPago;
create table formaPago(
	idFormaPago int(5),
	formaPago varchar(50),
primary key(idFormaPago)
);

drop table if exists venta;
create table venta(
	idVenta int(5),
    idCliente int(10),
	idFormaPago int(5),
	idPedido int(4),
	fechaRecibido DATETIME,
primary key (idVenta),
foreign key(idFormaPago) references formaPago(idFormaPago),
foreign key(idCliente) references cliente(idCliente),
foreign key(idPedido) references pedido(idPedido)
);


drop table if exists clienteXformaPago;
create table clienteXformaPago(
	idFormaPago int(5),
	monto int(5),
	idCliente int(10),
foreign key(idFormaPago) references formaPago(idFormaPago),
foreign key(idCliente) references cliente(idCliente)
);

drop table if exists articuloXvendedor;
create table articuloXvendedor(
	idVendedor int(5),
	idArticulo int(5),
foreign key(idArticulo) references articulo(idArticulo),
foreign key(idVendedor) references vendedor(idVendedor)
);

drop table if exists articuloXCliente;
create table articuloXCliente(
	idCliente int(5),
	idArticulo int(5),
foreign key(idArticulo) references articulo(idArticulo),
foreign key(idCliente) references vendedor(idCliente)
);

drop table if exists articuloXpedido;
create table articuloXpedido(
	idPedido int(5),
	idArticulo int(5),
foreign key(idArticulo) references articulo(idArticulo),
foreign key(idPedido) references pedido(idPedido)
);







