--Avion -> idAvion, Modele, Compagnie
--Pilote -> idPilote, Nom, Prenom, DateNaissance
--Vol -> idVol, DateDepart, DateArrivee, idAvion, idPilote, LieuDepart, LieuArrivee

-- Clés primaires / étrangères

-- Remplir les tables avec C#

-- Fonction qui récupère le pilote sur un vol
-- Fonction qui récupère Pilotes ayant opéré pour compagnie (donné en paramètre)
-- Fonction qui donne tous les vols avec nom pilote et modele de l'avion qui ont pour Depart l'argument
	-- Func(LieuDepart)
		--> ListeVols, Pilotes
delete Pilote where idPilote = 1
select * from Pilote where idPilote = 4
insert into Pilote (Nom,prenom,DateNaissance) values ('A','B',convert(datetime,'24/03/2002 02:00:00',103)
delete Vol

select * from Vol inner join Avion on vol.idAvion = avion.idAvion inner join Pilote on vol.idPilote = Pilote.idPilote
------------------------------------------------------------------------------------------------

USE [BD1]
GO

/****** Object:  Table [dbo].[Pilote]    Script Date: 09/03/2023 12:06:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Pilote](
	[idPilote] [bigint] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](max) NOT NULL,
	[Prenom] [nvarchar](max) NOT NULL,
	[DateNaissance] [datetime] NOT NULL,
 CONSTRAINT [PK_Pilote] PRIMARY KEY CLUSTERED 
(
	[idPilote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

USE [BD1]
GO

/****** Object:  Table [dbo].[Avion]    Script Date: 09/03/2023 12:07:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Avion](
	[idAvion] [bigint] IDENTITY(1,1) NOT NULL,
	[Modele] [nvarchar](max) NOT NULL,
	[Compagnie] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Avion] PRIMARY KEY CLUSTERED 
(
	[idAvion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

USE [BD1]
GO

/****** Object:  Table [dbo].[Vol]    Script Date: 09/03/2023 12:07:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Vol](
	[idVol] [bigint] IDENTITY(1,1) NOT NULL,
	[DateDepart] [datetime] NOT NULL,
	[DateArrivee] [datetime] NOT NULL,
	[idAvion] [bigint] NOT NULL,
	[idPilote] [bigint] NOT NULL,
	[LieuDepart] [nvarchar](max) NOT NULL,
	[LieuArrivee] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Vol] PRIMARY KEY CLUSTERED 
(
	[idVol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Vol]  WITH CHECK ADD  CONSTRAINT [FK_Vol_Avion] FOREIGN KEY([idAvion])
REFERENCES [dbo].[Avion] ([idAvion])
GO

ALTER TABLE [dbo].[Vol] CHECK CONSTRAINT [FK_Vol_Avion]
GO

ALTER TABLE [dbo].[Vol]  WITH CHECK ADD  CONSTRAINT [FK_Vol_Pilote] FOREIGN KEY([idPilote])
REFERENCES [dbo].[Pilote] ([idPilote])
GO

ALTER TABLE [dbo].[Vol] CHECK CONSTRAINT [FK_Vol_Pilote]
GO

