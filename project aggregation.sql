/*Write an SQL query to find the second
highest salary in the "Salary" table without using the LIMIT clause.*/


create database employee_table

create table employeDetails
(
emp_id int not null,
emp_name varchar(10) not null,
department varchar(10) not null,
salary int not null
)


insert into employeDetails
values
(1,'ann','sales',10000),
(2,'tom','sales',10000),
(3,'dijo','manager',20000),
(4,'david','production',11000),
(5,'teena','production',11000)

select * from employeDetails

select salary from (select ROW_NUMBER() over(order by salary desc) as row_nm, salary  from employeDetails)  temp where row_nm = 2 

select max(salary) from employeDetails where salary < ( select max(salary) from employedetails )
