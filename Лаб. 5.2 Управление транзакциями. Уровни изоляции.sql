SET TRANSACTION ISOLATION LEVEL READ COMMITTED

--ГРЯЗНОЕ ЧТЕНИЕ ДЛЯ READ UNCOMMITED
BEGIN TRANSACTION -- 2
UPDATE person SET person.surname = 'Петрова' -- 4 
WHERE person.person_id = 1
ROLLBACK --6







--ПОТЕРЯННЫЕ ИЗМЕНЕНИЯ ДЛЯ READ UNCOMMITED
SET LOCK_TIMEOUT -1
BEGIN TRANSACTION --1
UPDATE person SET person.surname = 'Петрова' --3
WHERE person.person_id = 1

COMMIT --4


select * from person where person.person_id = 1;


update person set person.surname = 'Терёшина'
where person.person_id = 1

select * from person where person.person_id = 1

-- ДЛЯ READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

--ГРЯЗНОЕ ЧТЕНИЕ
BEGIN TRANSACTION --2 
UPDATE person SET person.surname = 'Петрова' --4
WHERE person.person_id = 1
ROLLBACK --6

--НЕПОВТОРЯЮЩЕЕСЯ ЧТЕНИЕ
BEGIN TRANSACTION --2
UPDATE person SET person.surname = 'Петрова' --4
WHERE person.person_id = 1
COMMIT--изменит значение в таблице и успешно выполнится
--тк аномалия неповторяющегося чтения разрешена на данном
--уровне изоляции


update person set person.surname = 'Терёшина'
where person.person_id = 1

--ДЛЯ REPEATABLE READ

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

--НЕПОВТОРЯЮЩЕЕСЯ ЧТЕНИЕ
BEGIN TRANSACTION --2
UPDATE person SET person.surname = 'Петрова' --4
WHERE person.person_id = 1
COMMIT--будет ждать завершения транзакции 1, тк иначе будут
--изменеы данные повторно считываемые в транзакции 1, те 
--данная аномалия блокируется на данном уровне изоляции


--ФАНТОМ

BEGIN TRANSACTION --2

INSERT INTO PERSON VALUES --4
('КадцынBY','ИльяY','ЕфYремович',2,
'04/10/1956', 'kad.gmail.com', 
'71(2233)629-89-30', 6)
--успешно выполнится и добавит строки в таблицу 
--тк аномалия фантом разрешена на данном уровне изоляции
COMMIT



--ДЛЯ SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

--ФАНТОМ

BEGIN TRANSACTION --2

INSERT INTO PERSON VALUES --4
('КадцынBYI','ИльяY','ЕфYремович',2,
'04/10/1956', 'kad.gmail.com', 
'71(2233)629-89-30', 6)
--будет ждать окончания выполнения транзакции 1, тк фантом
--запрещён на данном уровне изоляции
COMMIT
--после завершения транзакции 1, эта транзакция успешно 
--выполнится и добавит значение в таблицу

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE



