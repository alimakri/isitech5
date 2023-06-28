use AdventureWorks2017;
select COUNT(p.Name) n, c.Name Categorie 
from Production.Product p
left outer join Production.ProductSubcategory s on p.ProductSubcategoryID = s.ProductSubcategoryID
left outer join Production.ProductCategory c on s.ProductCategoryID = c.ProductCategoryID
group by c.Name

select SalesOrderID, OrderDate, SalesOrderNumber, SalesPersonID from Sales.SalesOrderHeader
select SalesOrderDetailID, SalesOrderID, OrderQty, UnitPrice, ProductID from Sales.SalesOrderDetail

-- Toutes les détails commandes
select h.SalesOrderNumber, p.Name, d.UnitPrice, d.OrderQty
from Sales.SalesOrderDetail d 
inner join Sales.SalesOrderHeader h on h.SalesOrderID = d.SalesOrderID
inner join Production.Product p on p.ProductID = d.ProductID

-- Toutes les commandes 
select h.SalesOrderNumber RefCommande, SUM(d.UnitPrice * d.OrderQty) Total
from Sales.SalesOrderDetail d 
inner join Sales.SalesOrderHeader h on h.SalesOrderID = d.SalesOrderID
inner join Production.Product p on p.ProductID = d.ProductID
GROUP BY h.SalesOrderNumber
order by Total desc

-- Toutes les commandes - Date, ref, total
select h.OrderDate DateCommande, h.SalesOrderNumber RefCommande, SUM(d.UnitPrice * d.OrderQty) Total
from Sales.SalesOrderDetail d 
inner join Sales.SalesOrderHeader h on h.SalesOrderID = d.SalesOrderID
inner join Production.Product p on p.ProductID = d.ProductID
GROUP BY h.SalesOrderNumber, h.OrderDate
order by Total desc

-- CA par produit
select p.Name Produit, SUM(d.UnitPrice * d.OrderQty) CA  
from Sales.SalesOrderDetail d 
inner join Production.Product p on p.ProductID = d.ProductID
GROUP BY p.Name
order by CA desc


