这两天，接连遇到数据库。在脑子里转了一遍，好像现在仅仅会表的增删改查。。

当时没有好好学，现在来补补。以前多少学过些，所以过得比较快。

阅读书籍：《Mysql必知必会》chapter1~3。

**思路：安装数据库工具+创建数据库+创建用户+授权**

但是可能好些地方不合适。因为目前好多都不知道。等这本书看到 28节安全管理 的时候，回头修改。

回头我来总结这段：

安装数据库(DBMS+client)+创建数据库(创建/销毁)+创建用户(创建/销毁/用户查询/密码修改)+授权(权限查看/修改)+连接+等

注：文章的最后放了一些不相关的参考文章。那些并非这篇文章的参考文章。而是阅读1~3节中，电子版笔记中涉及到的一些文章，作为扩展阅读，列出在后。参考中的有些内容，我也并非都知道。只要深度能够畅通的阅读《Mysql必知必会》就好。

---

<br>

[toc]

# 数据库的安装

数据库（database） 保存有组织的数据的容器（通常是一个文件或一组文件）。

:alarm_clock:

> **误用导致混淆** 人们通常用数据库这个术语来代表他们使用的数据库软件。这是不正确的，它是引起混淆的根源。确切地说，数据库软件应称为DBMS（数据库管理系统）。数据库是通过DBMS创建和操纵的容器。数据库可以是保存在硬设备上的文件，但也可以不是。在很大程度上说，数据库究竟是文件还是别的什么东西并不重要，因为你并不直接访问数据库；你使用的是DBMS，它替你访问数据库。

我感觉没有必要在windows上安装数据库。所以下面仅是linux(ubuntu)下安装数据库。

参考：[在腾讯云 Ubuntu18.04 安装配置 MySQL 5.7（踩坑警告⚠️）](https://zhuanlan.zhihu.com/p/77765825)

**上面这篇参考文章很好。全伙了。** 但当我们带着思考去阅读这篇文章的时候，发现它任然不够好。

不够好的地方，我偷懒，没有去查阅资料。:smiley:

我下面还是赘述下。但不会提及理由。

```shell
#安装
$ sudo apt-get install mysql-server
$ sudo apt-get install mysql-client
$ systemctl status mysql
$ sudo systemctl enable mysql

#配置root用户
$ mysql -u debian-sys-maint -p
mysql> update mysql.user set authentication_string=password('password') where user='root'and Host = 'localhost';
mysql> UPDATE user SET plugin='mysql_native_password' WHERE User='root';
mysql> FLUSH PRIVILEGES;
```

客户端的使用工具，我暂时用的是命令行。图形化以前用过14天的navicat 。我去看了下收费，好贵。

命令行，先凑活着吧。

[MySQL Workbench使用教程](http://c.biancheng.net/view/2625.html)

<br>

<br>

# 数据库管理

```shell
#登录root
mysql -u root -p

#创建数据库
mysql> CREATE DAtABASE crashcourse;

#查看是否创建成功
mysql> show databases;
```

<br>

<br>

# 用户管理

参考：[MYSQL的创建用户，授权用户，删除用户，查看用户](https://blog.csdn.net/u014453898/article/details/55064312)

```shell
#创建用户
mysql> CREATE USER  'dacao'@'%'  IDENTIFIED BY '12345678'；

#查看是否创建成功
mysql> show databases;
mysql> use mysql;
mysql> show tables;
mysql> desc user;
mysql> select User from user;
```

<br>

<br>

# 权限管理

```shell
#授权
GRANT ALL ON crashcourse.*  TO 'dacao'@'%' 
```

<br>
<br>

# 参考文章

[在腾讯云 Ubuntu18.04 安装配置 MySQL 5.7（踩坑警告⚠️）](https://zhuanlan.zhihu.com/p/77765825)

[MySQL Workbench使用教程](http://c.biancheng.net/view/2625.html)

[MYSQL的创建用户，授权用户，删除用户，查看用户](https://blog.csdn.net/u014453898/article/details/55064312)

[MySQL 5.7 INFORMATION_SCHEMA 详解](https://www.cnblogs.com/waynechou/p/information_schema.html)

[浅谈数据库主键策略](https://www.liaoxuefeng.com/article/1100985514586848)

[介绍 9 款 MySQL 常见的图形化工具，第三款我用了 10 年](https://zhuanlan.zhihu.com/p/93239228)

[MySQL语句之describe，explain，help，use](https://blog.csdn.net/jesseyoung/article/details/38257727)