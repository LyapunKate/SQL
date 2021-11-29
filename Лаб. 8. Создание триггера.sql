-- при занесении занятого шахматистом места ранг шахматиста, занявшего место не ниже 3-го
-- увеличивается на 1, если
-- (( 4 - место ) * (средний ранг на турнире)/ранг участника) >= 1

-- а ранг шахматиста, занявшего место ниже 5-го уменьшается на 1, если
-- ((-1)*(5 - место) * (средний ранг на турнире)/ранг участника) >= 1

if (object_id ('Trig', 'TR') is not null)
drop trigger Trig
go

create trigger Trig on tourney_player 
after update 
as if update(place)
declare @t1 table (num int, person_id int, tourney_id int, place smallint, rang_id smallint)

DECLARE @k INT 
	SET @k = 1
	DECLARE @size INT
	SET @size = (SELECT COUNT(*) FROM inserted)
	--создадим табличное выражение для записи строк, котрые изменялись
	
	insert into @t1(num, person_id, tourney_id, place, rang_id)  SELECT ROW_NUMBER() OVER (ORDER BY deleted.player_id),
		deleted.player_id, deleted.tourney_id, inserted.place, rang.rang_id FROM deleted join inserted 
		on deleted.player_id = inserted.player_id and deleted.tourney_id = inserted.tourney_id
		join person on deleted.player_id = person.person_id
		join rang on person.person_id = rang.person_id
	WHILE (@k <= @size)
begin
declare @place smallint
SET @place = (SELECT place FROM @t1 WHERE num = @k)

declare @person_id smallint
SET @person_id = (select person_id from @t1 where num = @k)

declare @rang_id smallint
set @rang_id = (SELECT rang_id FROM @t1 WHERE num = @k)  

declare @avg_rang float 
SET @avg_rang = (select avg (rang_name.rang_id*1.0)
from tourney 
join tourney_player
on tourney.tourney_id = tourney_player.tourney_id
join person 
on tourney_player.player_id = person.person_id
join rang
on person.person_id = rang.person_id
join rang_name
on rang.rang_id = rang_name.rang_id
where rang.start_date_<= tourney.start_date_ and isnull(rang.end_date_, tourney.end_date_) >= tourney.end_date_
and tourney.tourney_id = (select tourney_id from @t1 where num = @k))

if (@place <= 3) and ((4 - @place) * @avg_rang/@rang_id) >= 1

begin

declare @id_1 smallint
set @id_1 = @person_id;

declare @id_rang smallint

set @id_rang = (
select rang.rang_id from rang join TOURNEY_PLAYER
on rang.person_id=tourney_player.player_id
join tourney on tourney_player.tourney_id=tourney.tourney_id
where rang.start_date_<= tourney.start_date_ and isnull(rang.end_date_, tourney.end_date_) >= tourney.end_date_
and tourney.tourney_id = (select tourney_id from @t1 where num = @k)
and tourney_player.player_id = @id_1
)

declare @id_rang2 smallint
if (@id_rang = 7)
set @id_rang2 = 7
else 
set @id_rang2 = @id_rang + 1

update rang set rang_id = @id_rang2
where rang.rang_id = (
select rang.rang_id from rang join TOURNEY_PLAYER
on rang.person_id=tourney_player.player_id
join tourney on tourney_player.tourney_id=tourney.tourney_id
where rang.start_date_<= tourney.start_date_ and isnull(rang.end_date_, tourney.end_date_) >= tourney.end_date_
and tourney.tourney_id = (select tourney_id from @t1 where num = @k)
and tourney_player.player_id = @id_1
) and rang.person_id = @id_1

 
end

 if (@place > 5) and ((-1)*(5 - @place) * @avg_rang/@rang_id) >= 1

 begin
set @id_1 = @person_id;

set @id_rang = (
select rang.rang_id from rang join TOURNEY_PLAYER
on rang.person_id=tourney_player.player_id
join tourney on tourney_player.tourney_id=tourney.tourney_id
where rang.start_date_<= tourney.start_date_ and isnull(rang.end_date_, tourney.end_date_) >= tourney.end_date_
and tourney.tourney_id = (select tourney_id from @t1 where num = @k)
and tourney_player.player_id = @id_1
)

declare @id_rang3 smallint
if (@id_rang = 1)
set @id_rang3 = 1
else 
set @id_rang3 = @id_rang - 1

update rang set rang_id = @id_rang3
where rang.rang_id = (
select rang.rang_id from rang join TOURNEY_PLAYER
on rang.person_id=tourney_player.player_id
join tourney on tourney_player.tourney_id=tourney.tourney_id
where rang.start_date_<= tourney.start_date_ and isnull(rang.end_date_, tourney.end_date_) >= tourney.end_date_
and tourney.tourney_id = (select tourney_id from @t1 where num = @k)
and tourney_player.player_id = @id_1
) and rang.person_id = @id_1

 
 
end
 set @k = @k + 1

 end


 update tourney_player set tourney_player.place = 1 where tourney_id = 1

 update tourney_player set tourney_player.place = 8 where tourney_id = 1 and player_id = 14

 select * from tourney_player where player_id = 12 and tourney_id = 1

 select * from rang join tourney_player on rang.person_id = tourney_player.player_id where tourney_id = 1

 select * from rang where person_id = 14

 select * from rang_name join rang on rang_name.rang_id = rang.rang_id where rang.person_id = 14


 drop table login_data
 CREATE TABLE LOGIN_DATA
(
"user_login" VARCHAR(40),
"login_date" DATETIME
);
DROP TRIGGER IF EXISTS logon_event 
ON ALL SERVER  
go
CREATE TRIGGER logon_event
ON ALL SERVER
AFTER LOGON
AS
INSERT INTO LOGIN_DATA VALUES(ORIGINAL_LOGIN(), GETDATE())
select * from login_data