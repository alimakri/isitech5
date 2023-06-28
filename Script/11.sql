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

