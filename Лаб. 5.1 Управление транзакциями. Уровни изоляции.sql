


--ѕќ“≈–яЌЌџ≈ »«ћ≈Ќ≈Ќ»я ƒЋя READ UNCOMMITED
BEGIN TRANSACTION --1
UPDATE person SET person.surname = '»ванова' --2
WHERE person.person_id=1

COMMIT --5

select * from person where person.person_id = 1;

-- ƒЋя READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

--√–я«Ќќ≈ „“≈Ќ»≈
BEGIN TRANSACTION --1
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --3
--возвращает существующее значение
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --5
--будет ждать заверщени€ выполнени€ второй транзакции,
--тк в считываемый блок были внесены изменени€, которые
--ещЄ не зафиксированы
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --7
--вернЄт первоначальное значение, тк втора€ транзакци€ 
--была откачена, следовательно, всЄ вернулось к
--первоначальному состо€нию
COMMIT TRANSACTION

--Ќ≈ѕќ¬“ќ–яёў≈≈—я „“≈Ќ»≈
BEGIN TRANSACTION --1
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --3
--возвращает существующее значение

SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --5
--возвращает значение, измененно транзакцией 2, тк она она 
--успешно выполнилась
COMMIT

--ƒЋя REPEATABLE READ

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

--Ќ≈ѕќ¬“ќ–яёў≈≈—я „“≈Ќ»≈
BEGIN TRANSACTION --1
SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --3
--возвращает существующее значение

SELECT * FROM PERSON WHERE PERSON.PERSON_ID = 1 --5
--возвращает существующее значение (оно ещЄ не было 
--изменено транзакцией 2)
COMMIT

--‘јЌ“ќћ
SET TRANSACTION ISOLATION LEVEL 
REPEATABLE READ
BEGIN TRANSACTION --1
SELECT * FROM PERSON --3
WHERE PERSON.PERSON_ID > 28
--возвращает существующее значение

SELECT * FROM PERSON --5
WHERE PERSON.PERSON_ID > 28
--возвращает значение с новыми строками, внесЄнными 
--в таблицу в транзакции 2
COMMIT

--ƒЋя SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

--‘јЌ“ќћ
BEGIN TRANSACTION --1
SELECT * FROM PERSON --3
WHERE PERSON.PERSON_ID > 28
--возвращает существующее значение

SELECT * FROM PERSON --5
WHERE PERSON.PERSON_ID > 28
--возвращает существующее значение, не измененное 
--транзакцией 2, тк она ещЄ не выполнилась
COMMIT


if (@@error <> 0) rollback
COMMIT

--внутри транзакции несколько инсертов, нарушающих праймари кий ограничение, то 
--откат транзакции не произойдЄт
--если происходит нарушение целостности то откат, а если нет то commit

--одна транзакции на read uncommitted select заблокировать второй 
--транзакцией, чтобы read uncomitted select заблокировалс€

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT
