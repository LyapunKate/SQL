
SET STATISTICS IO ON
SET STATISTICS TIME ON

-- ��� �������
select cust.ContactName, ord.OrderDate, Freight 
from Customers AS cust
join Orders AS ord on ord.CustomerID = cust.CustomerID
where 

		Freight > 15 and
		cust.city = 'Lyon' and
		ord.OrderDate between '1997-01-01' and '1999-01-01'

CREATE CLUSTERED INDEX Customer_clustered ON Customers (CustomerID) --������� �� ���� � join
CREATE CLUSTERED INDEX Orders_clustered ON Orders (CustomerID) 

CREATE NONCLUSTERED INDEX Orders_nonclustered ON Orders(OrderDate, Freight) --������� �� ���� where
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


--��� �������:   ����� �� = 313 ��, ����������� ����� = 1460 ��, ����� ���������� ������ = 30328 
--� ��������:    ����� �� = 46 ��, ����������� ����� = 1022 ��, ����� ���������� ������ = 85.



--������ ��������������� ����������������� ������� �������� ��, 
--��� ��� �������� ������������� � ������������ ������� ���� �����������, ���� ��������. 
--����� �������, ������� ��� ������������� ����� ����� ������ ���� ���������������� ������.
--������� ������ - ��� ��������� � ������� �� ������. ������, �� ����� ��� �������� ��� ������ ������
