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