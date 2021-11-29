--выбрать имена всех таблиц, созданных назначенным пользователем базы данных

select sys.objects.name as "TABLES"
from sys.objects
join sys.schemas
on sys.schemas.schema_id = sys.objects.schema_id
where sys.objects.type = 'U'
and sys.schemas.principal_id = DATABASE_PRINCIPAL_ID () -- приравниваем идентификатор участника, владеющего схемой, идентфикатору текущего участника
and sys.objects.name<>'sysdiagrams'
 
--выбрать имя таблицы, имя столбца таблицы, признак того, допускает ли данный столбец null-значения, 
--название типа данных столбца таблицы, размер этого типа данных - для всех таблиц, 
--созданных назначенным пользователем базы данных и всех их столбцов

select sys.objects.name as "TABLES"
,sys.columns.name as "COLUMN_NAME"
,sys.columns.is_nullable as "IS_NULL"
,sys.types.name as "TYPE"
,sys.columns.max_length as "LENGTH"
from sys.objects join sys.columns
on sys.columns.object_id = sys.objects.object_id
join sys.schemas
on sys.schemas.schema_id = sys.objects.schema_id
join sys.types
on sys.types.system_type_id = sys.columns.system_type_id
where sys.objects.type = 'U'
and sys.objects.name <> 'sysdiagrams'
and sys.schemas.principal_id = DATABASE_PRINCIPAL_ID ()


--выбрать название ограничения целостности (первичные и внешние ключи), имя таблицы, в которой оно находится, 
--признак того, что это за ограничение ('PK' для первичного ключа и 'F' для внешнего) - для всех ограничений целостности, 
--созданных назначенным пользователем базы данных 


select sysobj2.name as keys
,sysobj1.name as table_name
,sysobj2.[type]
from sys.objects as sysobj1 join sys.objects as sysobj2
on sysobj2.parent_object_id = sysobj1.object_id
join sys.schemas
on sysobj1.schema_id = sys.schemas.schema_id
where sysobj2.type in ('PK', 'F')
and sys.schemas.principal_id = DATABASE_PRINCIPAL_ID ()
and sysobj1.name <> 'sysdiagrams'

--выбрать название внешнего ключа, имя таблицы, содержащей внешний ключ, имя таблицы, содержащей его родительский ключ
-- - для всех внешних ключей, созданных назначенным пользователем базы данных 

select sys.foreign_keys.name as foreign_keys_name
,sysobj1.name as parent
,sysobj2.name as child
from sys.foreign_keys join sys.objects as sysobj1
on sys.foreign_keys.parent_object_id = sysobj1.object_id
join sys.objects as sysobj2
on sys.foreign_keys.referenced_object_id = sysobj2.object_id
join sys.schemas
on sys.schemas.schema_id = sysobj1.schema_id
where sys.schemas.principal_id = DATABASE_PRINCIPAL_ID ()

--выбрать название представления, SQL-запрос, создающий это представление - для всех представлений, 
--созданных назначенным пользователем базы данных 


select sys.objects.name as [object_name]
,sys.syscomments.text as syscomment_name
from sys.objects join sys.schemas
on sys.objects.schema_id = sys.schemas.schema_id
join sys.syscomments
on sys.syscomments.id = sys.objects.object_id
where sys.objects.type = 'V'
and sys.schemas.principal_id = DATABASE_PRINCIPAL_ID ()

--выбрать название триггера, имя таблицы, для которой определен триггер - для всех триггеров, 
--созданных назначенным пользователем базы данных

select trig.name as trig, table_.name as table_
from sys.objects as trig 
join sys.objects as table_ on
trig.parent_object_id = table_.object_id
join sys.schemas
on sys.schemas.schema_id = trig.schema_id
where sys.schemas.principal_id = DATABASE_PRINCIPAL_ID ()
and trig.type = 'TR'

go
CREATE TRIGGER test  ON  [city]
AFTER INSERT, UPDATE   
AS RAISERROR ('Notify Customer Relations', 16, 10);  

go
drop trigger test
