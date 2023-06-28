use BD1;
select * from Ville
select * from Personne

BEGIN TRAN
delete Personne where id=2
delete Ville where id=2
ROLLBACK TRAN
COMMIT TRAN