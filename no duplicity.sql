/*Query the list of CITY names from the given
table that do not end with vowels. Your result
should not contain duplicate values.*/

create TABLE CITY_TABLE
(ID INT NOT NULL,
CITY VARCHAR(10) NOT NULL,
STATE VARCHAR(10) NOT NULL
)
alter table CITY_TABLE
alter column CITY VARCHAR(20) NOT NULL
alter table CITY_TABLE
alter column STATE VARCHAR(20) NOT NULL

INSERT INTO CITY_TABLE
VALUES
(1,'Delhi','Delhi'),
(2,'mumbai','maharashtra'),
(3,'Kolkāta','West Bengal'),
(4,'Bangalore','Karnātaka'),
(5,'Chennai','Tamil Nādu'),
(6,'Ahmedabad','Gujarāt'),
(7,'Sūrat','Gujarāt'),
(8,'Madurai','tamil nadu'),
(9,'Jodhpur','Rājasthān'),
(10,'kochi','kerala')

select distinct city from CITY_TABLE where city not like '%a'
and city not like '%e'
and city not like '%i'
and city not like '%o'
and city not like '%u'
