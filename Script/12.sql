ALTER PROC ListeProduits(@couleur nvarchar(15)=null, @seuil money=null, @type char(2)=null)
AS
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
Exec ListeProduits 'Red', '100'
Exec ListeProduits
Exec ListeProduits @seuil='3000'
Exec ListeProduits 'Red'
Exec ListeProduits @type='BK', @Couleur='RED', @seuil=2000