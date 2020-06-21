-- 游标
-- 将total with tax单独放入一个表中
delimiter $$
drop procedure if exists prosessorders$$

create procedure prosessorders()
begin
	
    -- 声明一个boolen变量，用于游标终止循环
    declare done boolean default 0;
	-- 声明一个变量存储total
    declare total decimal(8,2);
    -- 声明一个变量从游标每次取值
    declare ordernum int;
    
	-- 声明个游标
    declare ordernums cursor
    for
    select order_num from orders;
    -- declare continue handler
    -- declare continue handler for sqlstate '02000' set done=1;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1; 
    
    -- 创建一个表，保存totals
    drop table if exists ordertotals;
    create table if not exists ordertotals
    (order_num int,total decimal(8,2));
    
    -- 打开游标
    open ordernums;

    -- loop through all the row
    repeat
		fetch ordernums into ordernum;
        
        if !done then
			-- 根据order_num,从orderitems中获取totals
			call ordertotal(ordernum,1,total);
			
			-- 把计算出来的结果，插入表中
			insert into ordertotals(order_num,total)
			values(ordernum,total);
		end if;
	until done end repeat;

    -- 关闭游标
    close ordernums;
end$$
delimiter ;

call prosessorders();
select * from ordertotals;--  order by order_num;