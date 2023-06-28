ALTER PROC ListePersonneXML(@data xml)
AS
	SELECT
		N.value('@prenom[1]', 'nvarchar(15)') prenom,
		N.value('@type[1]', 'char(2)') PersonType
	INTO #t
	FROM
		@data.nodes('/personnes/personne') AS T(N)
	
	select BusinessEntityID, FirstName, LastName, p.PersonType  
	from Person.Person p
	inner join #t on p.FirstName = #t.prenom and (#t.PersonType is null or p.PersonType = #t.PersonType)
Go
Exec ListePersonneXML 
	'<personnes>
		<personne prenom="Marie"/>
		<personne prenom="Mary" type="EM"/>
		<personne prenom="Robert" type="IN"/>
	</personnes>'


