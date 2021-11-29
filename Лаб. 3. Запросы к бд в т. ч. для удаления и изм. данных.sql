--Выбрать турнир с наибольшим количеством гроссмейстеров
SELECT top 1  COUNT(DISTINCT(PERSON.person_id)) as NUMBER, TOURNEY.name_of_tourney FROM RANG_NAME 
JOIN RANG ON RANG_NAME.rang_id = RANG.rang_id 
JOIN PERSON ON RANG.person_id = PERSON.person_id
JOIN STAGE_PERSON ON  PERSON.person_id = STAGE_PERSON.player_id
JOIN STAGE ON STAGE_PERSON.stage_id=STAGE.stage_id
JOIN TOURNEY ON STAGE.tourney_id=TOURNEY.tourney_id
WHERE rang_name = 'ГРОССМЕЙСТЕР'
GROUP BY TOURNEY.name_of_tourney
ORDER BY COUNT(DISTINCT(PERSON.person_id)) DESC

--Выбрать тех шахматистов, которые выйграли не менее двух стадий в течение турнира 
--'ПОДРАСТАЮЩИЙ ФЕРЗЬ' 

SELECT COUNT(STAGE_PERSON.player_id) AS NUMBER, PERSON.surname, PERSON.name_, PERSON.middle_name 
FROM STAGE_PERSON JOIN PERSON ON STAGE_PERSON.player_id = PERSON.person_id
WHERE STAGE_PERSON.place = 1 
GROUP BY PERSON.person_id, PERSON.surname, PERSON.name_, PERSON.middle_name
HAVING COUNT(STAGE_PERSON.player_id) >= 2
ORDER BY COUNT(STAGE_PERSON.player_id) DESC

 --Вывести, в каком городе проводился турнир, в котором все игры были типа "Блиц"

 SELECT CITY.city, TOURNEY.name_of_tourney
 FROM CITY 
 JOIN TOURNEY ON  CITY.city_id = TOURNEY.city_id
 JOIN STAGE ON  TOURNEY.tourney_id = STAGE.tourney_id
 JOIN GAME ON STAGE.stage_id = GAME.stage_id
 JOIN TYPE_OF_GAME ON GAME.type_of_game_id = TYPE_OF_GAME.type_of_game_id
 WHERE TYPE_OF_GAME.type_of_game = 'БЛИЦ'
 GROUP BY CITY.city, TOURNEY.name_of_tourney

 -- Ввести тип стадии и название турнира, в которой было максимальное количество игроков
 
 SELECT top 1 COUNT(DISTINCT(STAGE_PERSON.player_id)) as quantitu_of_players, TYPE_OF_STAGE.type_of_stage, STAGE.stage_id, TOURNEY.name_of_tourney
 FROM TYPE_OF_STAGE
 JOIN STAGE ON TYPE_OF_STAGE.type_of_stage_id = STAGE.type_of_stage_id
 JOIN STAGE_PERSON ON STAGE.stage_id = STAGE_PERSON.stage_id
 JOIN TOURNEY ON STAGE.tourney_id = TOURNEY.tourney_id
 GROUP BY  TYPE_OF_STAGE.type_of_stage, STAGE.stage_id, TOURNEY.name_of_tourney
 
 -- заменим город, записанный заглавными буквами, на город, записанный с заглавной буквы
 UPDATE CITY
 SET CITY.city = 'Москва'
 WHERE CITY.city = 'Новороссийск'

 SELECT * FROM CITY

 -- удалим строку таблицы с рангом 'IV' из таблицы RANG_NAME и выведем значения таблицы RANG,
 -- ссылающейся на таблицу RANG_NAME
 delete RANG_NAME
 where rang_id = 1
 select * from rang

-- поменяем id 'IV' ранга
DELETE RANG_NAME
WHERE rang_id = 1
SET IDENTITY_INSERT RANG_NAME ON;
   
INSERT INTO RANG_NAME (rang_id, rang_name)
VALUES (10, 'IV');

SELECT * FROM RANG_NAME

-- изменить минимальную продолжительность игры типа "рапид"
update TYPE_OF_GAME
set type_of_game.min_duration_ = 20
WHERE TYPE_OF_GAME.type_of_game = 'РАПИД'

select * from type_of_game 
 
--выбрать всех игроков, которые играли белыми в турнире 'БФ СТАНДАРТ ИНДИВИДУАЛЬНЫЙ'
SELECT PERSON.surname, PERSON.name_, PERSON.middle_name
FROM PERSON 
JOIN PLAYERS_GAMES ON PERSON.person_id = PLAYERS_GAMES.player_id
JOIN COLOR ON PLAYERS_GAMES.color_id = COLOR.color_id
JOIN GAME ON PLAYERS_GAMES.game_id = GAME.game_id
JOIN STAGE ON GAME.stage_id = STAGE.stage_id
JOIN TOURNEY ON STAGE.tourney_id = TOURNEY.tourney_id
WHERE TOURNEY.name_of_tourney = 'БФ СТАНДАРТ ИНДИВИДУАЛЬНЫЙ' AND COLOR.color = 'WHITE'
GROUP BY PERSON.surname, PERSON.name_, PERSON.middle_name

-- вывести игроков, которые играли в двух или более турнирах

SELECT count(distinct(TOURNEY.tourney_id)) as quantity_of_tourners, PERSON.surname, PERSON.name_, 
PERSON.middle_name
FROM PERSON 
JOIN STAGE_PERSON ON PERSON.person_id = STAGE_PERSON.player_id
JOIN STAGE ON STAGE_PERSON.stage_id = STAGE.stage_id
JOIN TOURNEY ON STAGE.tourney_id = TOURNEY.tourney_id
GROUP BY PERSON.surname, PERSON.name_, PERSON.middle_name
HAVING count(distinct(TOURNEY.tourney_id)) >= 2
ORDER BY PERSON.surname


-- вывести итоговую таблицу турнира 'ЧЕМПИОНАТ ДФО'
SELECT STAGE_PERSON.place, PERSON.surname, PERSON.name_, PERSON.middle_name
FROM PERSON
JOIN STAGE_PERSON ON PERSON.person_id = STAGE_PERSON.player_id
JOIN STAGE ON STAGE_PERSON.stage_id = STAGE.stage_id
JOIN TOURNEY ON STAGE.tourney_id = TOURNEY.tourney_id
WHERE TOURNEY.name_of_tourney = 'ЧЕМПИОНАТ ДФО'
GROUP BY  STAGE_PERSON.place, PERSON.surname, PERSON.name_, PERSON.middle_name

--удалить турнир, который проходил в Стокгольме
DELETE FROM TOURNEY
FROM TOURNEY JOIN CITY ON (TOURNEY.city_id = CITY.city_id)
where city.city = 'Стокгольм'

select * from TOURNEY
