--������, ���������� ����������� � ���� ������, ���������� ����� �� ��������, 
--������� ����� �� ��������
IF (OBJECT_ID('task1') is not null)
drop view task1;

go

create view task1 (rang_name, cnt, quantity_of_win, avg_place)
as
select a.rang_name, cnt, isnull(quantity, 0), avg_place
 from (select count(tourney_player.player_id) as cnt, avg(place*1.0) as avg_place,
rang_name
from tourney_player
join person on tourney_player.player_id=person.person_id
join tourney on tourney_player.tourney_id=tourney.tourney_id
join rang on rang.person_id=person.person_id
join rang_name on rang_name.rang_id=rang.rang_id
where rang.start_date_<= tourney.start_date_ and isnull(rang.end_date_,tourney.end_date_)>=tourney.end_date_
group by rang_name ) as a left join
(select count(place) as quantity, rang_name
from tourney_player
join person on tourney_player.player_id=person.person_id
join tourney on tourney_player.tourney_id=tourney.tourney_id
join rang on rang.person_id=person.person_id
join rang_name on rang_name.rang_id=rang.rang_id
where rang.start_date_<= tourney.start_date_ and isnull(rang.end_date_,tourney.end_date_)>=tourney.end_date_
and place = 1
group by rang_name) as b on a.rang_name = b.rang_name

go

select * from task1


--�������, ������ ����� ������������� ���������� ����� �����

select top (1) with ties rang_name, quantity_of_win
from task1
order by quantity_of_win desc

--�������, ������ ����� ������������� ����� ������ ������� �����

select top (1) with ties rang_name, avg_place
from task1
order by avg_place desc

IF (OBJECT_ID('task2') IS NOT NULL)
DROP VIEW task2;

go
--������, ���������� ����������� �� ���� ������, ����������� ������� � ��������, 
--���������� �������� ����������� �� ���� ������, ���������� �������� �� ������

create view task2 (city, quantity_of_players, quantity_of_prize, quantity_of_prize_in_homeland)
as
select a.city, quantity_of_players, isnull(quantity_of_prize, 0) as quantity_of_prize, 
isnull(quantity_of_prize_in_homeland, 0) as quantity_of_prize_in_homeland
from 
(select count(distinct(tourney_player.player_id)) as quantity_of_players, city
from tourney
join tourney_player on tourney.tourney_id=tourney_player.tourney_id
join person on tourney_player.player_id = person.person_id
join city on person.city_id = city.city_id
group by city) as a left join
(select count(distinct(tourney_player.player_id)) as quantity_of_prize, city
from tourney
join tourney_player on tourney.tourney_id=tourney_player.tourney_id
join person on tourney_player.player_id = person.person_id
join city on person.city_id = city.city_id
where place < 4
group by city) as b on a.city = b.city
left join
(select count(distinct(tourney_player.player_id)) as quantity_of_prize_in_homeland, city
from tourney
join tourney_player on tourney.tourney_id=tourney_player.tourney_id
join person on tourney_player.player_id = person.person_id
join city on person.city_id = city.city_id
where place < 4 and tourney.city_id = person.city_id
group by city) as c on b.city = c.city

go

select * from task2

--������� ������, � ������� �� ���� �� ���������� ������ �� ���� �������

select city
from task2
where quantity_of_prize_in_homeland = 0

--������� ������, ��� ���������� ������� ������ ��������� �������� �� 1

select city
from task2
where quantity_of_players - quantity_of_prize = 1 

IF (OBJECT_ID('task_3') IS NOT NULL)
DROP VIEW task_3;

go

--�������, ���, ������� �����������, ������� ����� �� ��������, ���������� �������� ����

create view task_3([�������],[���],[��������],[������� �����],[���������� �������� ����])
as
select a.surname,a.name_,a.middle_name,[������� �����],isnull([����������],0) as [���������� �������� ����]
from
(select avg(place*1.0) as [������� �����], person_id, surname,name_,middle_name
from person
join tourney_player on person.person_id=tourney_player.player_id
group by person_id, surname,name_,middle_name) as a
left join
(select count(tourney_player.player_id) as [����������], person_id, surname,name_,middle_name
from person
join tourney_player on person.person_id=tourney_player.player_id
where place<4
group by person_id, surname, name_, middle_name) as b
on a.person_id=b.person_id

go

select * from task_3

--������� ������, � �������� ���������� �������� ���� �����������

select top(1) with ties [���������� �������� ����], [�������], [���], [��������]
from task_3 
order by [���������� �������� ����] desc

--������� ������, �����, ������� �� �������, �� ����� �������� � �������� ����������� ������� �����

select top (1) with ties [������� �����], [�������], [���], [��������], place, name_of_tourney
from task_3 join
person on task_3.[�������] = person.surname and task_3.[���] = person.name_ 
and task_3.[��������] = person.middle_name
join tourney_player on person.person_id = tourney_player.player_id
join tourney on tourney_player.tourney_id = tourney.tourney_id
order by [������� �����]

IF (OBJECT_ID('task_4') IS NOT NULL)
DROP VIEW task_4;

go

-- ��� �������: ������ ���, ����� ����� ��������, ����� ���� ����� �� ������ ���������, 
-- ����� ����� ������ � �� ����� ������
create view task_4
as
select surname, name_, middle_name, city, tourney.end_date_ as date_of_prize, rang_name, place,
name_of_tourney
from person
join city on person.city_id = city.city_id
join tourney_player on person.person_id = tourney_player.player_id
join tourney on tourney_player.tourney_id = tourney.tourney_id
join rang on person.person_id = rang.person_id
join rang_name on rang.rang_id = rang_name.rang_id
where place < 4 and rang.start_date_ < tourney.start_date_ and 
isnull(rang.end_date_, tourney.end_date_)  >= tourney.end_date_

go

select * from task_4

--������� ������� � �� ����� � ������� "������������ �����"

select surname, name_, middle_name, place
from task_4
where name_of_tourney = '������������ �����'
ORDER BY PLACE

--������� ������, ������� ����� ������ ���� �����������

select top (1) with ties date_of_prize, surname, name_, middle_name
from task_4
where place = 1
order by date_of_prize

--�������, ������ � ���������� � ���

IF (OBJECT_ID('task_5') IS NOT NULL)
DROP VIEW task_5;

go

create view task_5
as
select name_of_tourney, surname, name_, middle_name, city, gender, birth_date, email, telephone
from tourney
join tourney_player on tourney.tourney_id = tourney_player.tourney_id
join person on tourney_player.player_id = person.person_id
join city on person.city_id = city.city_id
join gender on person.gender_id = gender.gender_id
where place = 1
group by name_of_tourney, surname, name_, middle_name, city, gender, birth_date, email, telephone

go

select * from task_5


