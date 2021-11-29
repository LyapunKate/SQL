SET TRANSACTION ISOLATION LEVEL READ COMMITTED

--������� ������ ��� READ UNCOMMITED
BEGIN TRANSACTION -- 2
UPDATE person SET person.surname = '�������' -- 4 
WHERE person.person_id = 1
ROLLBACK --6







--���������� ��������� ��� READ UNCOMMITED
SET LOCK_TIMEOUT -1
BEGIN TRANSACTION --1
UPDATE person SET person.surname = '�������' --3
WHERE person.person_id = 1

COMMIT --4


select * from person where person.person_id = 1;


update person set person.surname = '�������'
where person.person_id = 1

select * from person where person.person_id = 1

-- ��� READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

--������� ������
BEGIN TRANSACTION --2 
UPDATE person SET person.surname = '�������' --4
WHERE person.person_id = 1
ROLLBACK --6

--��������������� ������
BEGIN TRANSACTION --2
UPDATE person SET person.surname = '�������' --4
WHERE person.person_id = 1
COMMIT--������� �������� � ������� � ������� ����������
--�� �������� ���������������� ������ ��������� �� ������
--������ ��������


update person set person.surname = '�������'
where person.person_id = 1

--��� REPEATABLE READ

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

--��������������� ������
BEGIN TRANSACTION --2
UPDATE person SET person.surname = '�������' --4
WHERE person.person_id = 1
COMMIT--����� ����� ���������� ���������� 1, �� ����� �����
--������� ������ �������� ����������� � ���������� 1, �� 
--������ �������� ����������� �� ������ ������ ��������


--������

BEGIN TRANSACTION --2

INSERT INTO PERSON VALUES --4
('������BY','����Y','��Y�������',2,
'04/10/1956', 'kad.gmail.com', 
'71(2233)629-89-30', 6)
--������� ���������� � ������� ������ � ������� 
--�� �������� ������ ��������� �� ������ ������ ��������
COMMIT



--��� SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

--������

BEGIN TRANSACTION --2

INSERT INTO PERSON VALUES --4
('������BYI','����Y','��Y�������',2,
'04/10/1956', 'kad.gmail.com', 
'71(2233)629-89-30', 6)
--����� ����� ��������� ���������� ���������� 1, �� ������
--�������� �� ������ ������ ��������
COMMIT
--����� ���������� ���������� 1, ��� ���������� ������� 
--���������� � ������� �������� � �������

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE



