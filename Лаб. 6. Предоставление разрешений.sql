/*CREATE LOGIN login_test1 WITH PASSWORD = '1234'
CREATE USER user_test1 FOR LOGIN login_test1*/

--1
execute as user = 'user_test1'
BEGIN TRAN
select * from city
go
update city set city = 'Moscow' WHERE city = 'Москва'
go
insert into city values ('Иваново')
ROLLBACK
revert
--2
execute as user = 'user_test1'
begin tran
select min_duration_ from TYPE_OF_GAME
go

update TYPE_OF_GAME set min_duration_ = 15 where min_duration_ = 10
go
rollback
revert

--3
execute as user = 'user_test1'
select * from person
go

revert

--4
execute as user = 'user_test1'
select * from task_5
go

revert

--5
execute as user = 'user_test1'
begin tran
select * from task_6
update  task_6 set name_ = 'Ваня' where name_ = 'Иван'
go
rollback

revert