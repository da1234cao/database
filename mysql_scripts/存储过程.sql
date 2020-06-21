-- 存储过程
-- name:ordertotal
-- parameters: ordernum=order_num
--             taxable = 0 or 1 
--             ototal = order total varibale
DELIMITER $$
drop procedure if exists ordertotal$$

create procedure ordertotal(
	in ordernum int,
    in taxable boolean,
    out ototal decimal(8,2)
)comment 'get total variable with tax'
begin
	-- declare varibale for total
    declare total decimal(8,2);
    -- declare tax precent
    declare tax_prec int default 6;
    
    -- get total variable without tax
	select sum(quantity*item_price)
    from orderitems
    where order_num=ordernum
    into total;
    
    -- is taxable
    if taxable then
		select total+(total/100*tax_prec) into total;
	end if;
	
    -- return total with tax
    select total into ototal;
end$$
DELIMITER ;

call ordertotal(20005,1,@total);
select @total;
help ordertotal;
	

