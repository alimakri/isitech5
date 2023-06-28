use master;
DROP DATABASE BD1;
CREATE DATABASE [BD1] ON PRIMARY
	( 
	NAME = N'BD1', 
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BD1.mdf' , 
	SIZE = 8192KB , 
	FILEGROWTH = 65536KB 
	)
 LOG ON 
	( 
	NAME = N'BD1_log', 
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BD1_log.ldf' , 
	SIZE = 8192KB , 
	FILEGROWTH = 65536KB 
	)
GO

select * from sys.sysdatabases

use AdventureWorks2017
go
select * from Person.Person; select * from Production.Product
select * from Person.Person for XML Auto
