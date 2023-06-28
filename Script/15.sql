
use BD1;
go
ALTER PROC EditVille(@data xml)
AS
	SELECT
		N.value('@op[1]', 'nvarchar(max)') op,
		N.value('@nom[1]', 'nvarchar(max)') nom,
		N.value('@id[1]', 'bigint') id
	INTO #t
	FROM
		@data.nodes('/villes/ville') AS T(N)
	IF Exists(select * from #t where op='Ajout')
		insert Ville (Libelle) select nom from #t where op='Ajout'

	IF Exists(select * from #t where op='Suppression')
		delete ville where Libelle in (select nom from #t where  op ='Suppression')
	
	IF Exists(select * from #t where op='Modif')
		update ville set Libelle=#t.nom 
			from #t inner join ville v on #t.id = v.Id and #t.op='Modif'
GO

Exec EditVille '
	<villes>
		<ville op="Ajout" nom="Paris"/> 
		<ville op="Suppression" nom="Strasbourg"/> 
		<ville op="Modif" id="2" nom="Marseille"/> 
		<ville op="Modif" id="1" nom="Lyon"/> 
	</villes>'
select * from Personne
select * from Ville
delete ville where id=6
delete Personne where id=4