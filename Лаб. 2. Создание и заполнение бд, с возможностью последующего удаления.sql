SET DATEFORMAT dmy

ALTER TABLE RANG DROP CONSTRAINT IF EXISTS person_id
ALTER TABLE RANG DROP CONSTRAINT IF EXISTS rang_id
ALTER TABLE TOURNEY_PLAYER DROP CONSTRAINT IF EXISTS player_id
ALTER TABLE TOURNEY_PLAYER DROP CONSTRAINT IF EXISTS tourney_id
ALTER TABLE PERSON DROP CONSTRAINT IF EXISTS gender_id
ALTER TABLE PERSON DROP CONSTRAINT IF EXISTS city_id
ALTER TABLE PLAYERS_GAMES DROP CONSTRAINT IF EXISTS player_id
ALTER TABLE PLAYERS_GAMES DROP CONSTRAINT IF EXISTS game_id
ALTER TABLE PLAYERS_GAMES DROP CONSTRAINT IF EXISTS color_id
ALTER TABLE GAME DROP CONSTRAINT IF EXISTS type_of_game_id
ALTER TABLE GAME DROP CONSTRAINT IF EXISTS stage_id
ALTER TABLE STAGE DROP CONSTRAINT IF EXISTS tourney_id
ALTER TABLE STAGE DROP CONSTRAINT IF EXISTS type_of_stage_id
ALTER TABLE TOURNEY DROP CONSTRAINT IF EXISTS city_id
ALTER TABLE TOURNEY DROP CONSTRAINT IF EXISTS gender_id
DROP TABLE RANG
DROP TABLE TOURNEY_PLAYER
DROP TABLE STAGE_PERSON
DROP TABLE PLAYERS_GAMES
DROP TABLE RANG_NAME
DROP TABLE COLOR
DROP TABLE GAME
DROP TABLE PERSON
DROP TABLE STAGE 
DROP TABLE TOURNEY
DROP TABLE TYPE_OF_GAME
DROP TABLE TYPE_OF_STAGE
DROP TABLE CITY
DROP TABLE GENDER


CREATE TABLE GENDER (
gender_id SMALLINT NOT NULL PRIMARY KEY IDENTITY(1, 1),
gender VARCHAR(6) );

CREATE TABLE CITY (
city_id SMALLINT NOT NULL PRIMARY KEY IDENTITY(1, 1),
city VARCHAR(30) );

CREATE TABLE TYPE_OF_STAGE (
type_of_stage_id SMALLINT NOT NULL PRIMARY KEY IDENTITY(1, 1),
type_of_stage VARCHAR(20) );

CREATE TABLE TYPE_OF_GAME (
type_of_game_id SMALLINT NOT NULL PRIMARY KEY IDENTITY (1, 1),
type_of_game VARCHAR(20),
min_duration_ SMALLINT,
max_duration_ SMALLINT );

CREATE TABLE TOURNEY (
tourney_id SMALLINT NOT NULL PRIMARY KEY IDENTITY (1, 1),
name_of_tourney VARCHAR(50),
city_id SMALLINT,
start_date_ DATETIME,
end_date_ DATE,
gender_id SMALLINT);


CREATE TABLE STAGE (
stage_id SMALLINT NOT NULL PRIMARY KEY IDENTITY (1, 1),
type_of_stage_id SMALLINT,
tourney_id SMALLINT,
start_date_ DATE,
end_date_ DATE );

CREATE TABLE  PERSON (
  person_id SMALLINT NOT NULL PRIMARY KEY IDENTITY (1, 1),
  surname VARCHAR(20),
  name_ VARCHAR(20),
  middle_name VARCHAR(20),
  gender_id SMALLINT,
  birth_date DATE,
  email VARCHAR(30),
  telephone VARCHAR(30),
  city_id SMALLINT );

CREATE TABLE GAME (
game_id SMALLINT NOT NULL PRIMARY KEY IDENTITY (1, 1),
type_of_game_id SMALLINT,
stage_id SMALLINT,
date_ DATE,
duration SMALLINT,
number_of_moves SMALLINT,
round_ SMALLINT );


CREATE TABLE COLOR (
color_id SMALLINT NOT NULL PRIMARY KEY IDENTITY (1, 1),
color VARCHAR(30) );

CREATE TABLE RANG_NAME (
rang_id SMALLINT NOT NULL PRIMARY KEY IDENTITY (1, 1),
rang_name VARCHAR(30) );

CREATE TABLE PLAYERS_GAMES (
player_id SMALLINT NOT NULL,
game_id SMALLINT NOT NULL,
score DECIMAL(2,1),
color_id SMALLINT,
PRIMARY KEY (player_id, game_id) );

CREATE TABLE STAGE_PERSON (
player_id SMALLINT NOT NULL,
stage_id SMALLINT NOT NULL,
place SMALLINT,
PRIMARY KEY (player_id, stage_id) );

CREATE TABLE RANG (
person_id SMALLINT NOT NULL,
rang_id SMALLINT,
start_date_ DATETIME NOT NULL,
end_date_ DATETIME,
PRIMARY KEY (person_id, start_date_) );

CREATE TABLE TOURNEY_PLAYER (
player_id SMALLINT NOT NULL,
tourney_id SMALLINT NOT NULL,
place SMALLINT,
PRIMARY KEY (player_id, tourney_id) );


ALTER TABLE PERSON ADD
FOREIGN KEY (gender_id)
REFERENCES [GENDER](gender_id),
FOREIGN KEY (city_id)
REFERENCES [CITY](city_id)

ALTER TABLE GAME ADD
FOREIGN KEY (type_of_game_id)
REFERENCES [TYPE_OF_GAME](type_of_game_id), -- ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (stage_id)
REFERENCES [STAGE](stage_id)  --ON DELETE CASCADE ON UPDATE CASCADE

ALTER TABLE PLAYERS_GAMES ADD
FOREIGN KEY (player_id)
REFERENCES [PERSON](person_id),
FOREIGN KEY (game_id)
REFERENCES [GAME](game_id), -- ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (color_id)
REFERENCES [COLOR](color_id)

ALTER TABLE STAGE ADD
FOREIGN KEY (type_of_stage_id)
REFERENCES [TYPE_OF_STAGE](type_of_stage_id),
FOREIGN KEY (tourney_id) 
REFERENCES [TOURNEY](tourney_id) --ON DELETE CASCADE ON UPDATE CASCADE

ALTER TABLE STAGE_PERSON ADD
FOREIGN KEY (player_id)
REFERENCES [PERSON](person_id),
FOREIGN KEY (stage_id)
REFERENCES [STAGE](stage_id) --ON DELETE CASCADE ON UPDATE CASCADE

ALTER TABLE TOURNEY ADD
FOREIGN KEY (city_id)
REFERENCES [CITY](city_id), -- ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (gender_id)
REFERENCES [GENDER](gender_id) --ON DELETE CASCADE ON UPDATE CASCADE

ALTER TABLE RANG ADD
FOREIGN KEY (person_id)
REFERENCES [PERSON](person_id), --ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (rang_id)
REFERENCES [RANG_NAME](rang_id)-- ON DELETE CASCADE ON UPDATE CASCADE

ALTER TABLE TOURNEY_PLAYER ADD
FOREIGN KEY (player_id) 
REFERENCES [PERSON](person_id), --ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (tourney_id)
REFERENCES [TOURNEY](tourney_id) --ON DELETE CASCADE ON UPDATE CASCADE*/
-- ОГРАНИЧЕНИЕ НА ДАТУ РОЖДЕНИЯ
--ALTER TABLE PERSON ADD CONSTRAINT birth_date CHECK (birth_date < '01/01/1958') 

INSERT INTO GENDER VALUES ('FEMALE')
INSERT INTO GENDER VALUES ('MALE')

INSERT INTO [CITY] VALUES ('Владивосток')
INSERT INTO [CITY] VALUES ('Новороссийск')
INSERT INTO [CITY] VALUES ('Гамбург')
INSERT INTO [CITY] VALUES ('Стокгольм')
INSERT INTO [CITY] VALUES ('Москва')
INSERT INTO [CITY] VALUES ('Санкт-Петербург')
INSERT INTO [CITY] VALUES ('Владимир')

INSERT INTO TYPE_OF_STAGE VALUES ('1/8')
INSERT INTO TYPE_OF_STAGE VALUES ('1/4')
INSERT INTO TYPE_OF_STAGE VALUES ('1/2')
INSERT INTO TYPE_OF_STAGE VALUES ('ФИНАЛ')

INSERT INTO TYPE_OF_GAME VALUES ('СТАНДАРТ', 180, 210)
INSERT INTO TYPE_OF_GAME VALUES ('РАПИД', 10, 60)
INSERT INTO TYPE_OF_GAME VALUES ('БЛИЦ', 5, 5)

INSERT INTO TOURNEY VALUES ('ПОДРАСТАЮЩИЙ ФЕРЗЬ', 1, '01/06/1977', '05/06/1977', 2)
INSERT INTO TOURNEY VALUES ('КЛАССИКА НА ТАГАНКЕ', 3, '17/08/1980', '17/08/1980', 1)
INSERT INTO TOURNEY VALUES ('КУБОК ПО РАПИДУ', 4, '23/11/1982', '25/11/1982', 2)
INSERT INTO TOURNEY VALUES ('БФ СТАНДАРТ ИНДИВИДУАЛЬНЫЙ', 2, '19/01/1978', '28/01/1978', 2) 
INSERT INTO TOURNEY VALUES ('ЧЕМПИОНАТ ДФО', 1, '14/03/1991', '14/03/1991', 1)

INSERT INTO STAGE VALUES (1, 1, '01/06/1977', '02/06/1977')
INSERT INTO STAGE VALUES (2, 1, '03/06/1977', '03/06/1977')
INSERT INTO STAGE VALUES (3, 1, '04/06/1977', '04/06/1977')
INSERT INTO STAGE VALUES (4, 1, '05/06/1977', '05/06/1977')
INSERT INTO STAGE VALUES (4, 2, '17/08/1980', '17/08/1980')
INSERT INTO STAGE VALUES (3, 3, '23/11/1982', '23/11/1982')
INSERT INTO STAGE VALUES (4, 3, '25/11/1982', '25/11/1982')
INSERT INTO STAGE VALUES (3, 4, '19/01/1978', '19/01/1978')
INSERT INTO STAGE VALUES (4, 4, '28/01/1978', '28/01/1978')
INSERT INTO STAGE VALUES (4, 5, '14/03/1991', '14/03/1991')

INSERT INTO PERSON VALUES ('Терёшина','Всеслава','Авдеевна',1,'10/11/1953','tereshina.yandex.ru','20(4736)320-85-07', 1)
INSERT INTO PERSON VALUES ('Цейдлиц','Таисия','	Давидовна',	1,'17/12/1950','cedlic.mail.ru','6(628)320-20-45', 1)
INSERT INTO PERSON VALUES ('Копцева','Диана','Григоргиевна',1, '23/08/1943', 'koptseva.gmail.com', '64(1741)959-86-35', 2)
INSERT INTO PERSON VALUES ('Сигачёва','Анфиса','Семеновна',1, '10/01/1951', 'sigachova.rambler.ru', '14(52)127-31-85', 3)
INSERT INTO PERSON VALUES ('Табернакулова','Жанна','Макаровна',1,'11/10/1952', 'tab.yandex.ru', '2(51)354-75-07', 4)
INSERT INTO PERSON VALUES ('Никерова','Полина','Мартыновна',1,'30/05/1954', 'nikerova.mail.ru', '71(2233)629-89-30', 5)
INSERT INTO PERSON VALUES ('Ижутина','Ираида','Антиповна',1,'18/04/1955','igutina.gmail.com', '819(61)078-82-95', 6)
INSERT INTO PERSON VALUES ('Наумова','Светлана','Леонидовна',1,'19/02/1956', 'naumova.yandex.ru', '766(9027)475-41-52', 7)
INSERT INTO PERSON VALUES ('Юрасова','Марина','Станиславовна',1,'15/07/1945', 'urasova.mail.com', '6(03)432-22-52', 1)
INSERT INTO PERSON VALUES ('Бабинова','Эмилия','Эммануиловна',1, '16/10/1951', 'babinova.mail.ru', '294(8481)469-90-15', 1)
INSERT INTO PERSON VALUES ('Шпак','Никифор','Еремеевич',2,'10/09/1950', 'shpak.yandex.ru', '556(558)369-73-20', 1)
INSERT INTO PERSON VALUES ('Сушилов','Дмитрий','Михаилович',2,'09/08/1951', 'sushilov.mal.ru', '20(4736)320-85-07', 1)
INSERT INTO PERSON VALUES ('Бутусов','Юлиан','Мартьянович',	2	, '08/10/1952', 'butusov.gmail.com', '6(628)320-20-45', 2)
INSERT INTO PERSON VALUES ('Кабальнов','Петр','Глебович',2, '07/05/1953', 'kabalnov.mail.ru', '	1(2819)805-01-36', 3)
INSERT INTO PERSON VALUES ('Соловьёв','Юлий','Кириллович',2, '06/06/1954', 'solovev.yandex,ru', '8(903)049-10-93', 4)
INSERT INTO PERSON VALUES ('Черномырдин','Феофан','Федосиевич',2, '05/04/1955', 'chern.mail.ru', '886(87)981-90-19', 5)
INSERT INTO PERSON VALUES ('Кадцын','Илья','Ефремович',2,'04/10/1956', 'kad.gmail.com', '71(2233)629-89-30', 6)
INSERT INTO PERSON VALUES ('Агейкин','Иван','Сигизмундович',2,'03/09/1957', 'agekin.yandex.ru', '819(61)078-82-95', 7)
INSERT INTO PERSON VALUES ('Племянников','Михей','Федорович',2,'02/03/1946','plem.mail.com','766(9027)475-41-52', 1)
INSERT INTO PERSON VALUES ('Маркин','Лев','Мирославович',	2	, '01/02/1959', 'markin.gmail.com', '6(03)432-22-52', 2)
INSERT INTO PERSON VALUES ('Абрамович','Лука','Богданович',2, '11/03/1941', 'abramov.yandex.ru', '12(150)928-17-09', 3)
INSERT INTO PERSON VALUES ('Митяшов','Егор','Сидорович',2, '26/01/1950', 'mitashov.mail.ru', '048(8601)611-62-60', 4)
INSERT INTO PERSON VALUES ('Нестеров','Мефодий','Ерофеевич',2, '13/05/1951', 'nesterov.yandex.ru', '96(461)906-61-66', 5)
INSERT INTO PERSON VALUES ('Севостьянов','Никон','Давидович'	,	2	, '14/08/1952', 'sevost.mail.ru', '3(9034)496-55-36', 6)
INSERT INTO PERSON VALUES ('Кудрявцев','Давид','Евгениевич',2,'15/09/1953', 'kudr.gmail.com', '117(21)864-51-08', 7)
INSERT INTO PERSON VALUES ('Королев','Наум','Елизарович',2,'16/03/1954', 'korolev.gmail.com', '96(18)670-12-11', 1)
INSERT INTO PERSON VALUES ('Пыстогов','Юрий','Онисимович',2, '17/02/1955', 'pustogov.yandex.ru', '886(87)981-90-19', 2)
INSERT INTO PERSON VALUES ('Ярмольник','Пахом','Артемиевич',2, '21/10/1956', 'yarmolnik.mail.ru', '75(5211)224-80-26', 3)
INSERT INTO PERSON VALUES ('Набиуллин','Фома','Назарович',2,'22/12/1957', 'nabiul.yandex.ru', '68(9606)571-16-06', 4)
INSERT INTO PERSON VALUES ('Андреев','Авдей ','Модестович',2,'23/11/1958','andreev.gmail.ru', '6(994)132-17-11', 5)


INSERT INTO GAME VALUES (	1,	1	,'01/06/1977'	,	208	,	45	,	1	)
INSERT INTO GAME VALUES (	1,	1	,'01/06/1977'	,	206	,	46	,	2	)
INSERT INTO GAME VALUES (	1,	1	,'01/06/1977'	,	184	,	41	,	3	)
INSERT INTO GAME VALUES (	1,	1	,'01/06/1977'	,	205	,	58	,	4	)
INSERT INTO GAME VALUES (	1,	1	,'01/06/1977'	,	185	,	49	,	5	)
INSERT INTO GAME VALUES (	1,	1	,'01/06/1977'	,	203	,	57	,	6	)
INSERT INTO GAME VALUES (	1,	1	,'01/06/1977'	,	192	,	41	,	7	)
INSERT INTO GAME VALUES (	1,	1	,'01/06/1977'	,	189	,	51	,	8	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	180	,	42	,	9	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	190	,	55	,	10	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	207	,	51	,	11	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	186	,	59	,	12	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	186	,	40	,	13	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	187	,	58	,	14	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	189	,	41	,	15	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	189	,	54	,	16	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	188	,	54	,	17	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	181	,	54	,	18	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	182	,	54	,	19	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	185	,	54	,	20	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	183	,	54	,	21	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	186	,	54	,	22	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	187	,	54	,	23	)
INSERT INTO GAME VALUES (	1,	1	, '02/06/1977'	,	192	,	54	,	24	)
INSERT INTO GAME VALUES (	1,	2	, '03/06/1977'	,	186	,	49	,	1)
INSERT INTO GAME VALUES (	1,	2	, '03/06/1977'	,	180	,	53	,	2)
INSERT INTO GAME VALUES (	1,	2	, '03/06/1977'	,	203	,	43	,	3)
INSERT INTO GAME VALUES (	1,	2	, '03/06/1977'	,	185	,	53	,	4)
INSERT INTO GAME VALUES (	1,	2	, '03/06/1977'	,	204	,	52	,	5)
INSERT INTO GAME VALUES (	1,	2	, '03/06/1977'	,	204	,	53	,	6)
INSERT INTO GAME VALUES (	1,	2	, '03/06/1977'	,	181	,	59	,	7)
INSERT INTO GAME VALUES (	1,	2	, '03/06/1977'	,	185	,	56	,	8)
INSERT INTO GAME VALUES (	1,	2	, '03/06/1977'	,	206	,	50	,	9)
INSERT INTO GAME VALUES (	1,	2	, '03/06/1977'	,	182	,	58	,	10)
INSERT INTO GAME VALUES (	1,	2	, '03/06/1977'	,	193	,	57	,	11)
INSERT INTO GAME VALUES (	1,	2	, '03/06/1977'	,	199	,	53	,	12)
INSERT INTO GAME VALUES (	1,	3	, '04/06/1977'	,	195	,	46	,	1)
INSERT INTO GAME VALUES (	1,	3	, '04/06/1977'	,	180	,	49	,	2)
INSERT INTO GAME VALUES (	1,	3	, '04/06/1977'	,	181	,	59	,	3)
INSERT INTO GAME VALUES (	1,	3	, '04/06/1977'	,	199	,	48	,	4)
INSERT INTO GAME VALUES (	1,	3	, '04/06/1977'	,	196	,	53	,	5)
INSERT INTO GAME VALUES (	1,	3	, '04/06/1977'	,	209	,	57	,	6)
INSERT INTO GAME VALUES (	1,	4	, '05/06/1977'	,	186	,	55	,	1)
INSERT INTO GAME VALUES (	2,	5	, '17/08/1980'	,	54	,	25	,	1)
INSERT INTO GAME VALUES (	3,	6	, '23/11/1982'	,	5	,	2	,	1)
INSERT INTO GAME VALUES (	3,	6	, '23/11/1982'	,	5	,	2	,	2)
INSERT INTO GAME VALUES (	3,	6	, '23/11/1982'	,	5	,	2	,	3)
INSERT INTO GAME VALUES (	3,	6	, '23/11/1982'	,	5	,	2	,	4)
INSERT INTO GAME VALUES (	3,	6	, '23/11/1982'	,	5	,	2	,	5)
INSERT INTO GAME VALUES (	3,	6	, '23/11/1982'	,	5	,	2	,	6)
INSERT INTO GAME VALUES (	3,	7	, '25/11/1982'	,	5	,	2	,	1)
INSERT INTO GAME VALUES (	1,	8	, '19/01/1978'	,	190	,	45	,	1)
INSERT INTO GAME VALUES (	1,	8	, '19/01/1978'	,	193	,	59	,	2)
INSERT INTO GAME VALUES (	1,	8	, '19/01/1978'	,	201	,	54	,	3)
INSERT INTO GAME VALUES (	1,	8	, '19/01/1978'	,	193	,	54	,	4)
INSERT INTO GAME VALUES (	1,	8	, '19/01/1978'	,	199	,	54	,	5)
INSERT INTO GAME VALUES (	1,	8	, '19/01/1978'	,	193	,	59	,	6)
INSERT INTO GAME VALUES (	1,	9	, '28/01/1978'	,	187	,	53	,	1)
INSERT INTO GAME VALUES (	1,	10	, '14/03/1991'	,	201	,	51	,	1)
INSERT INTO GAME VALUES (	1,	10	, '14/03/1991'	,	183	,	41	,	2)
INSERT INTO GAME VALUES (	1,	10	, '14/03/1991'	,	196	,	51	,	3)
INSERT INTO GAME VALUES (	1,	10	, '14/03/1991'	,	196	,	56	,	4)
INSERT INTO GAME VALUES (	1,	10	, '14/03/1991'	,	204	,	50	,	5)
INSERT INTO GAME VALUES (	1,	10	, '14/03/1991'	,	208	,	50	,	6)

INSERT INTO COLOR VALUES ('WHITE')
INSERT INTO COLOR VALUES ('BLACK')

INSERT INTO RANG_NAME VALUES ('IV')
INSERT INTO RANG_NAME VALUES ('III')
INSERT INTO RANG_NAME VALUES ('II')
INSERT INTO RANG_NAME VALUES ('I')
INSERT INTO RANG_NAME VALUES ('КАНДИДАТ В МАСТЕРА')
INSERT INTO RANG_NAME VALUES ('МАСТЕР СПОРТА')
INSERT INTO RANG_NAME VALUES ('ГРОССМЕЙСТЕР')

INSERT INTO PLAYERS_GAMES VALUES (11, 1, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (12, 1, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (11, 2, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (13, 2, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (11, 3, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (14, 3, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (12, 4, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (13, 4, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (12, 5, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (14, 5, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (13, 6, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (14, 6, 0, 2)

INSERT INTO PLAYERS_GAMES VALUES (15, 7, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (16, 7, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (15, 8, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (17, 8, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (15, 9, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (18, 9, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (16, 10, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (17, 10, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (16, 11, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (18, 11, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (17, 12, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (18, 12, 0, 2)

INSERT INTO PLAYERS_GAMES VALUES (19, 13, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (20, 13, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (19, 14, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (21, 14, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (19, 15, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (22, 15, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (20, 16, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (21, 16, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (20, 17, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (22, 17, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (21, 18, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (22, 18, 0, 2)

INSERT INTO PLAYERS_GAMES VALUES (23, 19, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (24, 19, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (23, 20, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (25, 20, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (23, 21, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (26, 21, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (24, 22, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (25, 22, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (24, 23, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (26, 23, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (25, 24, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (26, 24, 0, 2)

INSERT INTO PLAYERS_GAMES VALUES (11, 25, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (15, 25, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (11, 26, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (19, 26, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (11, 27, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (23, 27, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (15, 28, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (19, 28, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (15, 29, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (23, 29, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (19, 30, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (23, 30, 0, 2)

INSERT INTO PLAYERS_GAMES VALUES (12, 31, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (16, 31, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (12, 32, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (20, 32, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (12, 33, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (24, 33, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (16, 34, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (20, 34, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (16, 35, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (24, 35, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (20, 36, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (24, 36, 0, 2)

INSERT INTO PLAYERS_GAMES VALUES (11, 37, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (15, 37, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (11, 38, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (12, 38, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (11, 39, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (16, 39, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (12, 40, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (16, 40, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (12, 41, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (15, 41, 0, 2)
INSERT INTO PLAYERS_GAMES VALUES (15, 42, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (16, 42, 0, 2)

INSERT INTO PLAYERS_GAMES VALUES (11, 43, 1, 1)
INSERT INTO PLAYERS_GAMES VALUES (12, 43, 0, 2)

INSERT INTO PLAYERS_GAMES VALUES (1, 44, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (2, 44, 0, 1)


INSERT INTO PLAYERS_GAMES VALUES (13, 45, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (14, 45, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (13, 46, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (15, 46, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (13, 47, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (16, 47, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (14, 48, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (15, 48, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (14, 49, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (16, 49, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (15, 50, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (16, 50, 0, 1)

INSERT INTO PLAYERS_GAMES VALUES (13, 51, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (14, 51, 0, 1)

INSERT INTO PLAYERS_GAMES VALUES (17, 52, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (18, 52, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (17, 53, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (19, 53, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (17, 54, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (20, 54, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (18, 55, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (19, 55, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (18, 56, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (20, 56, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (19, 57, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (20, 57, 0, 1)


INSERT INTO PLAYERS_GAMES VALUES (17, 58, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (18, 58, 0, 1)


INSERT INTO PLAYERS_GAMES VALUES (1, 59, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (2, 59, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (3, 60, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (4, 60, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (5, 61, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (6, 61, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (1, 62, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (3, 62, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (1, 63, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (5, 63, 0, 1)
INSERT INTO PLAYERS_GAMES VALUES (3, 64, 1, 2)
INSERT INTO PLAYERS_GAMES VALUES (5, 64, 0, 1)

INSERT INTO STAGE_PERSON VALUES (11, 1, 1)
INSERT INTO STAGE_PERSON VALUES (11, 2, 1)
INSERT INTO STAGE_PERSON VALUES (11, 3, 1)
INSERT INTO STAGE_PERSON VALUES (11, 4, 1)

INSERT INTO STAGE_PERSON VALUES (12, 1, 2)
INSERT INTO STAGE_PERSON VALUES (12, 2, 2)
INSERT INTO STAGE_PERSON VALUES (12, 3, 2)
INSERT INTO STAGE_PERSON VALUES (12, 4, 2)

INSERT INTO STAGE_PERSON VALUES (13, 1, 3)
INSERT INTO STAGE_PERSON VALUES (13, 6, 1)
INSERT INTO STAGE_PERSON VALUES (13, 7, 1)

INSERT INTO STAGE_PERSON VALUES (14, 1, 4)
INSERT INTO STAGE_PERSON VALUES (14, 6, 2)
INSERT INTO STAGE_PERSON VALUES (14, 7, 2)

INSERT INTO STAGE_PERSON VALUES (1, 5, 1)
INSERT INTO STAGE_PERSON VALUES (1, 10, 1)

INSERT INTO STAGE_PERSON VALUES (2, 5, 2)
INSERT INTO STAGE_PERSON VALUES (2, 10, 2)

INSERT INTO STAGE_PERSON VALUES (15, 1, 1)
INSERT INTO STAGE_PERSON VALUES (15, 2, 2)
INSERT INTO STAGE_PERSON VALUES (15, 3, 3)
INSERT INTO STAGE_PERSON VALUES (15, 6, 3)

INSERT INTO STAGE_PERSON VALUES (16, 1, 1)
INSERT INTO STAGE_PERSON VALUES (16, 2, 2)
INSERT INTO STAGE_PERSON VALUES (16, 3, 4)
INSERT INTO STAGE_PERSON VALUES (16, 6, 4)

INSERT INTO STAGE_PERSON VALUES (17, 1, 3)
INSERT INTO STAGE_PERSON VALUES (17, 8, 1)
INSERT INTO STAGE_PERSON VALUES (17, 9, 1)

INSERT INTO STAGE_PERSON VALUES (18, 1, 4)
INSERT INTO STAGE_PERSON VALUES (18, 8, 2)
INSERT INTO STAGE_PERSON VALUES (18, 9, 2)


INSERT INTO STAGE_PERSON VALUES (19, 1, 1)
INSERT INTO STAGE_PERSON VALUES (19, 2, 3)
INSERT INTO STAGE_PERSON VALUES (19, 8, 3)


INSERT INTO STAGE_PERSON VALUES (20, 1, 1)
INSERT INTO STAGE_PERSON VALUES (20, 2, 3)
INSERT INTO STAGE_PERSON VALUES (20, 8, 4)

INSERT INTO STAGE_PERSON VALUES (21, 1, 3)
INSERT INTO STAGE_PERSON VALUES (22, 1, 4)

INSERT INTO STAGE_PERSON VALUES (23, 1, 1)
INSERT INTO STAGE_PERSON VALUES (23, 2, 4)

INSERT INTO STAGE_PERSON VALUES (24, 1, 2)
INSERT INTO STAGE_PERSON VALUES (24, 2, 4)

INSERT INTO STAGE_PERSON VALUES (25, 1, 3)
INSERT INTO STAGE_PERSON VALUES (26, 1, 4)

INSERT INTO STAGE_PERSON VALUES (3, 10, 2)
INSERT INTO STAGE_PERSON VALUES (4, 10, 4)
INSERT INTO STAGE_PERSON VALUES (5, 10, 3)
INSERT INTO STAGE_PERSON VALUES (6, 10, 4)

INSERT INTO RANG VALUES (1, 1, '10/08/1974', '11/08/1975')
INSERT INTO RANG VALUES (1, 2, '11/08/1975', '13/09/1976')
INSERT INTO RANG VALUES (1, 3, '13/09/1976', '07/05/1977')
INSERT INTO RANG VALUES (1, 4, '07/05/1977', '21/11/1977')
INSERT INTO RANG VALUES (1, 5, '21/11/1977', '03/04/1978')
INSERT INTO RANG VALUES (1, 6, '03/04/1978', '16/10/1978')
INSERT INTO RANG VALUES (1, 7, '16/10/1978', NULL)
INSERT INTO RANG VALUES (2, 1, '10/09/1975', '11/09/1976')
INSERT INTO RANG VALUES (2, 2, '11/09/1976', '05/08/1977')
INSERT INTO RANG VALUES (2, 3, '05/08/1977', '07/10/1979')
INSERT INTO RANG VALUES (2, 4, '07/10/1979', NULL)
INSERT INTO RANG VALUES (3, 1, '10/08/1974', '13/06/1979')
INSERT INTO RANG VALUES (3, 2, '13/06/1979', NULL)
INSERT INTO RANG VALUES (4, 1, '12/08/1973', '14/07/1978')
INSERT INTO RANG VALUES (4, 2, '14/07/1978', '20/03/1979')
INSERT INTO RANG VALUES (4, 3, '20/03/1979', '22/07/1981')
INSERT INTO RANG VALUES (4, 4, '22/07/1981', '03/11/1982')
INSERT INTO RANG VALUES (4, 5, '03/11/1982', NULL)
INSERT INTO RANG VALUES (5, 1, '28/04/1974', '23/08/1982')
INSERT INTO RANG VALUES (5, 2, '23/08/1982', NULL)
INSERT INTO RANG VALUES (6, 1, '25/05/1976', '17/04/1978')
INSERT INTO RANG VALUES (6, 2, '17/04/1978', '18/11/1980')
INSERT INTO RANG VALUES (6, 3, '18/11/1980', '23/10/1982')
INSERT INTO RANG VALUES (6, 4, '23/10/1982', NULL)
INSERT INTO RANG VALUES (7, 1, '17/04/1973', '23/07/1975')
INSERT INTO RANG VALUES (7, 2, '23/07/1975', '10/11/1977')
INSERT INTO RANG VALUES (7, 3, '10/11/1977', NULL)
INSERT INTO RANG VALUES (8, 1, '16/03/1975', NULL)
INSERT INTO RANG VALUES (9, 1, '08/02/1974', NULL)
INSERT INTO RANG VALUES (10, 1, '23/01/1975', NULL)
INSERT INTO RANG VALUES (11, 1, '19/12/1973', '21/10/1974')
INSERT INTO RANG VALUES (11, 2, '21/10/1974', '13/05/1975')
INSERT INTO RANG VALUES (11, 3, '13/05/1975', '07/10/1976')
INSERT INTO RANG VALUES (11, 4, '07/10/1976', '21/04/1978')
INSERT INTO RANG VALUES (11, 5, '21/04/1978', '14/08/1979')
INSERT INTO RANG VALUES (11, 6, '14/08/1979', '23/05/1980')
INSERT INTO RANG VALUES (11, 7, '23/05/1980', NULL)
INSERT INTO RANG VALUES (12, 1, '09/11/1973', '04/09/1974')
INSERT INTO RANG VALUES (12, 2, '04/09/1974', '13/07/1975')
INSERT INTO RANG VALUES (12, 3, '13/07/1975', '15/01/1976')
INSERT INTO RANG VALUES (12, 4, '16/02/1976', '11/07/1977')
INSERT INTO RANG VALUES (12, 5, '11/07/1977', '08/08/1978')
INSERT INTO RANG VALUES (12, 6, '08/08/1978', '22/11/1979')
INSERT INTO RANG VALUES (12, 7, '22/11/1979', NULL)
INSERT INTO RANG VALUES (13, 1, '05/10/1972', '16/06/1974')
INSERT INTO RANG VALUES (13, 2, '16/06/1974', '23/12/1975')
INSERT INTO RANG VALUES (13, 3, '23/12/1975', '20/09/1976')
INSERT INTO RANG VALUES (13, 4, '20/09/1976', '12/11/1977')
INSERT INTO RANG VALUES (13, 5, '12/11/1977', NULL)
INSERT INTO RANG VALUES (14, 1, '30/09/1975', '23/07/1976')
INSERT INTO RANG VALUES (14, 2, '23/07/1976', '25/08/1977')
INSERT INTO RANG VALUES (14, 3, '25/08/1977', '13/10/1978')
INSERT INTO RANG VALUES (14, 4, '13/10/1978', '05/12/1981')
INSERT INTO RANG VALUES (14, 5, '05/12/1981', NULL)
INSERT INTO RANG VALUES (15, 1, '31/08/1975', '14/09/1980')
INSERT INTO RANG VALUES (15, 2, '14/09/1980', '25/08/1982')
INSERT INTO RANG VALUES (15, 3, '25/08/1982', NULL)
INSERT INTO RANG VALUES (16, 1, '02/07/1976', '05/12/1978')
INSERT INTO RANG VALUES (16, 2, '05/12/1978', '13/08/1979')
INSERT INTO RANG VALUES (16, 3, '13/08/1979', '11/05/1980')
INSERT INTO RANG VALUES (16, 4, '11/05/1980', '08/03/1981')
INSERT INTO RANG VALUES (16, 5, '08/03/1981', '18/05/1982')
INSERT INTO RANG VALUES (16, 6, '18/05/1982', NULL)
INSERT INTO RANG VALUES (17, 1, '01/06/1976', '18/04/1978')
INSERT INTO RANG VALUES (17, 2, '18/04/1978', '20/08/1979')
INSERT INTO RANG VALUES (17, 3, '20/08/1979', '05/02/1980')
INSERT INTO RANG VALUES (17, 4, '05/02/1980', NULL)
INSERT INTO RANG VALUES (18, 1, '28/05/1976', '19/08/1977')
INSERT INTO RANG VALUES (18, 2, '19/08/1977', '21/06/1979')
INSERT INTO RANG VALUES (18, 3, '21/06/1979', NULL)
INSERT INTO RANG VALUES (19, 1, '05/04/1974', '13/04/1975')
INSERT INTO RANG VALUES (19, 2, '13/04/1975', '24/10/1976')
INSERT INTO RANG VALUES (19, 3, '24/10/1976', '19/03/1977')
INSERT INTO RANG VALUES (19, 4, '19/03/1977', '03/07/1978')
INSERT INTO RANG VALUES (19, 5, '03/07/1978', '15/12/1978')
INSERT INTO RANG VALUES (19, 6, '15/12/1978', '24/06/1981')
INSERT INTO RANG VALUES (19, 7, '24/06/1981', NULL)
INSERT INTO RANG VALUES (20, 1, '04/03/1974', '09/04/1976')
INSERT INTO RANG VALUES (20, 2, '09/04/1976', '10/12/1977')
INSERT INTO RANG VALUES (20, 3, '10/12/1977', NULL)
INSERT INTO RANG VALUES (21, 1, '16/01/1975', '28/09/1976')
INSERT INTO RANG VALUES (21, 2, '28/09/1976', '03/12/1977')
INSERT INTO RANG VALUES (21, 3, '03/12/1977', '29/10/1978')
INSERT INTO RANG VALUES (21, 4, '29/10/1978', NULL)
INSERT INTO RANG VALUES (22, 1, '15/12/1974', '17/03/1975')
INSERT INTO RANG VALUES (22, 2, '17/03/1975', '27/11/1977')
INSERT INTO RANG VALUES (22, 3, '27/11/1977', '16/02/1978')
INSERT INTO RANG VALUES (22, 4, '16/02/1978', '23/04/1979')
INSERT INTO RANG VALUES (22, 5, '23/04/1979', NULL)
INSERT INTO RANG VALUES (23, 1, '11/01/1976', '13/07/1977')
INSERT INTO RANG VALUES (23, 2, '13/07/1977', '23/11/1978')
INSERT INTO RANG VALUES (23, 3, '23/11/1978', NULL)
INSERT INTO RANG VALUES (24, 1, '12/05/1974', '23/05/1975')
INSERT INTO RANG VALUES (24, 2, '23/05/1975', '12/07/1976')
INSERT INTO RANG VALUES (24, 3, '12/07/1976', '05/12/1977')
INSERT INTO RANG VALUES (24, 4, '05/12/1977', NULL)
INSERT INTO RANG VALUES (25, 1, '15/07/1975', '14/03/1976')
INSERT INTO RANG VALUES (25, 2, '14/03/1976', '03/10/1977')
INSERT INTO RANG VALUES (25, 3, '03/10/1977', '05/01/1979')
INSERT INTO RANG VALUES (25, 4, '05/01/1979', NULL)
INSERT INTO RANG VALUES (26, 1, '03/07/1974', '17/02/1976')
INSERT INTO RANG VALUES (26, 2, '17/02/1976', '19/03/1977')
INSERT INTO RANG VALUES (26, 3, '19/03/1977', NULL)
INSERT INTO RANG VALUES (27, 1, '19/11/1974', '05/10/1975')
INSERT INTO RANG VALUES (27, 2, '05/10/1975', '13/05/1976')
INSERT INTO RANG VALUES (27, 3, '13/05/1976', NULL)
INSERT INTO RANG VALUES (28, 1, '23/01/1973', '04/02/1974')
INSERT INTO RANG VALUES (28, 2, '04/02/1974', '07/10/1975')
INSERT INTO RANG VALUES (28, 3, '07/10/1975', '11/12/1976')
INSERT INTO RANG VALUES (28, 4, '11/12/1976', '07/03/1977')
INSERT INTO RANG VALUES (28, 5, '07/03/1977', '13/09/1978')
INSERT INTO RANG VALUES (28, 6, '13/09/1978', '05/11/1979')
INSERT INTO RANG VALUES (28, 7, '05/11/1979', NULL)
INSERT INTO RANG VALUES (29, 1, '29/07/1976', '26/08/1977')
INSERT INTO RANG VALUES (29, 2, '26/08/1977', '10/04/1978')
INSERT INTO RANG VALUES (29, 3, '10/04/1978', NULL)
INSERT INTO RANG VALUES (30, 1, '27/01/1976', '23/05/1977')
INSERT INTO RANG VALUES (30, 2, '23/05/1977', NULL)

INSERT INTO TOURNEY_PLAYER VALUES (11, 1, 1)
INSERT INTO TOURNEY_PLAYER VALUES (12, 1, 2)
INSERT INTO TOURNEY_PLAYER VALUES (15, 1, 3)
INSERT INTO TOURNEY_PLAYER VALUES (16, 1, 4)
INSERT INTO TOURNEY_PLAYER VALUES (19, 1, 5)
INSERT INTO TOURNEY_PLAYER VALUES (20, 1, 5)
INSERT INTO TOURNEY_PLAYER VALUES (23, 1, 6)
INSERT INTO TOURNEY_PLAYER VALUES (24, 1, 6)
INSERT INTO TOURNEY_PLAYER VALUES (17, 1, 7)
INSERT INTO TOURNEY_PLAYER VALUES (13, 1, 7)
INSERT INTO TOURNEY_PLAYER VALUES (21, 1, 7)
INSERT INTO TOURNEY_PLAYER VALUES (25, 1, 7)
INSERT INTO TOURNEY_PLAYER VALUES (14, 1, 8)
INSERT INTO TOURNEY_PLAYER VALUES (18, 1, 8)
INSERT INTO TOURNEY_PLAYER VALUES (22, 1, 8)
INSERT INTO TOURNEY_PLAYER VALUES (26, 1, 8)

INSERT INTO TOURNEY_PLAYER VALUES (1, 2, 1)
INSERT INTO TOURNEY_PLAYER VALUES (2, 2, 2)

INSERT INTO TOURNEY_PLAYER VALUES (13, 3, 1)
INSERT INTO TOURNEY_PLAYER VALUES (14, 3, 2)
INSERT INTO TOURNEY_PLAYER VALUES (15, 3, 3)
INSERT INTO TOURNEY_PLAYER VALUES (16, 3, 4)

INSERT INTO TOURNEY_PLAYER VALUES (17, 4, 1)
INSERT INTO TOURNEY_PLAYER VALUES (18, 4, 2)
INSERT INTO TOURNEY_PLAYER VALUES (19, 4, 3)
INSERT INTO TOURNEY_PLAYER VALUES (20, 4, 4)

INSERT INTO TOURNEY_PLAYER VALUES (1, 5, 1)
INSERT INTO TOURNEY_PLAYER VALUES (3, 5, 2)
INSERT INTO TOURNEY_PLAYER VALUES (5, 5, 3)
INSERT INTO TOURNEY_PLAYER VALUES (2, 5, 4)
INSERT INTO TOURNEY_PLAYER VALUES (4, 5, 4)
INSERT INTO TOURNEY_PLAYER VALUES (6, 5, 4)
