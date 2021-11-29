
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

CREATE CLUSTERED INDEX Customer_clustered ON Customers (CustomerID) --выводим на поля с join
CREATE CLUSTERED INDEX Orders_clustered ON Orders (CustomerID) 

CREATE NONCLUSTERED INDEX Orders_nonclustered ON Orders(OrderDate, Freight) --выводим на поля where
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


--Без индекса:   Время ЦП = 313 мс, затраченное время = 1460 мс, число логических чтений = 30328 
--С индексом:    Время ЦП = 46 мс, затраченное время = 1022 мс, число логических чтений = 85.



--Важной характеристикой кластеризованного индекса является то, 
--что все значения отсортированы в определенном порядке либо возрастания, либо убывания. 
--Таким образом, таблица или представление может иметь только один кластеризованный индекс.
--Некласт индекс - это указатели в листьях на реальн. данные, то нужна доп операция для извлеч данных
