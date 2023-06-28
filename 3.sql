use AdventureWorks2017

SELECT TOP 3 SalesPersonID
INTO #t1
FROM     Sales.SalesOrderDetail INNER JOIN
         Sales.SalesOrderHeader ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
ORDER BY COUNT(OrderQty * UnitPrice) DESC

SELECT FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID IN (SELECT * FROM #t1)

-- On veut récupérer les 3 meilleurs vendeurs de cette année (personID)
SELECT FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID IN (
SELECT TOP 3 SalesPersonID
FROM     Sales.SalesOrderDetail INNER JOIN
         Sales.SalesOrderHeader ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
ORDER BY COUNT(OrderQty * UnitPrice) DESC)
/***
On veut récupérer le nom des 3 meilleurs magasins
	Sales.SalesOrderDetail -> Sales.SalesOrderHeader (SalesOrderID)
	Sales.Customer ->
	Sales.SalesOrderHeader -> Sales.Store (SalesPersonID)
Avec ces 3 magasins, on récupère le nom
2 requêtes imbriquées
***/
SELECT st.Name
FROM Sales.Store st
WHERE st.BusinessEntityID IN (
SELECT TOP 3 st.BusinessEntityID
FROM Sales.SalesOrderDetail 
INNER JOIN Sales.SalesOrderHeader soh ON Sales.SalesOrderDetail.SalesOrderID = soh.SalesOrderID
INNER JOIN Sales.Customer c ON c.CustomerID = soh.CustomerID
INNER JOIN Sales.Store st ON st.BusinessEntityID = c.StoreID
GROUP BY st.BusinessEntityID, st.Name
ORDER BY COUNT(OrderQty * UnitPrice) DESC)

--Nom des produits qui sont dans le top 2 des catégories
--ayant fait les meilleures ventes
-- Dans un premier temps : on récupère les deux meilleurs catégories
-- Dans un second temps : on affiches les produits qui appartiennent à cette catégorie
-- JOINTURE AVEC SalesOrderDetail
--			ProductID
-- Production.Product 
--			ProductSubCategoryID
-- JOINTURE AVEC Production.ProductSubCategory
--			ProductCategoryID
-- JOINTURE AVEC ProductCategory
SELECT p.Name, cat.Name, ListPrice
FROM Production.Product p
INNER JOIN Production.ProductSubcategory sub ON sub.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Production.ProductCategory cat ON cat.ProductCategoryID = sub.ProductCategoryID
WHERE cat.ProductCategoryID IN (
	SELECT TOP 2 cat.ProductCategoryID
	FROM Sales.SalesOrderDetail sod
	INNER JOIN Production.Product p ON p.ProductID = sod.ProductID
	INNER JOIN Production.ProductSubcategory sub ON sub.ProductSubcategoryID = p.ProductSubcategoryID
	INNER JOIN Production.ProductCategory cat ON cat.ProductCategoryID = sub.ProductCategoryID
	GROUP BY cat.ProductCategoryID, cat.Name
	ORDER BY COUNT(OrderQty * UnitPrice) DESC
)
ORDER BY ListPrice DESC

UPDATE Production.Product
SET ListPrice = ListPrice*0.9
WHERE Color LIKE 'Black'

SELECT Name, ListPrice
FROM Production.Product
WHERE Color LIKE 'Black'
ORDER BY ListPrice DESC

/***
3374,99
3374,99
3374,99
3374,99
2443,35
***/
/***
3037,491
3037,491
3037,491
3037,491
2199,015
2199,015
***/

--On fait une promotion sur les produits des deux meilleurs catégories
UPDATE Production.Product 
SET
ListPrice = ListPrice / 0.75
FROM
Production.Product p
INNER JOIN Production.ProductSubcategory sub ON sub.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Production.ProductCategory cat ON cat.ProductCategoryID = sub.ProductCategoryID
WHERE cat.ProductCategoryID IN (
	SELECT TOP 2 cat.ProductCategoryID
	FROM Sales.SalesOrderDetail sod
	INNER JOIN Production.Product p ON p.ProductID = sod.ProductID
	INNER JOIN Production.ProductSubcategory sub ON sub.ProductSubcategoryID = p.ProductSubcategoryID
	INNER JOIN Production.ProductCategory cat ON cat.ProductCategoryID = sub.ProductCategoryID
	GROUP BY cat.ProductCategoryID, cat.Name
	ORDER BY COUNT(OrderQty * UnitPrice) DESC
)

--On veut ajouter un bonus de 1000€ au 5 meilleurs vendeurs
UPDATE Sales.SalesPerson
SET Bonus = Bonus + 1000
WHERE BusinessEntityID IN (
SELECT TOP 5 SalesPersonID
FROM     Sales.SalesOrderDetail INNER JOIN
         Sales.SalesOrderHeader ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
ORDER BY COUNT(OrderQty * UnitPrice) DESC)

SELECT *
FROM Sales.SalesPerson
WHERE BusinessEntityID IN (
SELECT TOP 5 SalesPersonID
FROM     Sales.SalesOrderDetail INNER JOIN
         Sales.SalesOrderHeader ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
ORDER BY COUNT(OrderQty * UnitPrice) DESC)
FOR XML AUTO

/***
2500,00 -> 3500
2000,00 -> 3000 
4100,00 -> 5100
5150,00 -> 6150
6700,00 -> 7700
***/

SELECT * FROM Production.Product