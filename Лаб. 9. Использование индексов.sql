
SET STATISTICS IO ON
SET STATISTICS TIME ON

-- без индекса
select cust.ContactName, ord.OrderDate, Freight 
from Customers AS cust
join Orders AS ord on ord.CustomerID = cust.CustomerID
where 

		Freight > 15 and
		cust.city = 'Lyon' and
		ord.OrderDate between '1997-01-01' and '1999-01-01'

CREATE CLUSTERED INDEX Customer_clustered ON Customers (CustomerID) --выводим на пол€ с join
CREATE CLUSTERED INDEX Orders_clustered ON Orders (CustomerID) 

CREATE NONCLUSTERED INDEX Orders_nonclustered ON Orders(OrderDate, Freight) --выводим на пол€ where
CREATE NONCLUSTERED INDEX Customer_nonclustered ON Customers(city) INCLUDE(ContactName)

select cust.ContactName, ord.OrderDate, Freight 
from Customers AS cust
join Orders AS ord on ord.CustomerID = cust.CustomerID
where 
		Freight > 15 and
		cust.city = 'Lyon' and
		ord.OrderDate between '1997-01-01' and '1999-01-01'

DROP INDEX Customer_clustered ON Customers
DROP INDEX Orders_clustered ON Orders

DROP INDEX Orders_nonclustered ON Orders
DROP INDEX Customer_nonclustered ON Customers


--Ѕез индекса:   ¬рем€ ÷ѕ = 313 мс, затраченное врем€ = 1460 мс, число логических чтений = 30328 
--— индексом:    ¬рем€ ÷ѕ = 46 мс, затраченное врем€ = 1022 мс, число логических чтений = 85.



--¬ажной характеристикой кластеризованного индекса €вл€етс€ то, 
--что все значени€ отсортированы в определенном пор€дке либо возрастани€, либо убывани€. 
--“аким образом, таблица или представление может иметь только один кластеризованный индекс.
--Ќекласт индекс - это указатели в листь€х на реальн. данные, то нужна доп операци€ дл€ извлеч данных
