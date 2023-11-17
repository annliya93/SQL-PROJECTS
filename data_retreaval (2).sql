/*Write an SQL query to retrieve the names of
employees who have worked in at least
three different departments.*/

CREATE TABLE employee_table
(
	emp_id int NOT NULL,
	emp_name varchar(20) NOT NULL,
	department varchar(20) NOT NULL,
	salary int NOT NULL
) 

select * from [employee_table]

insert into employee_table
values 
(1, 'emily', 'IT', 145645),
(2, 'austin', 'finance', 95400),
(3, 'luke', 'finance', 41000),
(4, 'david', 'IT', 53000),
(5, 'adam', 'accounting', 113500),
(6, 'bella', 'sales', 120500),
(7, 'john', 'marketing', 65000),
(8, 'eva', 'IT', 90500),
(9, 'carson', 'HR', 113500),
(10, 'jose', 'marketing', 80000),
(11, 'emily', 'sales', 145645),
(12, 'austin', 'sales', 95400),
(13, 'emily', 'marketing', 145645),
(14, 'austin', 'marketing', 95400)

update [employee_table]
set emp_id = 1 where emp_name = 'emily'

update [employee_table]
set emp_id = 2 where emp_name = 'austin'

select emp_name from employee_table group by emp_name having count (department) >=3