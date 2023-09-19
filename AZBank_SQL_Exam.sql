--1.Create AZBank database 
create database AZBank;
use AZBank;
go

--2.Create tables with constraints
drop table Customer
create table Customer (
	CustomerId int NOT NULL primary key ,
	Name nvarchar(50),
	City nvarchar(50),
	Country nvarchar(50),
	Phone nvarchar(15),
	Email nvarchar(50)
)
select * from Customer

drop table CustomerAccount
create table CustomerAccount (
	AccountNumber char(9) NOT NULL primary key,
	CustomerId int NOT NULL references Customer(CustomerId),
	Balance money NOT NULL,
	MinAccount money
)
select * from CustomerAccount

drop table CustomerTransaction
create table CustomerTransaction (
	TransactionId int NOT NULL primary key,
	AccountNumber char(9) references CustomerAccount(AccountNumber),
	TransactionDate  smalldatetime,
	Amount money,
	DepositorWithdraw bit
)
select * from CustomerTransaction


--3.Insert data 
insert into Customer values (1, 'Quoc Anh', N'Hanoi', N'Viet Nam', '0961056732', N'kieuquocanh4@gmail.com')
insert into Customer values (2, 'Quoc Viet', N'Hanoi', N'Viet Nam', '0961056731', N'kieuquocviet4@gmail.com')
insert into Customer values (3, 'Quoc Khanh', N'Hanoi', N'Viet Nam', '0961056730', N'kieuquockhanh4@gmail.com')
go
insert into CustomerAccount values ('abc123', 1 , 2000 , 100)
insert into CustomerAccount values ('abc456', 2 , 1500 , 50)
insert into CustomerAccount values ('abc789', 3 , 3000 , 75)
go
insert into CustomerTransaction values (1, 'abc789' , '2023-09-19 09:00:00' , 300,1)
insert into CustomerTransaction values (2, 'abc123' , '2023-09-17 06:00:00' , 500,1)
insert into CustomerTransaction values (3, 'abc456' , '2023-06-19 06:00:00' , 800,0)


--4.Get Cusomers living in Hanoi
select * from Customer where city = 'Hanoi';

--5.A query to get account information of the customers (Name, Phone, Email, AccountNumber, Balance)
select Name, Phone, Email, AccountNumber, Balance  
from Customer c
join CustomerAccount ca
on c.CustomerId = ca.CustomerId

--6 Adding Check Constraint
alter table CustomerTransaction 
add constraint c_k1 CHECK (Amount > 0 and Amount <= 1000000)

insert into CustomerTransaction values (5, 'abc123' , '2023-05-19 01:00:00' , 999999 ,0)

--7 Creating View 

create view vCustomerTransactions as

CREATE VIEW vCustomerTransactions AS

SELECT Name, ca.AccountNumber, TransactionDate, Amount, DepositorWithdraw
FROM Customer c
join CustomerAccount ca on c.CustomerId = ca.CustomerId
join CustomerTransaction ct on ca.AccountNumber = ct.AccountNumber



select * from Customer
select * from CustomerAccount
select * from CustomerTransaction
select * from vCustomerTransactions