


--ПОТЕРЯННЫЕ ИЗМЕНЕНИЯ ДЛЯ READ UNCOMMITED
BEGIN TRANSACTION --1
UPDATE person SET person.surname = 'Иванова' --2
WHERE person.person_id=1

COMMIT --5

select * from person where person.person_id = 1;

-- ДЛЯ READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

--ГРЯЗНОЕ ЧТЕНИЕ
BEGIN TRANSACTION --1
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --3
--возвращает существующее значение
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --5
--будет ждать заверщения выполнения второй транзакции,
--тк в считываемый блок были внесены изменения, которые
--ещё не зафиксированы
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --7
--вернёт первоначальное значение, тк вторая транзакция 
--была откачена, следовательно, всё вернулось к
--первоначальному состоянию
COMMIT TRANSACTION

--НЕПОВТОРЯЮЩЕЕСЯ ЧТЕНИЕ
BEGIN TRANSACTION --1
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --3
--возвращает существующее значение

SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --5
--возвращает значение, измененно транзакцией 2, тк она она 
--успешно выполнилась
COMMIT

--ДЛЯ REPEATABLE READ

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

--НЕПОВТОРЯЮЩЕЕСЯ ЧТЕНИЕ
BEGIN TRANSACTION --1
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --3
--возвращает существующее значение

SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --5
--возвращает существующее значение (оно ещё не было 
--изменено транзакцией 2)
COMMIT

--ФАНТОМ
SET TRANSACTION ISOLATION LEVEL 
REPEATABLE READ
BEGIN TRANSACTION --1
SELECT * FROM PERSON --3
WHERE PERSON.PERSON_ID > 28
--возвращает существующее значение

SELECT * FROM PERSON --5
WHERE PERSON.PERSON_ID > 28
--возвращает значение с новыми строками, внесёнными 
--в таблицу в транзакции 2
COMMIT

--ДЛЯ SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

--ФАНТОМ
BEGIN TRANSACTION --1
SELECT * FROM PERSON --3
WHERE PERSON.PERSON_ID > 28
--возвращает существующее значение

SELECT * FROM PERSON --5
WHERE PERSON.PERSON_ID > 28
--возвращает существующее значение, не измененное 
--транзакцией 2, тк она ещё не выполнилась
COMMIT


if (@@error <> 0) rollback
COMMIT

--внутри транзакции несколько инсертов, нарушающих праймари кий ограничение, то 
--откат транзакции не произойдёт
--если происходит нарушение целостности то откат, а если нет то commit

--одна транзакции на read uncommitted select заблокировать второй 
--транзакцией, чтобы read uncomitted select заблокировался

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT
