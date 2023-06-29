ALTER PROC ListeProduit(@couleur nvarchar(15)=null, @seuil money=null)
AS
	SELECT Name, Color, ListPrice
	FROM Production.Product
	WHERE 
		(@couleur is null or Color LIKE @couleur)
	AND (@seuil is NULL OR ListPrice > @seuil)
GO

EXEC ListeProduit 'Black'
EXEC ListeProduit 'Red'
EXEC ListeProduit 'Red', 1000
EXEC ListeProduit @seuil=1000

ALTER PROC ListeProduitXML(@data XML)
AS
	DECLARE @couleur nvarchar(15)
	DECLARE @seuil money
	DECLARE @type nvarchar(2)
/***********************************************/
SELECT
	@couleur = N.value('@couleur[1]', 'nvarchar(15)'),
	@seuil = N.value('@seuil[1]', 'money'),
	@type = N.value('type[1]', 'char(2)')
FROM
	@data.nodes('/produit') AS T(N)

/***********************************************/
	SELECT Name, Color, ListPrice
	FROM Production.Product
	WHERE 
		(@couleur is null or Color LIKE @couleur)
	AND (@seuil is NULL OR ListPrice > @seuil)
	AND (@type is NULL OR LEFT(ProductNumber,2) = @type)
GO

EXEC ListeProduitXML
'<produit couleur="Black" seuil="1000">
	<type>BK</type>
</produit>
<test fze="bff"></test>'

--On veut récupérer la liste des Personnes de la table Person.Person en fonction de données XML
-- 1) Créer une procédure stockée qui affiche la liste des personnes
CREATE PROC ListPerson
AS
	SELECT *
	FROM Person.Person
GO
EXEC ListPerson
-- 2) Ajouter des paramètres (prenom, type)
ALTER PROC ListPerson(@nom nvarchar(MAX)=null, @type char(2)=null)
AS
	SELECT FirstName, LastName, PersonType, BusinessEntityID
	FROM Person.Person
	WHERE	(@nom IS NULL OR FirstName = @nom)
	AND
			(@type IS NULL OR PersonType = @type)
GO
EXEC ListPerson 'Ken', 'EM'
-- 3) Avec du XML
ALTER PROC ListPerson(@data xml)
AS
	DECLARE @nom nvarchar(15)
	DECLARE @type nvarchar(2)
/***********************************************/
SELECT
	@nom = N.value('@prenom[1]', 'nvarchar(15)'),
	@type = N.value('type[1]', 'char(2)')
FROM
	@data.nodes('/personne') AS T(N)
	SELECT FirstName, LastName, PersonType, BusinessEntityID
	FROM Person.Person
	WHERE	(@nom IS NULL OR FirstName = @nom)
	AND
			(@type IS NULL OR PersonType = @type)
GO
EXEC ListPerson
'<personne prenom="Ken">
	<type>EM</type>
</personne>'

--La liste des produits filtrée en fonction de la catégorie et de la sous-categorie
CREATE PROC ListProduit(@data XML)
AS
	DECLARE @cat nvarchar(max)
	DECLARE @souscat nvarchar(max)
SELECT
	@cat = N.value('categorie[1]', 'nvarchar(max)'),
	@souscat = N.value('sous-categorie[1]', 'nvarchar(max)')
FROM
	@data.nodes('/produit') AS T(N)

SELECT p.Name, c.Name, S.Name
FROM Production.Product p
	INNER JOIN Production.ProductSubcategory s ON p.ProductSubcategoryID = s.ProductSubcategoryID
	INNER JOIN Production.ProductCategory c ON c.ProductcategoryID = s.ProductCategoryID
WHERE
	(@souscat IS NULL OR @souscat = s.Name) AND
	(@cat IS NULL OR @cat = c.Name)
GO

ALTER PROC ListProduitTable(@data xml)
AS
SELECT
	N.value('categorie[1]', 'nvarchar(max)') Cat,
	N.value('sous-categorie[1]', 'nvarchar(max)') SousCat
INTO #t1
FROM
	@data.nodes('/produits/produit') AS T(N)
	
SELECT p.Name, c.Name, S.Name
FROM Production.Product p
	INNER JOIN Production.ProductSubcategory s ON p.ProductSubcategoryID = s.ProductSubcategoryID
	INNER JOIN Production.ProductCategory c ON c.ProductcategoryID = s.ProductCategoryID
	INNER JOIN #t1 ON (#t1.SousCat IS NULL OR s.Name = #t1.SousCat) 
		AND	(#t1.Cat IS NULL OR c.Name = #t1.Cat)
GO

EXEC ListProduitTable
'<produits>
	<produit>
		<categorie>Components</categorie>
		<sous-categorie>Road Frames</sous-categorie>
	</produit>
	<produit>
		<categorie>Bikes</categorie>
	</produit>
</produits>'

SELECT * from #t1

use BDTEST

ALTER PROC EditVille(@data xml)
AS
SELECT
	N.value('@op[1]', 'nvarchar(max)') op,
	N.value('@id[1]', 'bigint') id,
	N.value('@nom[1]', 'nvarchar(max)') lib
INTO #t1
FROM
	@data.nodes('/villes/ville') AS T(N)

IF EXISTS(SELECT * from #t1 where op='Suppression')
	DELETE Ville WHERE id IN (SELECT id FROM #t1 where op='Suppression')
IF EXISTS(SELECT * from #t1 where op='Ajout')
	INSERT INTO Ville (Libelle)
		SELECT lib from #t1 where op = 'Ajout'
IF EXISTS(SELECT * from #t1 where op='Modif')
	UPDATE Ville SET Libelle = #t1.lib
		FROM #t1 INNER JOIN Ville ON Ville.id = #t1.id
EXEC EditVille
'<villes>
	<ville op="Ajout" nom ="Sete"/>
	<ville op="Suppression" id="1"/>
	<ville op="Modif" id ="4" nom ="Montpellier"/>
</villes>'

--ajouter sete
--supprime paris
-- modifier bordeaux -> montpellier

use DBVOITURE

ALTER PROC EditVoiture(@data xml)
AS
SELECT
	N.value('@op[1]', 'nvarchar(max)') op,
	N.value('@table[1]', 'nvarchar(max)') tabl,
	N.value('@colonne[1]', 'nvarchar(max)') colonne,
	N.value('@nouveau[1]', 'nvarchar(max)') nouveau,
	N.value('@id[1]', 'bigint') id,
	N.value('@ui[1]', 'uniqueidentifier') ui,
	N.value('@nom[1]', 'nvarchar(max)') nom
INTO #t1
FROM
	@data.nodes('/voitures/voiture') AS T(N)

IF EXISTS(SELECT * from #t1 where op='Suppression')
	IF EXISTS(SELECT * from #t1 where op='Suppression' and tabl='piece')
		DELETE Piece WHERE id IN (SELECT ui FROM #t1 where op='Suppression' and tabl='piece')
	IF EXISTS(SELECT * from #t1 where op='Suppression' and tabl='modele')
		DELETE Modele WHERE id IN (SELECT id FROM #t1 where op='Suppression' and tabl='modele')
		--....
IF EXISTS(SELECT * from #t1 where op='Ajout')
	IF EXISTS(SELECT * from #t1 where op='Ajout' and tabl='marque')
		INSERT INTO Marque (Nom)
			SELECT nom from #t1 where op = 'Ajout' and tabl='marque'
---....
IF EXISTS(SELECT * from #t1 where op='Modif')
	IF EXISTS(SELECT * from #t1 where op='Modif' and tabl='modele')
		IF EXISTS(SELECT * from #t1 where op='Modif' and tabl='modele' and colonne='Puissance')
			UPDATE Modele SET Puissance = #t1.nouveau
				FROM #t1 INNER JOIN Modele ON Modele.id = #t1.id
--...
GO

EXEC EditVoiture
'<voitures>
	<voiture op="Ajout" table="marque" nom="BMW"/>
	<voiture op="Modif" table="modele" colonne="Puissance" id="1" nouveau="400"/>
	<voiture op="Suppression" table="piece" ui="EE842A14-A3B5-4CF2-947F-901E815B0365"/>
</voitures>'

--Ajouter Modele/Marque
--Modifier la puissance d'un modele
--Supprimer une piece