--Récupérer le total des ventes de chaque vendeur et son nom


select * from Sales.SalesOrderDetail
--SalesOrderID
select * from Sales.SalesOrderHeader
--BusinessEntityID
select * from Person.Person

select p.FirstName, p.LastName, SUM(OrderQty * UnitPrice)
from Sales.SalesOrderDetail d
inner join Sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
inner join Person.Person p on h.SalesPersonID = p.BusinessEntityID
GROUP BY p.FirstName, p.LastName
ORDER BY SUM(OrderQty * UnitPrice) desc


--CA par magasin par année

select * from Sales.SalesOrderDetail
--SalesOrderID
select * from Sales.SalesOrderHeader
--BusinessEntityID
select * from Sales.Store 

select st.BusinessEntityID, YEAR(OrderDate) Annee, SUM(OrderQty * UnitPrice) CA
from Sales.SalesOrderDetail d
inner join Sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
inner join Sales.Store st on h.SalesPersonID = st.SalesPersonID
group by st.BusinessEntityID, YEAR(OrderDate)
HAVING SUM(OrderQty * UnitPrice) > 1312199
order BY st.BusinessEntityID, YEAR(OrderDate)


--Quantité de produits vendus par les 3 meilleurs vendeurs

select h.SalesPersonID, SUM(OrderQty * UnitPrice)
FROM Sales.SalesOrderDetail d
inner join Sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
where h.SalesPersonID IN
(
	select TOP 3 p.BusinessEntityID, SUM(OrderQty * UnitPrice)
	from Sales.SalesOrderDetail d
	inner join Sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
	inner join Person.Person p on h.SalesPersonID = p.BusinessEntityID
	GROUP BY p.BusinessEntityID
	ORDER BY SUM(OrderQty * UnitPrice) desc
)
GROUP BY h.SalesPersonID

INSERT Vente (ID, Libelle, Prix)
select newid(), p.Name, ListPrice
FROM Production.Product p
INNER JOIN Production.ProductSubcategory s on p.ProductSubcategoryID = s.ProductSubcategoryID
INNER JOIN Production.ProductCategory c on c.ProductCategoryID = s.ProductCategoryID

INSERT Commande (ID, Commande, Produit, Qte, Prix, Vendeur)
SELECT newID(), h.SalesOrderID, d.ProductID, d.OrderQty, d.UnitPrice, h.SalesPersonID
FROM Sales.SalesOrderDetail d
INNER JOIN Sales.SalesOrderHeader h on h.SalesOrderID = d.SalesOrderID
WHERE h.SalesPersonID is not null

--Cette commande en utilisant la nouvelle table Commande
select p.FirstName, p.LastName, SUM(c.Qte * c.Prix)
from Commande c
inner join Person.Person p on c.Vendeur = p.BusinessEntityID
GROUP BY p.FirstName, p.LastName
ORDER BY SUM(c.Qte * c.Prix) desc

--Ajouter autorisation
ALTER AUTHORIZATION ON database::AdeventureWorks2017 TO [PITOU\alima];

--CA par cat et sous-cat : nom cat, nom souscat, CA -> trié par CA
SELECT c.Name, s.Name, COUNT(o.SalesOrderID) nb
FROM Sales.SalesOrderDetail o
INNER JOIN Production.Product p on o.ProductID = p.ProductID
INNER JOIN Production.ProductSubcategory s on p.ProductSubcategoryID = s.ProductSubcategoryID
INNER JOIN Production.ProductCategory c on s.ProductCategoryID = c.ProductCategoryID
GROUP BY c.Name, s.Name
ORDER BY COUNT(o.SalesOrderID) desc


