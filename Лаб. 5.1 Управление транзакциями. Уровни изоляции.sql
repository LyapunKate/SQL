


--���������� ��������� ��� READ UNCOMMITED
BEGIN TRANSACTION --1
UPDATE person SET person.surname = '�������' --2
WHERE person.person_id=1

COMMIT --5

select * from person where person.person_id = 1;

-- ��� READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

--������� ������
BEGIN TRANSACTION --1
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --3
--���������� ������������ ��������
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --5
--����� ����� ���������� ���������� ������ ����������,
--�� � ����������� ���� ���� ������� ���������, �������
--��� �� �������������
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --7
--����� �������������� ��������, �� ������ ���������� 
--���� ��������, �������������, �� ��������� �
--��������������� ���������
COMMIT TRANSACTION

--��������������� ������
BEGIN TRANSACTION --1
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --3
--���������� ������������ ��������

SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --5
--���������� ��������, ��������� ����������� 2, �� ��� ��� 
--������� �����������
COMMIT

--��� REPEATABLE READ

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

--��������������� ������
BEGIN TRANSACTION --1
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --3
--���������� ������������ ��������

SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --5
--���������� ������������ �������� (��� ��� �� ���� 
--�������� ����������� 2)
COMMIT

--������
SET TRANSACTION ISOLATION LEVEL 
REPEATABLE READ
BEGIN TRANSACTION --1
SELECT * FROM PERSON --3
WHERE PERSON.PERSON_ID > 28
--���������� ������������ ��������

SELECT * FROM PERSON --5
WHERE PERSON.PERSON_ID > 28
--���������� �������� � ������ ��������, ��������� 
--� ������� � ���������� 2
COMMIT

--��� SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

--������
BEGIN TRANSACTION --1
SELECT * FROM PERSON --3
WHERE PERSON.PERSON_ID > 28
--���������� ������������ ��������

SELECT * FROM PERSON --5
WHERE PERSON.PERSON_ID > 28
--���������� ������������ ��������, �� ���������� 
--����������� 2, �� ��� ��� �� �����������
COMMIT


if (@@error <> 0) rollback
COMMIT

--������ ���������� ��������� ��������, ���������� �������� ��� �����������, �� 
--����� ���������� �� ���������
--���� ���������� ��������� ����������� �� �����, � ���� ��� �� commit

--���� ���������� �� read uncommitted select ������������� ������ 
--�����������, ����� read uncomitted select ��������������

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT
