CREATE PROC Pilote_MAJ(@id bigint, @nouveauPrenom nvarchar(max))
AS
	Update Pilote set Prenom=@nouveauPrenom where idPilote=@id
GO
select * from Pilote