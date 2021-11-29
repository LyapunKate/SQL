CREATE LOGIN login_test1 WITH PASSWORD = '1234'
CREATE USER user_test1 FOR LOGIN login_test1


--1) Присвоить новому пользователю права SELECT, INSERT, UPDATE в полном объеме на одну таблицу
GRANT INSERT, SELECT, UPDATE ON city TO user_test1
go

--2) Для одной таблицы новому пользователю присвоим права SELECT и UPDATE только избранных столбцов.
GRANT SELECT, UPDATE ON [TYPE_OF_GAME](min_duration_) TO user_test1
go

--3) Для одной таблицы новому пользователю присвоим только право SELECT.
GRANT SELECT ON person TO user_test1
go

--4) Присвоить новому пользователю право доступа (SELECT) к представлению, 
--созданному в лабораторной работе №5.
GRANT SELECT ON task_5 TO user_test1
go

--5) Cоздать стандартную роль уровня базы данных, присвоить ей право доступа 
--(UPDATE на некоторые столбцы) к представлению, 
--созданному в лабораторной работе №4, назначить новому пользователю созданную роль

/*create view task_6 as
(
select surname, name_
from person where birth_date > '01/01/1950'
);*/ -- создаём представление, на которое хотим дать доступ


CREATE ROLE role_test1
GRANT SELECT, UPDATE ON  task_6 (name_, surname) TO role_test1

alter role role_test1 add member [user_test1]
go


разрешить разработчикам добавлять изменять объекты в схеме

а приложению разррещить select/insert/update/delete 



CREATE LOGIN login_test2 WITH PASSWORD = '12345'
CREATE USER user_test2 FOR LOGIN login_test2

grant  

--Есть два логина приложение и разработчики, приложению нужно дать разрешение читать и писать любые объекты, 
--созданные в этой схеме, а разработчику дать право добавлять, изменять объекты в схеме
--"при минимальных потерях и чтобы больше не тревожили"

--проблема в том, что приложению надо дать доступ на объекты, которые только будут созданы

CREATE LOGIN login_test3 WITH PASSWORD = '123456'
CREATE USER sysadm FOR LOGIN login_test3 

