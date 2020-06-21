-- 简单的写一个没啥意义的事务处理

select * from customers where cust_id=10001;

set autocommit=0;   -- 禁止默认提交
start transaction;  -- 标识事务的开始
savepoint update1;  -- 使用保留点
update customers 
set cust_name='dacao'
where cust_id='10001';

select * from customers where cust_id=10001;

rollback to update1; -- 使用保留点
commit;           -- 提交，这里提交了个毛线
set autocommit=1; -- 启用默认提交

select * from customers where cust_id=10001;