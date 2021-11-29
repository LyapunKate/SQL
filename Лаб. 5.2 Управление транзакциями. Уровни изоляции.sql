SET TRANSACTION ISOLATION LEVEL READ COMMITTED

--√–я«Ќќ≈ „“≈Ќ»≈ ƒЋя READ UNCOMMITED
BEGIN TRANSACTION -- 2
UPDATE person SET person.surname = 'ѕетрова' -- 4 
WHERE person.person_id = 1
ROLLBACK --6







--ѕќ“≈–яЌЌџ≈ »«ћ≈Ќ≈Ќ»я ƒЋя READ UNCOMMITED
SET LOCK_TIMEOUT -1
BEGIN TRANSACTION --1
UPDATE person SET person.surname = 'ѕетрова' --3
WHERE person.person_id = 1

COMMIT --4


select * from person where person.person_id = 1;


update person set person.surname = '“ерЄшина'
where person.person_id = 1

select * from person where person.person_id = 1

-- ƒЋя READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

--√–я«Ќќ≈ „“≈Ќ»≈
BEGIN TRANSACTION --2 
UPDATE person SET person.surname = 'ѕетрова' --4
WHERE person.person_id = 1
ROLLBACK --6

--Ќ≈ѕќ¬“ќ–яёў≈≈—я „“≈Ќ»≈
BEGIN TRANSACTION --2
UPDATE person SET person.surname = 'ѕетрова' --4
WHERE person.person_id = 1
COMMIT--изменит значение в таблице и успешно выполнитс€
--тк аномали€ неповтор€ющегос€ чтени€ разрешена на данном
--уровне изол€ции


update person set person.surname = '“ерЄшина'
where person.person_id = 1

--ƒЋя REPEATABLE READ

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

--Ќ≈ѕќ¬“ќ–яёў≈≈—я „“≈Ќ»≈
BEGIN TRANSACTION --2
UPDATE person SET person.surname = 'ѕетрова' --4
WHERE person.person_id = 1
COMMIT--будет ждать завершени€ транзакции 1, тк иначе будут
--изменеы данные повторно считываемые в транзакции 1, те 
--данна€ аномали€ блокируетс€ на данном уровне изол€ции


--‘јЌ“ќћ

BEGIN TRANSACTION --2

INSERT INTO PERSON VALUES --4
(' адцынBY','»ль€Y','≈фYремович',2,
'04/10/1956', 'kad.gmail.com', 
'71(2233)629-89-30', 6)
--успешно выполнитс€ и добавит строки в таблицу 
--тк аномали€ фантом разрешена на данном уровне изол€ции
COMMIT



--ƒЋя SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

--‘јЌ“ќћ

BEGIN TRANSACTION --2

INSERT INTO PERSON VALUES --4
(' адцынBYI','»ль€Y','≈фYремович',2,
'04/10/1956', 'kad.gmail.com', 
'71(2233)629-89-30', 6)
--будет ждать окончани€ выполнени€ транзакции 1, тк фантом
--запрещЄн на данном уровне изол€ции
COMMIT
--после завершени€ транзакции 1, эта транзакци€ успешно 
--выполнитс€ и добавит значение в таблицу

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE



