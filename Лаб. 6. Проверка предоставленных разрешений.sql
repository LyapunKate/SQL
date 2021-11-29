CREATE LOGIN login_test1 WITH PASSWORD = '1234'
CREATE USER user_test1 FOR LOGIN login_test1


--1) ��������� ������ ������������ ����� SELECT, INSERT, UPDATE � ������ ������ �� ���� �������
GRANT INSERT, SELECT, UPDATE ON city TO user_test1
go

--2) ��� ����� ������� ������ ������������ �������� ����� SELECT � UPDATE ������ ��������� ��������.
GRANT SELECT, UPDATE ON [TYPE_OF_GAME](min_duration_) TO user_test1
go

--3) ��� ����� ������� ������ ������������ �������� ������ ����� SELECT.
GRANT SELECT ON person TO user_test1
go

--4) ��������� ������ ������������ ����� ������� (SELECT) � �������������, 
--���������� � ������������ ������ �5.
GRANT SELECT ON task_5 TO user_test1
go

--5) C������ ����������� ���� ������ ���� ������, ��������� �� ����� ������� 
--(UPDATE �� ��������� �������) � �������������, 
--���������� � ������������ ������ �4, ��������� ������ ������������ ��������� ����

/*create view task_6 as
(
select surname, name_
from person where birth_date > '01/01/1950'
);*/ -- ������ �������������, �� ������� ����� ���� ������


CREATE ROLE role_test1
GRANT SELECT, UPDATE ON  task_6 (name_, surname) TO role_test1

alter role role_test1 add member [user_test1]
go


��������� ������������� ��������� �������� ������� � �����

� ���������� ���������� select/insert/update/delete 



CREATE LOGIN login_test2 WITH PASSWORD = '12345'
CREATE USER user_test2 FOR LOGIN login_test2

grant  

--���� ��� ������ ���������� � ������������, ���������� ����� ���� ���������� ������ � ������ ����� �������, 
--��������� � ���� �����, � ������������ ���� ����� ���������, �������� ������� � �����
--"��� ����������� ������� � ����� ������ �� ���������"

--�������� � ���, ��� ���������� ���� ���� ������ �� �������, ������� ������ ����� �������

CREATE LOGIN login_test3 WITH PASSWORD = '123456'
CREATE USER sysadm FOR LOGIN login_test3 

