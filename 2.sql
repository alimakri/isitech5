USE [master]
GO

/****** Object:  Database [DBVOITURE]    Script Date: 26/06/2023 17:10:21 ******/
CREATE DATABASE [DBVOITURE]
 ON  PRIMARY 
( NAME = N'DBVOITURE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\DBVOITURE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBVOITURE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\DBVOITURE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

USE [DBVOITURE]
GO

/****** Object:  Table [dbo].[Marque]    Script Date: 26/06/2023 17:09:11 ******/

CREATE TABLE [dbo].[Marque](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](max) NULL,
 CONSTRAINT [PK_Marque] PRIMARY KEY CLUSTERED 
(
	[id] ASC
))
GO

USE [DBVOITURE]
GO

/****** Object:  Table [dbo].[Modele]    Script Date: 26/06/2023 17:09:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Modele](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[Marque] [bigint] NOT NULL,
	[Puissance] [nvarchar](max) NULL,
	[Categorie] [nvarchar](max) NULL,
	[Nom] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Modele] PRIMARY KEY CLUSTERED 
(
	[id] ASC
))
GO

ALTER TABLE [dbo].[Modele]  WITH CHECK ADD  CONSTRAINT [FK_Modele_Marque] FOREIGN KEY([Marque])
REFERENCES [dbo].[Marque] ([id])
GO

ALTER TABLE [dbo].[Modele] CHECK CONSTRAINT [FK_Modele_Marque]
GO

USE [DBVOITURE]
GO

/****** Object:  Table [dbo].[Piece]    Script Date: 26/06/2023 17:10:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Piece](
	[id] [uniqueidentifier] NOT NULL,
	[Modele] [bigint] NOT NULL,
	[Nom] [nvarchar](max) NULL,
	[Type] [nvarchar](max) NULL,
 CONSTRAINT [PK_Piece] PRIMARY KEY CLUSTERED 
(
	[id] ASC
))
GO

ALTER TABLE [dbo].[Piece] ADD  CONSTRAINT [DF_Piece_id]  DEFAULT (newid()) FOR [id]
GO

ALTER TABLE [dbo].[Piece]  WITH CHECK ADD  CONSTRAINT [FK_Piece_Modele] FOREIGN KEY([Modele])
REFERENCES [dbo].[Modele] ([id])
GO

ALTER TABLE [dbo].[Piece] CHECK CONSTRAINT [FK_Piece_Modele]
GO

use DBVOITURE
INSERT INTO Marque (Nom) VALUES
('Audi'), ('Skoda'), ('Ferrari'), ('Lamborghini'), ('Renault')

INSERT INTO Modele (Marque, Puissance, Categorie, Nom) VALUES
(1,'450','Sportive', 'RS3'),
(2, '75', 'Citadine', 'Fabia'),
(3,'725','Sportive','Purosangue'),
(4, '740','Sportive','Aventador'),
(5,'140','SUV','Arkana')

INSERT INTO Piece (Modele,Nom,Type) VALUES
(1,'X64F54', 'Volant'),
(1, 'F84F', 'Moteur'),
(3,'KOE52','Embrayage'),
(4, 'FBEFE5485','Volant'),
(4,'FBEN845','Airbag'),
(2,'UFHE85', 'Jante')

--Toutes les pièces des voitures qui ont comme marque Audi
Select p.Nom, Type, ma.Nom
FROM Piece p
INNER JOIN Modele mo on p.Modele = mo.id
INNER JOIN Marque ma on mo.Marque = ma.id
WHERE ma.Nom = 'Audi'

SELECT Piece.Nom, Piece.Type, Marque.Nom AS Expr1
FROM Marque
INNER JOIN Modele ON Marque.id = Modele.Marque 
INNER JOIN Piece ON Modele.id = Piece.Modele
WHERE (Marque.Nom = N'Audi')
