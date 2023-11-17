
/*Write an SQL query to find the employees
who have been with the company for more
than 5 years and have not received a
promotion.?*/

CREATE TABLE employee_table2
(
	emp_id int NOT NULL,
	emp_name varchar(20) NOT NULL,
	department varchar(20) NOT NULL,
	duration int not null
) 
alter table employee_table2
add promotion varchar(20) not null

select * from [employee_table2]

insert into employee_table2
values 
(1, 'emily', 'IT', 7,'promoted'),
(2, 'austin', 'finance', 6, '-'),
(3, 'luke', 'finance', 3, '-'),
(4, 'david', 'IT', 5, '-'),
(5, 'adam', 'accounting', 2, '-'),
(6, 'bella', 'sales', 8,'promoted'),
(7, 'john', 'marketing', 7, '-'),
(8, 'eva', 'IT', 5, '-'),
(9, 'carson', 'HR', 6, '-'),
(10, 'jose', 'marketing', 6, '-'),
(11, 'emily', 'manager', 7, '-'),
(12, 'austin', 'sales', 8,'promoted'),
(13, 'emily', 'marketing', 9,'promoted'),
(14, 'austin', 'marketing', 6, '-')

update [employee_table2]
set promotion = 'promoted'
where emp_id =7

delete from [employee_table2] where emp_id between 11 and  14

select emp_name from [employee_table2] where duration >5 and promotion = '-'