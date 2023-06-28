use BD1;
select * from Personne
select * from Ville

Insert Ville (Libelle) values('Paris'), ('Bordeaux')
Insert Personne (Libelle, Ville) values('Pierre', 4)

select * from Personne p inner join Ville v on p.Ville=v.Id
select * from Ville v inner join Personne p on p.Ville=v.Id

select * from Ville v left outer join Personne p on p.Ville=v.Id

Insert Personne (Libelle) values('Xavier')

select * from Ville v right outer join Personne p on p.Ville=v.Id

select * from Ville v full outer join Personne p on p.Ville=v.Id

use AdventureWorks2017;
SELECT 
	Person.Person.BusinessEntityID, 
	Person.Person.FirstName, 
	Person.Person.LastName, 
	Person.Address.City
FROM     
	Person.Address 
	RIGHT OUTER JOIN Person.BusinessEntityAddress ON Person.Address.AddressID = Person.BusinessEntityAddress.AddressID 
	RIGHT OUTER JOIN Person.BusinessEntity ON Person.BusinessEntityAddress.BusinessEntityID = Person.BusinessEntity.BusinessEntityID 
	RIGHT OUTER JOIN Person.Person ON Person.BusinessEntity.BusinessEntityID = Person.Person.BusinessEntityID

SELECT 
	p.BusinessEntityID id, 
	p.FirstName Prenom, 
	p.LastName Nom, 
	a.City Ville
FROM     
	Person.Address a
	RIGHT OUTER JOIN Person.BusinessEntityAddress bea ON a.AddressID = bea.AddressID 
	RIGHT OUTER JOIN Person.BusinessEntity be ON bea.BusinessEntityID = be.BusinessEntityID 
	RIGHT OUTER JOIN Person.Person p ON be.BusinessEntityID = p.BusinessEntityID
Order by Ville

select p.Name Produit, c.Name Categorie 
from Production.Product p
left outer join Production.ProductSubcategory s on p.ProductSubcategoryID = s.ProductSubcategoryID
left outer join Production.ProductCategory c on s.ProductCategoryID = c.ProductCategoryID
