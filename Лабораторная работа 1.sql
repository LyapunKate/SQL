

--Лабораторная работа №1 
--1: Выбрать среднемесячную стоимость покупки клиентовиз штата 'CA' (Калифорния) 
--(для каждого месяца вывести среднюю сумму покупок в этом месяце)

SELECT year(SALES_ORDER.ship_date) AS year, 
month(SALES_ORDER.ship_date) AS month, 
sum(SALES_ORDER.total)/COUNT(SALES_ORDER.ship_date) AS Middle
FROM CUSTOMER, SALES_ORDER
WHERE CUSTOMER.customer_id = SALES_ORDER.customer_id AND CUSTOMER.state = 'CA'
GROUP BY year(SALES_ORDER.ship_date), month(SALES_ORDER.ship_date)
ORDER BY year(SALES_ORDER.ship_date), month(SALES_ORDER.ship_date);

--правильный вариант

SELECT year(SALES_ORDER.ship_date) AS year, 
month(SALES_ORDER.ship_date) AS month, 
sum(SALES_ORDER.total)/COUNT(SALES_ORDER.ship_date) AS Middle
FROM CUSTOMER JOIN SALES_ORDER ON CUSTOMER.customer_id = SALES_ORDER.customer_id
WHERE CUSTOMER.state = 'CA'
GROUP BY year(SALES_ORDER.ship_date), month(SALES_ORDER.ship_date)
ORDER BY year(SALES_ORDER.ship_date), month(SALES_ORDER.ship_date);


--2: Вывести текущие цены всех продуктов на момент, 
--когда "WOMENS SPORTS" сделает свою первую покупку
SELECT actual_price ,description
FROM CUSTOMER
JOIN SALES_ORDER ON CUSTOMER.customer_id = SALES_ORDER.customer_id
JOIN ITEM ON SALES_ORDER.order_id=ITEM.order_id
JOIN PRODUCT ON PRODUCT.product_id=ITEM.product_id 
AND order_date=( SELECT min(order_date) FROM CUSTOMER
JOIN SALES_ORDER ON CUSTOMER.customer_id=SALES_ORDER.customer_id
WHERE name='WOMENS SPORTS')

SELECT PRICE.list_price,description
FROM CUSTOMER
JOIN SALES_ORDER ON CUSTOMER.customer_id = SALES_ORDER.customer_id
JOIN ITEM ON SALES_ORDER.order_id=ITEM.order_id
JOIN PRODUCT ON PRODUCT.product_id=ITEM.product_id 
JOIN PRICE ON PRODUCT.product_id=PRICE.product_id
AND PRICE.start_date<( SELECT min(order_date) FROM CUSTOMER
JOIN SALES_ORDER ON CUSTOMER.customer_id=SALES_ORDER.customer_id
WHERE name='WOMENS SPORTS') AND ( SELECT min(order_date) FROM CUSTOMER
JOIN SALES_ORDER ON CUSTOMER.customer_id=SALES_ORDER.customer_id
WHERE name='WOMENS SPORTS')<ISNULL (PRICE.end_date, 31/12/1999)

--3: Определить отдел, в котором средняя зарплата+комиссионные сотрудников минимальная
SELECT TOP (1) WITH TIES avg(EMPLOYEE.salary + ISNULL (EMPLOYEE.commission, 0)), 
DEPARTMENT.department_id
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.department_id = DEPARTMENT.department_id
GROUP BY DEPARTMENT.department_id
ORDER BY avg(EMPLOYEE.salary + ISNULL (EMPLOYEE.commission, 0))

--4: Определить, сколько в среднем платят менеджеру за одного подчиненого
SELECT MANAGER.SALARY/COUNT(MANAGER.LAST_NAME), MANAGER.LAST_NAME
FROM EMPLOYEE MANAGER, EMPLOYEE B
WHERE MANAGER.EMPLOYEE_ID=B.MANAGER_ID
GROUP BY MANAGER.LAST_NAME, MANAGER.SALARY
ORDER BY MANAGER.LAST_NAME, MANAGER.SALARY

SELECT MANAGER.SALARY, COUNT(MANAGER.LAST_NAME) AS NUMBER, MANAGER.LAST_NAME
FROM EMPLOYEE MANAGER, EMPLOYEE B
WHERE MANAGER.EMPLOYEE_ID=B.MANAGER_ID
GROUP BY MANAGER.LAST_NAME, MANAGER.SALARY
ORDER BY MANAGER.LAST_NAME, MANAGER.SALARY, COUNT(MANAGER.LAST_NAME)

SELECT * FROM EMPLOYEE 

