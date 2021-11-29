select concat(year(start_date_), substring(cast(100 + month(start_date_) as varchar), 2, 2), 
substring(cast(100 + day(start_date_) as varchar), 2, 2), 
substring(cast(10000000 + (select row_number() over (PARTITION BY cast(start_date_ as date) order by start_date_ ))
as varchar), 2, 7)) as kod
from rang






select cast(start_date_ as date) from 
rang 
select start_date_ from rang

