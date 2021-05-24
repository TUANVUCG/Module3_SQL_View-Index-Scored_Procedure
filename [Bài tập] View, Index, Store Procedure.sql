create database products;

use products;

create table products(
id int primary key,
productCode varchar(50),
productName varchar(50),
productPrice float,
productAmount int,
productDescription varchar(50),
productStatus bit);

insert into products
values (1,'a1','may giat',1000,14,'toshiba',1),
(2,'b2','dieu hoa',1200,10,'sam sung',0),
(3,'c3','ti vi',1129,8,'LG',1),
(4,'d4','may tinh',3200,5,'dell',0);


-- Tạo Unique Index trên bảng Products (sử dụng cột productCode để tạo chỉ mục)
alter table products
add index productCode_index(productCode);
explain select *
from products 
where productCode = 'a1';
-- Tạo Composite Index trên bảng Products (sử dụng 2 cột productName và productPrice)
alter table products
add index productCode_Id(productCode, id);
-- Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào
explain select * 
from products
where productCode = 'a1' and id = 1;
-- So sánh câu truy vấn trước và sau khi tạo index

-- Tạo view lấy về các thông tin: productCode, productName, productPrice, productStatus từ bảng products.
create view findProductInfo AS
select P.productCode , P.productName,P.productPrice, P.productStatus
from products P;
-- Tiến hành sửa đổi view
set sql_safe_updates = 0;
update findProductInfo
set productName = 'iphone'
where productName = 'ti vi';

-- Tiến hành xoá view
drop view findProductInfo;

-- Tạo store procedure lấy tất cả thông tin của tất cả các sản phẩm trong bảng product
drop procedure findProductInfo;
delimiter //
create PROCEDURE findProductInfo()
begin 
select * 
from products;
end // 
delimiter *;
-- Tạo store procedure thêm một sản phẩm mới
delimiter //
call findProductInfo;
create procedure addNewProduct()
begin
insert into products
value (5,'e5','tu lanh',9383,3,'demacia',1);
end //
delimiter ;

-- Tạo store procedure sửa thông tin sản phẩm theo id
drop procedure editById;
delimiter //
create procedure editById(IN id INT)
begin 
if(exists(select id from products WHERE products.id = id)) then 
UPDATE products
set productName = 'quat'
where products.id = id;
else 
select concat ("khong tim thay ma san pham co id la ", id) AS Message;
end if;
end // 
delimiter ;
call editById(100);

drop procedure editByIdNotIf;
delimiter //
create procedure editByIdNotIf(IN id INT)
begin 
UPDATE products
set productName = 'quat'
where products.id = id;
call findProductInfo;
end // 
delimiter ;
call editByIdNotIf(100);

-- Tạo store procedure xoá sản phẩm theo id
drop procedure removeById;
delimiter //
create procedure removeById(IN id INT)
begin 
if(exists(select id from products WHERE products.id = id)) then 
DELETE from products
where products.id = id;
else 
select concat ("khong tim thay ma san pham co id la ", id) AS Message;
end if;
call findProductInfo;
end // 
delimiter ;
call removeById(1);
