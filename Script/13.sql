ALTER PROC ListeProduitsXML(@data xml)
AS
	DECLARE @couleur nvarchar(15)
	DECLARE @seuil money
	DECLARE @type char(2)
	-- **************************************
	SELECT
		@couleur = N.value('@couleur[1]', 'nvarchar(15)'),
		@seuil = N.value('@seuil[1]', 'money'),
		@type = N.value('type[1]', 'char(2)')
	FROM
		@data.nodes('/produit') AS T(N)
	-- **************************************
	Select 
		ProductID, Name, Color, ListPrice, ProductNumber
	from 
		Production.Product
	where 
		(@couleur is null or Color=@couleur)
		and
		(@seuil is null or ListPrice > @seuil)
		and
		(@type is null or LEFT(ProductNumber, 2)=@type)
Go
Exec ListeProduitsXML '<produit couleur="Red" seuil="3000"><type>BK</type></produit>'
Exec ListeProduitsXML '<produit couleur="Blue"><type>BK</type></produit>'
Exec ListeProduitsXML '<produit couleur="Blue"></produit>'
Exec ListeProduitsXML '<produit/>'