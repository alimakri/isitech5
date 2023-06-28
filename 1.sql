use AdventureWorks2017
GO
SELECT * FROM [PITOU\SQLEXPRESS].AdventureWorks2017.Person.Person
SELECT * FROM Person.Person

SELECT *
FROM Person.Person
WHERE FirstName='Ken'

USE [master]
GO

/****** Object:  Database [BDTEST]    Script Date: 26/06/2023 11:27:45 ******/
CREATE DATABASE [BDTEST]
 ON  PRIMARY 
( NAME = N'BDTEST', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BDTEST.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BDTEST_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BDTEST_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

select newid()

USE [BDTEST]
GO

/****** Object:  Table [dbo].[Personne]    Script Date: 26/06/2023 11:53:45 ******/
CREATE TABLE [dbo].[Personne](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](max) NULL,
	[Ville] [bigint] NULL,
 CONSTRAINT [PK_Personne] PRIMARY KEY CLUSTERED 
(
	[id] ASC
))
GO


USE [BDTEST]
GO

/****** Object:  Table [dbo].[Ville]    Script Date: 26/06/2023 11:58:18 ******/
CREATE TABLE [dbo].[Ville](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[Libelle] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Ville] PRIMARY KEY CLUSTERED 
(
	[id] ASC
))

USE [BDTEST]
GO

/****** Object:  Table [dbo].[Personne]    Script Date: 26/06/2023 12:10:46 ******/

ALTER TABLE [dbo].[Personne]  WITH CHECK ADD  CONSTRAINT [FK_Personne_Ville] FOREIGN KEY([Ville])
REFERENCES [dbo].[Ville] ([id])
GO

ALTER TABLE [dbo].[Personne] CHECK CONSTRAINT [FK_Personne_Ville]
GO

INSERT INTO Ville (Libelle) VALUES
('Paris'),('Lyon'),('Marseille')

INSERT INTO Personne (Nom, Ville) VALUES 
('Paul', 1), ('Lionel', 2), ('Mohammed', 3)

INSERT INTO Personne (Nom, Ville) VALUES 
('Mohammed', 4)

use BDTEST
select * from Personne
select * from Ville

select * 
from Personne,Ville 
where Personne.Ville = Ville.id and Ville.ID = 2

SELECT *
FROM Personne
INNER JOIN Ville ON Personne.Ville = Ville.id
--WHERE Ville.ID = 2
WHERE Ville.Libelle = 'Lyon'

INSERT INTO Ville (Libelle) VALUES
('Bordeaux')

INSERT INTO Personne (Nom) VALUES 
('Jacques')

SELECT *
FROM Personne
INNER JOIN Ville ON Personne.Ville = Ville.id

SELECT *
FROM Personne RIGHT OUTER JOIN Ville ON Personne.Ville = Ville.id

SELECT *
FROM Personne LEFT OUTER JOIN Ville ON Personne.Ville = Ville.id

SELECT *
FROM Personne FULL JOIN Ville ON Personne.Ville = Ville.id

USE AdventureWorks2017

SELECT FirstName, LastName, City
FROM Person.Person p
INNER JOIN Person.BusinessEntityAddress bea ON p.BusinessEntityID = bea.BusinessEntityID
INNER JOIN Person.Address a ON bea.AddressID = a.AddressID
WHERE City = 'Seattle'

/*** ProductID, Nom, subcategory, category, couleur
Produit couleur 'Red' ***/
SELECT ProductID, p.Name, p.ProductSubcategoryID, c.Name, Color
FROM Production.Product AS p
INNER JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID 
INNER JOIN Production.ProductCategory c ON ps.ProductCategoryID = c.ProductCategoryID
WHERE Color LIKE 'Red'

select 1 col1, 'ABC' col2, getdate() col3, newid() col4

select * into #t1 from
(
select 'A1' lettre, 1 lien
UNION ALL
select 'B1', 2 
UNION ALL
select 'C1', 3 
UNION ALL
select 'D1', 4 
) t

SELECT 1 col1 into ##t1

select * from #t1

use AdventureWorks2017

SELECT Count(ProductID), Color
FROM Production.Product AS p
INNER JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID 
INNER JOIN Production.ProductCategory c ON ps.ProductCategoryID = c.ProductCategoryID
GROUP BY Color
HAVING Color LIKE 'Red'

SELECT FirstName, LastName, City
FROM Person.Person p
INNER JOIN Person.BusinessEntityAddress bea ON p.BusinessEntityID = bea.BusinessEntityID
INNER JOIN Person.Address a ON bea.AddressID = a.AddressID
WHERE City = 'Seattle'

--Groupe par ville + nb de personne par ville + filtre seulement les villes avec + de 30
SELECT COUNT(p.BusinessEntityID) NB, City --5
FROM Person.Person p --1
INNER JOIN Person.BusinessEntityAddress bea ON p.BusinessEntityID = bea.BusinessEntityID 
INNER JOIN Person.Address a ON bea.AddressID = a.AddressID
--WHERE 2
GROUP BY a.City --3
HAVING COUNT(p.BusinessEntityID) > 30 --4

-- Production.Product.ProductID -> Sales.SalesOrderDetail.ProductID
-- Groupe par Produit avec la somme des CA
-- Seulement ceux qui dépasse 10.000
SELECT CAST(SUM(OrderQty * UnitPrice) AS VARCHAR(30)) + ' $' CA, p.Name
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY p.ProductID, p.Name
HAVING SUM(OrderQty * UnitPrice) > 10000

SELECT SUM(OrderQty * UnitPrice) CA, p.Name --4
FROM Production.Product p --1
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY p.ProductID, p.Name --2
HAVING SUM(OrderQty * UnitPrice) > 10000 --3
ORDER BY CA DESC --5

use BDTEST;
select * from Ville
select * from Personne

BEGIN TRAN
delete Personne where id=2
delete Ville where id=2
ROLLBACK TRAN
COMMIT TRAN

USE AdventureWorks2017

select newid()