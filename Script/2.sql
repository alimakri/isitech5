use master;
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
USE [BD1]
GO
CREATE TABLE [dbo].Ville
(
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Libelle] [nvarchar](max) NOT NULL,
	CONSTRAINT [PK_Ville] PRIMARY KEY CLUSTERED (Id ASC)
) 
GO
CREATE TABLE [dbo].[Personne]
(
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Libelle] [nvarchar](max) NOT NULL,
	[Ville] [bigint] NOT NULL,
	CONSTRAINT [PK_Personne] PRIMARY KEY CLUSTERED (Id ASC)
) 
GO
ALTER TABLE [dbo].[Personne]  WITH CHECK ADD  CONSTRAINT [FK_Personne_Ville] FOREIGN KEY([Ville]) REFERENCES [dbo].[Ville] ([Id])
ALTER TABLE [dbo].[Personne] CHECK CONSTRAINT [FK_Personne_Ville]
GO


INSERT Ville (Libelle) values ('Lyon'), ('Marseille'), ('Paris')
select * from Ville

INSERT Personne(Libelle, Ville) values 
			('Pierre', 3),
			('Martine', 2),
			('Laurent', 1)

select * from Personne

SELECT Personne.Libelle AS NomPersonne, Ville.Libelle AS NomVille
FROM     Personne INNER JOIN
                  Ville ON Personne.Ville = Ville.Id

use AdventureWorks2017;

SELECT 
	Person.Person.BusinessEntityID, 
	Person.Person.FirstName, 
	Person.Person.LastName, 
	Person.Address.City
FROM     
	Person.Person 
	INNER JOIN Person.BusinessEntity ON Person.Person.BusinessEntityID = Person.BusinessEntity.BusinessEntityID 
	INNER JOIN Person.BusinessEntityAddress ON Person.BusinessEntity.BusinessEntityID = Person.BusinessEntityAddress.BusinessEntityID 
	INNER JOIN Person.Address ON Person.BusinessEntityAddress.AddressID = Person.Address.AddressID

SELECT Production.Product.ProductID, Production.Product.Name, Production.ProductSubcategory.Name AS Expr1, Production.ProductCategory.Name AS Expr2
FROM     Production.Product INNER JOIN
                  Production.ProductSubcategory ON Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID INNER JOIN
                  Production.ProductCategory ON Production.ProductSubcategory.ProductCategoryID = Production.ProductCategory.ProductCategoryID
use BD1;
select * from Ville
delete Ville where id=3
select * from Personne

delete Personne where id=1
