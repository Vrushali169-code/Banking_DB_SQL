/* LAB 1 */

show databases;
create database BankingDB;
use BankingDB;

-- create table
create table Customers(
	CustomerID INT primary key,
    FirstName varchar(50),
    LastName varchar(50),
    Email varchar(50),
    Phone bigint,
    AccountCreationDate Date
);

-- describe table
describe Customers;

/* LAB 2 */

-- Create Accounts Table
create table Accounts (
    AccountID int,
    AccountType varchar(20),
    Balance decimal(10,2)
);

-- Create Transactions Table
create table Transactions (
    TransactionID int,
    TransactionDate date,
    Amount decimal(10,2),
    TransactionType varchar(20)
);

-- Create Branches Table
create table Branches (
    BranchID int,
    BranchName varchar(100),
    BranchAddress varchar(200),
    BranchPhone varchar(15)
);

-- Create AccountBranches Table
create table AccountBranches ( 
		AssignmentDate date
);

-- Create Loans Table
create table Loans (
    LoanID int,
    LoanAmount decimal(10,2),
    InterestRate decimal(5,2),
    StartDate date,
    EndDate date
);

-- Alter Command

-- Add New Column 
alter table Customers add column DateOfBirth date;

-- Modify Existing Column
alter table Customers modify Phone varchar(20);

-- Add Constraint
alter table Accounts
add constraint chk_MinBalance
check (Balance >= 1000);

show create table accounts;

-- Delete Tables using DROP
drop table AccountBranches;

-- Add Primary key Constraint to CustomerID in Customers Table
alter table Customers add primary key (CustomerID);

-- Connect Accounts Table using CustomerID from Customers table.
alter table Accounts add CustomerID int;

alter table Accounts
add constraint FK_Accounts_Customers
foreign key (CustomerID)
references Customers(CustomerID);

-- Ensure that every customer must have a first name.
alter table Customers modify FirstName varchar(50) not null;

-- Ensure that each customer email is unique
alter table Customers add constraint uq_Email UNIQUE (Email);

/* Activity - connect Accounts and Branches */

-- apply PK to BranchId
alter table Branches add primary key (BranchID);

-- add BranchId to Accounts table
alter table Accounts add column BranchID int;

-- add FK relation between 
alter table Accounts
add constraint FK_Accounts_Branches
foreign key (BranchID)
references Branches(BranchID);

show create table Accounts;

describe Accounts;

-- connect Transactions and Accounts

-- apply PK to accountid of Accounts table
alter table Accounts add primary key (AccountID);

-- add accountid to Transactions table
alter table Transactions add column AccountId int;

-- add FK relation between Transactions and Accounts
alter table Transactions 
add constraint FK_Accounts_Transactions
foreign key(AccountID)
references Accounts(AccountID);

-- connect Loans to Customers

-- add CustomerID to loans table
alter table loans add column CustomerID int;

alter table Loans
add constraint FK_Customers_Loans
foreign key(CustomerID)
references Customers(CustomerID);

/* LAB 3 */

-- Insert Records into Customers Table
insert into Customers
(CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
values
(101,'Rahul','Sharma','rahul@gmail.com','9876543210','1998-04-15');

-- Insert Records into Accounts Table
insert into Accounts
(AccountID, CustomerID, AccountType, Balance)
values
(201,101,'Savings',25000);

select * from Customers;
select * from Accounts;

-- Insert 4 Records into Customers Table
insert into Customers
(CustomerID, FirstName, LastName, Email, Phone, DateOfBirth)
values
(102, 'Priya', 'Patil', 'priya@gmail.com', '9988776655', '2000-09-20'),
(103, 'Amit', 'Patel', 'amit.patel@gmail.com', '9876500001', '1995-06-18'),
(104, 'Sneha', 'Joshi', 'sneha.joshi@gmail.com', '9876500002', '1997-09-12'),
(105, 'Rohan', 'Kulkarni', 'rohan.k@gmail.com', '9876500003', '1993-11-25');

-- Insert 4 Records into Accounts Table
insert into Accounts
(AccountID, CustomerID, AccountType, Balance)
values
(202, 102, 'Current', 40000),
(203, 103, 'Savings', 35000),
(204, 104, 'Current', 60000),
(205, 105, 'Savings', 45000);

-- Insert 5 Records into Transactions Table
insert into Transactions
(TransactionID, AccountID, TransactionDate, Amount, TransactionType)
values
(301, 201, '2025-05-10', 5000, 'Deposit'),
(302, 202, '2025-05-11', 2500, 'Withdraw'),
(303, 203, '2025-05-12', 10000, 'Deposit'),
(304, 204, '2025-05-13', 3000, 'Withdraw'),
(305, 205, '2025-05-14', 7000, 'Deposit');

-- Insert 5 Records into Branches Table
insert into Branches
(BranchID, BranchName, BranchAddress, BranchPhone)
values
(1, 'Mumbai Branch', 'Andheri, Mumbai', '0221111111'),
(2, 'Pune Branch', 'Shivaji Nagar, Pune', '0202222222'),
(3, 'Nashik Branch', 'College Road, Nashik', '0253222222'),
(4, 'Nagpur Branch', 'Sitabuldi, Nagpur', '0712333333'),
(5, 'Navi Mumbai Branch', 'Vashi, Navi Mumbai', '0224444444');

-- Insert 5 Records into Loans Table
insert into Loans
(LoanID, LoanAmount, InterestRate, StartDate, EndDate, CustomerID)
values
(301, 500000, 8.50, '2025-01-15', '2030-01-15', 101),
(302, 300000, 9.25, '2025-02-10', '2028-02-10', 102),
(303, 750000, 8.75, '2025-03-20', '2032-03-20', 103),
(304, 250000, 10.00, '2025-04-05', '2029-04-05', 104),
(305, 1000000, 7.95, '2025-05-12', '2035-05-12', 105);

select * from Loans;

update Customers set Phone='9999999999' where CustomerID=101;

-- -- update email of customer 101
update Customers set Email='rahul.sharma@gmail.com' where CustomerID=101;

-- update balance of accountid 201 to 30000
select * from accounts;
update Accounts set balance = 30000 where AccountID = 201;

select * from Transactions;
delete from Transactions where TransactionID = 302;

select * from Accounts;
delete from Accounts where AccountID = 202;

/* LAB 4 */

-- View Complete Customer Information
select * from Customers;

-- View Only Required Customer Details
select FirstName, LastName, Email, Phone from Customers;

-- Activity

-- Retrieve only the following details from the Accounts table: AccountID, AccountType, and Balance.
select accountid, accounttype, balance from accounts;

-- Retrieve Customers with Savings Accounts
select * from Accounts where AccountType = 'Savings';

-- Retrieve Accounts with Balance Greater Than 25000
select * from Accounts where Balance > 25000;

-- Retrieve Transactions Between Specific Amounts
select * from Transactions where Amount between 5000 and 20000;

-- Retrieve Records for Selected Customers
select * from Customers where CustomerID in (101,102,103);

-- Search Customers Using Partial Name Matching
select * from Customers where FirstName like 'R%';

-- Activity

-- 1. Retrieve all current account records
select * from accounts;

-- 2.Find accounts with balance less than 15000
select * from accounts where balance < 15000;

-- 3.Display transactions between 1000 and 10000
select * from transactions where amount between 1000 and 10000;

-- 4.Retrieve customer records for CustomerID 104 and 105
select * from customers where CustomerID in (104,105);

-- 5.Display customers whose last name starts with S
select * from customers where lastname like "S%";

-- Display Customers in Alphabetical Order
select * from Customers order by FirstName asc;

-- Display Accounts with Highest Balance First
select * from Accounts order by Balance desc;

-- Retrieve Unique Account Types
select distinct AccountType from Accounts;

-- Display Top 3 Highest Balance Accounts
select * from Accounts order by Balance desc limit 3;

-- Skip Initial Records While Viewing Transactions
select * from Transactions limit 5 offset 2;

-- Activity

-- 1.Display customers sorted by LastName
select * from customers order by lastname asc;

-- 2.Retrieve top 5 transactions with highest amount
select * from transactions order by amount desc limit 5;

-- 3.Display unique transaction types
select distinct transactiontype from transactions;

-- 4.Skip the first 3 transaction records and display the next 4 records
select * from transactions limit 4 offset 3;

-- Find Customers Without Phone Numbers
select * from Customers where Phone is null;

-- Find Customers Having Email Addresses
select * from Customers where Email is not null;

-- Activity

-- 1.Find customers without email addresses
select * from customers where email is null;

-- 2.Display all accounts where balance information is available
select * from accounts where balance is not null;

-- Categorize Accounts Using Balance
select AccountID,
       Balance,
       case
           when Balance >= 50000 then 'Premium Account'
           when Balance >= 25000 then 'Standard Account'
           else 'Basic Account'
       end as AccountCategory
from Accounts;

-- Activity

/*Create a report that categorizes transactions as:
High Transaction
Medium Transaction
Low Transaction
based on transaction amount */

select * from transactions;
select transactionid , amount ,
	case
		when amount <=3000 then "low transaction"
        when amount <=5000 then "medium transaction"
        else "high transaction"
        end as transaction_status
from transactions;

-- Assign Rank Based on Account Balance
select AccountID,
       Balance,
       rank() over (order by Balance desc) as BalanceRank
from Accounts;

-- Calculate Running Total of Transactions
select TransactionID,
       Amount,
       sum(Amount) over (order by TransactionDate) as RunningTotal
from Transactions;

-- Display Average Transaction Amount
select TransactionID,
       Amount,
       avg(Amount) over () as AverageTransaction
from Transactions;

-- Activity

-- 1.Rank customers based on account balance
select customerid , balance ,
	rank() over(order by balance desc) as Balance_rank
from accounts;

-- 2.Generate running total for account balances
select accountid , balance ,
	sum(balance) over(order by accountid) as Running_balance
from accounts;

-- 3.Display maximum transaction amount using a window function
select * ,
	max(amount) over() as max_transaction_amount
from transactions;

/* LAB 5 */

-- Search Customers Whose First Name Starts with “A”
select * from Customers where FirstName like 'A%';

-- Search Customers Whose Email Contains “gmail”
select * from Customers where Email like '%gmail%';

-- Search Customers Whose Last Name Ends with “kar”

select * from Customers where LastName like '%kar';

/* Activity */

-- 1. Display customers whose first name starts with R
select * from Customers where FirstName like "R%";

-- 2. Find customers whose email contains yahoo
select * from Customers where email like "yahoo";

-- 3. Display customers whose last name starts with P
select * from Customers where LastName like "P%";

-- 4. Search customers whose phone number ends with 99
select * from Customers where phone like "%99";

-- Retrieve Records for Selected Account Types
select * from Accounts
where AccountType in ('Savings', 'Current');

-- Retrieve Transactions for Selected Transaction Types
select * from Transactions
where TransactionType in ('Deposit', 'Withdrawal');

-- Retrieve Records for Selected Customers
select * from Customers
where CustomerID in	 (101,102,105);

/* Activity */

-- 1. Display accounts belonging to Salary and Savings account types
select * from Accounts where AccountType in ('Savings', 'Salary');

-- 2. Retrieve transactions for Payment and Deposit categories
select * from Transactions where TransactionType in ("Payment", "Deposit");

-- 3. Display customer records for CustomerID 103 and 104
select * from Customers where customerid in (103,104);

-- 4. Retrieve selected account records using AccountID values
select * from accounts where accountid in (201,205);

-- Display Customers in Ascending Order of Last Name
select * from Customers order by  LastName asc;

-- Display Accounts with Highest Balance First
select * from Accounts order by Balance desc;

-- Display Transactions Sorted by Transaction Date
select * from Transactions order by TransactionDate desc;

/* ACTIVITY */

-- 1.Display customers sorted by FirstName
select * from customers order by firstname asc;

-- 2.Display accounts sorted by AccountType
select * from accounts order by accounttype asc;

-- 3.Display transactions sorted by Amount in descending order
select * from transations order by amount desc;

-- 4.Display customers sorted by DateOfBirth
select * from customers order by date_of_birth asc;

-- Display Only Top 5 Highest Balance Accounts
select * from Accounts order by Balance desc limit 5;

-- Display First 3 Customer Records
select * from Customers limit 3;

-- Skip Initial Transaction Records While Viewing Data
select * from Transactions limit 5 offset 3;

/* ACTIVITY */

-- 1.Display top 3 transactions with highest amount
select * from transactions order by amount desc limit 3;

-- 2.Retrieve only 4 customer records
select * from customers limit 4;

-- 3.Skip first 2 account records and display next 3 records
select * from accounts limit 3 offset 2;

-- 4.Display top 5 latest transactions
select * from transactions order by transactiondate desc limit 5;

-- Display Savings Account Customers Sorted by Balance
select * from Accounts where AccountType = 'Savings'
order by Balance desc;

-- Search Customers Using Partial Name and Limit Results
select * from Customers where FirstName LIKE 'S%' limit 5;

-- Display Selected Transactions in Sorted Order
select * from Transactions
where TransactionType in ('Deposit','Withdrawal')
order by TransactionDate desc;

/* LAB 6 */

-- Display customer Table
select * from customers;

-- Display all customer FirstName in uppercase.
select FirstName, upper(FirstName) as UpperCaseName from customers;

-- Display all customer FirstName in lowercase.
select FirstName, lower(FirstName) as LowerCaseName from customers;

-- Find the total number of characters in each customer FirstName .
select FirstName, length(FirstName) as NameLength from customers;

-- Display only the first three characters of customer FirstName .
select FirstName, left(FirstName,3) as Initials from customers;

-- Combine customer's FirstName with LastName.
select concat(FirstName,' - ',LastName) as FullName from customers;

/* MATH Functions */

select round(3.4) as rounded_value;
select ceil(1256.25) as Ceiling_Value;
select floor(1256.75) as Floor_Value;
select abs(-2500) as Absolute_Value;
select mod(25,4) as Remainder;

/* DATE Functions */

select * from customers;

-- Display the current system date.
select curdate();

-- Display the current system date and time.
select now();

-- Display the Birth of year
select CustomerID, year(DateOfBirth) as BirthYear from customers;

-- Display the Birth month.
select CustomerID, month (DateOfBirth) as BirthMonth from customers;

-- Calculate the number of days since BirthDate.
select CustomerID, datediff(curdate(),DateOfBirth) as Days from customers;

/* Comparison Functions */

-- Categorize customers as Adult or Young based on their birth year.
select FirstName, DateOfBirth,
if(year(DateOfBirth) <= 1995,'Adult','Young') 
as Category from Customers;

-- Display 'Not Available' if a phone number is NULL.
select FirstName,
ifnull(Phone, 'Not Available') as PhoneNumber
from Customers;

-- Find the latest birth date.
select greatest(
'2000-09-20',
'1995-06-18',
'1997-09-12',
'1993-11-25'
) as LatestBirthDate;

-- Find the earliest birth date.
select least(
'2000-09-20',
'1995-06-18',
'1997-09-12',
'1993-11-25'
) as EarliestBirthDate;

-- Compare two customer names.
select FirstName,
nullif(FirstName,'Priya') as Result
from Customers;

-- Aggregation Functions

-- Calculate the total balance maintained across all customer accounts.
select sum(Balance) as total_balance from Accounts;

-- Calculate the average balance maintained across all customer accounts
-- to understand the typical amount held by customers.
select avg(Balance) as average_balance
from Accounts;

-- Identify the highest balance maintained in any customer account.
select max(Balance) as highest_balance from Accounts;

-- Identify the lowest balance maintained in any customer account.
select min(Balance) as lowest_balance from Accounts;

-- Determine the total number of customer accounts available in the system.
select count(*) AS total_accounts from Accounts;

-- group by function

-- The bank wants to calculate the total account balance for 
-- each AccountType by grouping the records based on AccountType and identify
--  which account type is attracting the highest total deposits from customers.
select AccountType, SUM(Balance) AS TotalBalance
from Accounts group by AccountType;

-- The bank management wants to identify
-- only those account types whose total customer deposits exceed ₹25,000.
select AccountType,
SUM(Balance) AS TotalBalance
from Accounts
group by AccountType
having SUM(Balance) > 25000;


/* LAB 7 */

-- Task 1
-- window_function() 

-- Task 2: Rank Customer Loans Using RANK()
select LoanID,
CustomerID, LoanAmount, rank() over(
order by LoanAmount desc
) as LoanRank
from Loans;

-- Task 3: Rank Customer Loans Using DENSE_RANK()
select LoanID,
CustomerID, LoanAmount,
dense_rank() over(
order by LoanAmount desc
) as DenseRank
from Loans;

-- Task 4: Assign Row Numbers Using ROW_NUMBER()
select LoanID, CustomerID, LoanAmount,
row_number() over(
order by LoanAmount desc
) as RowNumber
from Loans;

-- Task 5: Understanding PARTITION BY
select LoanID, CustomerID, LoanAmount,
row_number() over(
partition by CustomerID
order by LoanAmount desc
) as RowNum
from Loans;

-- Task 6: Calculate Running Total Using SUM() OVER()
select LoanID, CustomerID,LoanAmount,
sum(LoanAmount) over(
order by LoanAmount desc
) as RunningTotal
from Loans;

-- Task 7: Compare Previous Loan Records Using LAG()
select LoanID, CustomerID, LoanAmount,
lag(LoanAmount) over(
order by LoanAmount desc
) as PreviousLoanAmount
from Loans;

-- Task 8: Compare Next Loan Records Using LEAD()
-- The LEAD() function retrieves the value from the next row in the result set.
-- It allows users to compare the current row with the following row without writing complex self-joins.
select LoanID, CustomerID, LoanAmount,
lead(LoanAmount) over(
order by LoanAmount desc
) as NextLoanAmount
from Loans;

/* LAB 8 */

-- Task 1: Generate Accounts Transaction Reports
select a.AccountID, a.AccountType, a.Balance,
t.TransactionID,
t.TransactionDate,
t.TransactionType,
t.Amount
from Accounts a
inner join Transactions t
on a.AccountID = t.AccountID;

-- Task 2: Display All Accounts Including Those Without Transactions
select a.AccountID, a.AccountType, a.Balance,
t.TransactionID,
t.TransactionDate,
t.TransactionType,
t.Amount
from Accounts a
left join Transactions t
on a.AccountID = t.AccountID;

-- Task 3: Generate Deposit Transaction Reports
select a.AccountID, a.AccountType, a.Balance,
t.TransactionID,
t.TransactionDate,
t.TransactionType,
t.Amount
from Accounts a
inner join Transactions t
on a.AccountID = t.AccountID
where t.TransactionType = 'Deposit';

-- Task 4: Generate High Balance Account Transaction Reports
select a.AccountID, a.AccountType, a.Balance,
t.TransactionID,  
t.TransactionDate,
t.TransactionType,
t.Amount
from Accounts a
inner join Transactions t
on a.AccountID = t.AccountID
where a.Balance > 30000
order by a.Balance desc;

/* LAB 9 */

-- Task 1: Identify Transactions Above the Average Transaction Amount
select * from Transactions
where Amount > (
    select avg(Amount)
    from Transactions
);

-- Task 2: Identify Accounts with Above-Average Balance
select AccountID, AccountType, Balance, CustomerID
from Accounts where Balance > (
    select avg(Balance)
    from Accounts
)
order by Balance desc;
	
-- Task 3: Identify Deposit Accounts Using a Multi-Row Subquery
select AccountID, AccountType, Balance, CustomerID
from Accounts where AccountID in (
    select AccountID
    from Transactions
    where TransactionType = 'Deposit'
);

-- Task 4: Identify the Account with the Highest Balance
select AccountID, AccountType, Balance, CustomerID
from Accounts where Balance = (
    select max(Balance)
    from Accounts
);

/* LAB 10 */

/* Syntax of creating view
create view .... select ....
*/

-- Task 1: Create a View for High-Balance Accounts
create view High_Balance_Accounts as
select AccountID, AccountType, Balance, CustomerID
from Accounts where Balance > 30000;

-- Task 2: Retrieve Data Using the View
select * from High_Balance_Accounts;

-- Task 3: Modify the View to Include Transaction Details
create or replace view High_Balance_Accounts as
select a.AccountID, a.AccountType, a.Balance, a.CustomerID,
t.TransactionID, t.TransactionDate, t.TransactionType, t.Amount
from Accounts a
inner join Transactions t
on a.AccountID = t.AccountID
where a.Balance > 30000;

-- Task 4: Generate Banking Reports Using the View
select AccountID, AccountType, Balance, CustomerID,
TransactionID, TransactionDate, TransactionType, Amount
from High_Balance_Accounts
order by Balance desc;


	