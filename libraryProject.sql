
--project librery

create table subject
(
subjectId int primary key  not null,
subjectnName varchar(20),
)

insert into subject values
(1,'maths' ),
(2,'science'),
(3,'evs'),
(4,'history'),
(5,'geography'),
(6,'stories')

select * from subject

create table department
(
departmentId int primary key not null,
departmentName varchar(20),
)


insert into department values
(1,'maths' ),
(2,'science'),
(3,'evs'),
(4,'history'),
(5,'geography')

select * from department

create table BookDetails
(
bookId int primary key not null,
bookName varchar(20) not null,
AuthorName varchar(64) NOT NULL,
SubjectID int NOT NULL,
Price int NULL
)
alter table bookdetails
drop column bookserialnumber,publisher

insert into BookDetails values
(1,'TheNoddySeries', 'Enid Blyton',1,789),
(2,'Talesfrom',' Panchtantra',4,1234),
(3,'KaradiTales',' Shobha Viswanath',3,876),
(4,'TheYoungVisitors',' Daisy Ashford',2,1356),
(5,'ThewindintheWillows','Kenneth Graham',5,8967),
(6,'TheTaleofMRTod','Beatrix Potter',4,8344),
(7,'GulliversTravels',' Jonathan Swift',5,865),
(8,'heFamousFiveSeries ',' Enid Blyton',1,8976)

select * from bookdetails

alter table bookdetails with check
add constraint fk_bookdetails_subject_subjectId FOREIGN KEY (subjectId)
references subject (subjectId)

create view bookreport 
as 
select B.bookname,B.authorname,S.subjectnName, B.price 
from bookdetails as B
inner join subject as S 
on B.subjectId = S.subjectId

create table BorrowerDetails
(
BorrowerId int primary key not null,
BorrowerName varchar(20) not null,
departmentId int not null,
BorrowerContact int NOT NULL,
Address varchar(64) NOT NULL,
)

insert into BorrowerDetails values
(1,'Ann',2,5678,'fcd'), 
(2,'Hazel',3,5678,'ghj'), 
(3,'Chris',5,4668,'yuj'), 
(4,'Marsha',2,357,'hki'), 
(5,'Olive',5,3478,'fki'), 
(6,'Barb',3,56890,'fcd'), 
(7,'Aida',1,1475,'lpo'),
(8,'tina',2,4276,'fcd'),
(9,'mariya',4,5678,'jdr'),
(10,'jecco',5,9087,'hyr')

alter table BorrowerDetails with check
add constraint fk_BorrowerDetails_department_departmentId foreign key (departmentId)
references department (departmentId)

select * from  BorrowerDetails

create view borrowerreport
AS
select   BD.Borrowername, BD.BorrowerContact, D.departmentName, BD.Address 
from BorrowerDetails as BD inner joint department as D
on BD.departmentId  = D.departmentId 


create table BookBorrowed
(
BookBorrowedID int primary key NOT NULL,
BookID int NOT NULL,
BorrowerID int NOT NULL,
BorrowedOn datetime NOT NULL,
DueDate datetime NOT NULL,
NumberOfCopies int NOT NULL,
ReturnStatus varchar(64) NOT NULL,
)
insert into BookBorrowed values
(1,3,5,2/6/2023,7/6/2023,1,'N'),
(2,4,3,6/7/2023,11/6/2023,1,'Y'),
(3,5,7,1/7/2023,6/7/2023,1,'Y'),
(4,6,9,19/7/2023,24/7/2023,1,'N')

select * from BookBorrowed

alter table BookBorrowed with check
add constraint fk_BookBorrowed_BookDetails_BookID foreign key( BookID)
references bookdetails (BookID )

alter table BookBorrowed with check
add constraint fk_BookBorrowed_BorrowerDetails_BorrowerID  foreign key( BorrowerID )
references BorrowerDetails (BorrowerID)


create view borroweDBOOKrreport
AS
select   B.BookName, BD.BorrowerName, BD.BorrowerContact, B.AuthorName, BB.BorrowedOn, BB.DueDate  
from BookBorrowed as BB inner join BookDetails as B 
on BB.BookID = B.BookID 
INNER JOIN BorrowerDetails as BD 
on bb.BorrowerID = bd.BorrowerID


CREATE PROCEDURE BorrowNewBook
@BookName Varchar(32),
@BorrowerName Varchar(32)
AS
BEGIN
	declare @bid int = NULL , @brid int = NULL, @bbid int = 1
	select @bbid = max(bookborrowedid)+1 from BookBorrowed
	IF NOT EXISTS (select * from BookDetails where BookName = @BookName)
	BEGIN
		Print 'Book does not exist in the library: ' + @BookName
	END
	ELSE
	BEGIN
		select @bid = BookID from BookDetails where BookName = @BookName
	END
	IF NOT EXISTS (select * from BorrowerDetails where BorrowerName = @BorrowerName)
	BEGIN
		Print 'Not a member of the library: ' + @BorrowerName
	END
	ELSE
	BEGIN
		select @brid = BorrowerID from BorrowerDetails where BorrowerName = @BorrowerName
	END
	IF (@bid IS NOT NULL) AND (@brid IS NOT NULL)
	BEGIN
		INSERT INTO BookBorrowed (BookBorrowedID, bookid, BorrowerID, BorrowedOn, DueDate, NumberOfCopies, ReturnStatus)
		Values(@bbid, @bid, @brid, getdate(), dateadd(day, 3, getdate()), 1, 'N')
	END
	else
	begin
		Print 'Validation error... Hence book can not be borrowed...'
	end
end


create procedure BookBorrowerDetails
@BookName varchar (20),
@BorrowerDetails varchar (20)
AS
BEGIN
declare @boid int = null, @brid int = null, @bobrid int = null, @duedate datetime 
select @brid = BorrowerId from BorrowerDetails where BorrowerName = @BorrowerDetails
select @boid = bookId from BookDetails where bookName = @BookName
select @bobrid = BookBorrowedID  from BookBorrowed where bookId = @boid and BorrowerId = @brid 
select @duedate = DueDate from BookBorrowed where BookBorrowedID = @bobrid

if (@duedate < GETDATE())
begin
 print 'due date is over - applay penalty'
 update bookborrowed set returnstatus = 'N' where BookBorrowedID = @bobrid
end
else
begin
print 'returned within duedate - no penality'
update BookBorrowed set ReturnStatus = 'Y' where BookBorrowedID = @bobrid 
end
end
