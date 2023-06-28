USE [AdventureWorks2017]
GO

/****** Object:  Table [dbo].[Commande]    Script Date: 07/03/2023 13:31:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Commande](
	[ID] [uniqueidentifier] NOT NULL,
	[Commande] [int] NOT NULL,
	[Produit] [int] NOT NULL,
	[Qte] [int] NOT NULL,
	[Prix] [money] NOT NULL,
	[Vendeur] [int] NOT NULL,
 CONSTRAINT [PK_Commande] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


