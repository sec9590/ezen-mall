# MySQL 5.7 and HeidiSQL

use ezen;

# create customer table
create table customers (
  c_id int unsigned not null auto_increment,
  c_name varchar(10) not null,
  c_password char(60) binary not null,
  c_email varchar(20) not null,
  c_tel varchar(16),
  primary key(c_id)
) auto_increment=10001 default charset=utf8;

# create product table
create table products (
  p_id int unsigned not null auto_increment,
  p_name varchar(20) not null,
  p_unitPrice int default 0,
  p_imgName varchar(80),
  p_description varchar(256),
  primary key(p_id)
) auto_increment=30001 default charset=utf8;

# create administator table (not used)
create table admins (
  a_id int unsigned not null auto_increment,
  a_name varchar(10) not null,
  a_password char(60) binary not null,
  a_dept varchar(20) not null,
  a_tel varchar(16),
  primary key(a_id)
) auto_increment=90001 default charset=utf8;

# create order table
create table orders (
  o_id int unsigned not null auto_increment,
  o_customerId int unsigned not null,
  o_date datetime not null default current_timestamp,
  o_price int default 0,
  primary key(o_id),
  foreign key(o_customerId) references customers(c_id)
) auto_increment=50001 default charset=utf8;

# create sold_product table 
create table sold_products (
  s_orderId int unsigned not null,
  s_productId int unsigned not null,
  s_quantity int default 0,
  primary key(s_orderId, s_productId),
  foreign key(s_orderId) references orders(o_id),
  foreign key(s_productId) references products(p_id)
);
