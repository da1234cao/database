-- 触发器

-- insert触发器
create trigger insert_trigger
after insert on orders
for each row
select new.order_date into @tmp;

-- 验证insert触发器
insert into orders(order_date,cust_id) values(now(),10001);
select @tmp;

-- 查看触发器
show triggers;

-- 删除Insert触发器
drop trigger insert_trigger;

-- -----------------------------------------

-- delete 触发器
-- 准备工作创建一个表
create table order_delete_items(order_num int,order_date datetime,cust_id int);
delimiter $$
create trigger delete_trigger before delete on orders
for each row
begin
	insert into order_delete_items(order_num,order_date,cust_id)
    values(old.order_num,old.order_date,old.cust_id);
end$$
delimiter ;

-- 验证删除触发器
-- 由于主键外键的约束
show variables like 'sql_safe%';
set sql_safe_updates=0;
-- select order_num from orders where cust_id=10003;
delete from orderitems
	where order_num in(select order_num from orders where cust_id=10003); 
delete from orders where cust_id=10003;
set sql_safe_updates=1;

-- 删除触发器
drop trigger delete_trigger;

-- ------------------------
-- update触发器
create trigger update_trigger after update on orders
for each row select 'update successfully' into @tmp;

-- 测试update触发器
update orders
set order_date=now()
where order_num=20005;

select @tmp;