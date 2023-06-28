USE [BD1]
GO
CREATE TABLE [dbo].[Deplacement](
	[id] [uniqueidentifier] NOT NULL,
	[Piece] [uniqueidentifier] NOT NULL,
	[Depart] [char](2) NOT NULL,
	[Arrivee] [char](2) NOT NULL,
	[DateDeplacement] [datetime] NOT NULL,
	[Partie] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Deplacement] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Deplacement] ADD  CONSTRAINT [DF_Deplacement_id]  DEFAULT (newid()) FOR [id]
ALTER TABLE [dbo].[Deplacement] ADD  CONSTRAINT [DF_Deplacement_DateDeplacement]  DEFAULT (getdate()) FOR [DateDeplacement]
ALTER TABLE [dbo].[Deplacement]  WITH CHECK ADD  CONSTRAINT [FK_Deplacement_Partie] FOREIGN KEY([Partie]) REFERENCES [dbo].[Partie] ([id])
ALTER TABLE [dbo].[Deplacement] CHECK CONSTRAINT [FK_Deplacement_Partie]
ALTER TABLE [dbo].[Deplacement]  WITH CHECK ADD  CONSTRAINT [FK_Deplacement_Piece] FOREIGN KEY([Piece]) REFERENCES [dbo].[Piece] ([id])
ALTER TABLE [dbo].[Deplacement] CHECK CONSTRAINT [FK_Deplacement_Piece]
GO

CREATE TABLE [dbo].[Partie](
	[id] [uniqueidentifier] NOT NULL,
	[Joueur1] [nvarchar](max) NOT NULL,
	[Joueur2] [nvarchar](max) NOT NULL,
	[DateDebut] [datetime] NULL,
	[DateFin] [datetime] NULL,
 CONSTRAINT [PK_Partie] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[Partie] ADD  CONSTRAINT [DF_Partie_id]  DEFAULT (newid()) FOR [id]
GO

CREATE TABLE [dbo].[Piece](
	[id] [uniqueidentifier] NOT NULL,
	[Nom] [char](8) NOT NULL,
	[Couleur] [bit] NOT NULL,
	[Position] [char](2) NOT NULL,
 CONSTRAINT [PK_Piece] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Piece] ADD  CONSTRAINT [DF_Piece_id]  DEFAULT (newid()) FOR [id]
GO


INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 0, 'A2')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 0, 'B2')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 0, 'C2')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 0, 'D2')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 0, 'E2')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 0, 'F2')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 0, 'G2')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 0, 'H2')
INSERT INTO Piece (Nom, Couleur, Position) values ('Tour', 0, 'A1')
INSERT INTO Piece (Nom, Couleur, Position) values ('Tour', 0, 'H1')
INSERT INTO Piece (Nom, Couleur, Position) values ('Cavalier', 0, 'B1')
INSERT INTO Piece (Nom, Couleur, Position) values ('Cavalier', 0, 'G1')
INSERT INTO Piece (Nom, Couleur, Position) values ('Fou', 0, 'C1')
INSERT INTO Piece (Nom, Couleur, Position) values ('Fou', 0, 'F1')
INSERT INTO Piece (Nom, Couleur, Position) values ('Reine', 0, 'D1')
INSERT INTO Piece (Nom, Couleur, Position) values ('Roi', 0, 'E1')

INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 1, 'A7')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 1, 'B7')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 1, 'C7')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 1, 'D7')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 1, 'E7')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 1, 'F7')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 1, 'G7')
INSERT INTO Piece (Nom, Couleur, Position) values ('Pion', 1, 'H7')
INSERT INTO Piece (Nom, Couleur, Position) values ('Tour', 1, 'A8')
INSERT INTO Piece (Nom, Couleur, Position) values ('Tour', 1, 'H8')
INSERT INTO Piece (Nom, Couleur, Position) values ('Cavalier', 1, 'B8')
INSERT INTO Piece (Nom, Couleur, Position) values ('Cavalier', 1, 'G8')
INSERT INTO Piece (Nom, Couleur, Position) values ('Fou', 1, 'C8')
INSERT INTO Piece (Nom, Couleur, Position) values ('Fou', 1, 'F8')
INSERT INTO Piece (Nom, Couleur, Position) values ('Reine', 1, 'D8')
INSERT INTO Piece (Nom, Couleur, Position) values ('Roi', 1, 'E8')

SELECT * from PIECE where Position='B1'

INSERT INTO Partie (Joueur1, Joueur2, DateDebut, DateFin) values ('Marc', 'Bastien', getdate(), dateadd(Day,1,getdate()))

SELECT * from Partie

INSERT INTO Deplacement (Piece, Depart, Arrivee, DateDeplacement, Partie) 
	values ('3F50CA87-809B-4A50-80A4-3C798A203A0A','C7','C6',getdate(),'68B9C701-BB1B-4DFB-8CC3-D0CD09929C20')

select * from Deplacement

INSERT INTO Partie (Joueur1, Joueur2, DateDebut, DateFin) values ('Bruno', 'Patrick', getdate(), dateadd(Day,1,getdate()))

INSERT INTO Deplacement (Piece, Depart, Arrivee, DateDeplacement, Partie) 
	values ('6A29F6F2-665A-4AA5-8F57-9590F73643CB','C7','C6',getdate(),'0CAC9539-6BD7-4995-8ACA-B9B8EB7CBA1E')

