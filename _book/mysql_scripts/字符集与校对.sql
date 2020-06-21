show create database crashcourse;

-- 查看所支持的字符集完整列表
show character set;

-- 所支持校对的完整列表
show collation;

-- 所用的字符集和校对
-- 区分大小写（由_cs表示），不区分大小写（由_ci表示）。
show variables like 'character%';
show variables like 'collation%';

-- 创建表的时候指定字符集和校对
-- utf8字符，不区分大小写
create table mytable(num int,name char(20))
default character set utf8 collate utf8_general_ci;
show create table mytable;

-- 排序的时候，暂时区分大小写
-- 建表的时候，没有设置字符集，使用的是默认的字符集
show create table customers; 
select * from customers
order by cust_name collate 