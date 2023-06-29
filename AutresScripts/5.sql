use AdventureWorks2017
-- CTE (Common Table Expression)
WITH t1(ID, SodID)
AS
(
	SELECT TOP 3 SalesPersonID, SalesOrderDetail.SalesOrderDetailID
	FROM     Sales.SalesOrderDetail INNER JOIN
			 Sales.SalesOrderHeader ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
	WHERE SalesPersonID IS NOT NULL
	GROUP BY SalesPersonID, SalesOrderDetailID
	ORDER BY COUNT(OrderQty * UnitPrice) DESC
)
SELECT FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID IN (SELECT ID from t1)

-- On veut la liste des ventes qui ont vendus des vélos
-- 1) On récupère les produits de la catégorie vélo
-- 2) On cherche les ventes avec ces produits

WITH T1(ID)
AS
(
	SELECT ProductID
	FROM Production.Product p
	INNER JOIN Production.ProductSubcategory s ON p.ProductSubcategoryID = s.ProductSubcategoryID
	INNER JOIN Production.ProductCategory c ON c.ProductCategoryID = s.ProductCategoryID
	WHERE c.Name = 'Bikes'
)
SELECT *
FROM Sales.SalesOrderDetail
WHERE ProductID IN (SELECT ID FROM T1)

-- Tous les produits des deux meilleurs catégories avec CTE
WITH T1(Cat)
AS
(
	SELECT TOP 2 cat.ProductCategoryID
	FROM Sales.SalesOrderDetail sod
	INNER JOIN Production.Product p ON p.ProductID = sod.ProductID
	INNER JOIN Production.ProductSubcategory sub ON sub.ProductSubcategoryID = p.ProductSubcategoryID
	INNER JOIN Production.ProductCategory cat ON cat.ProductCategoryID = sub.ProductCategoryID
	GROUP BY cat.ProductCategoryID, cat.Name
	ORDER BY COUNT(OrderQty * UnitPrice) DESC
)
SELECT p.Name, cat.Name, ListPrice
FROM Production.Product p
INNER JOIN Production.ProductSubcategory sub ON sub.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Production.ProductCategory cat ON cat.ProductCategoryID = sub.ProductCategoryID
WHERE cat.ProductCategoryID IN (SELECT Cat FROM T1)

--Moyenne des produits vendus par les vendeurs
-- 1) On veut le nombre de produits vendus pour chaque vendeurs
-- 2) On fait la moyenne dessus

WITH T1(Vendeur, NBVentes)
AS
(
	SELECT SalesPersonID, COUNT(*) NBVentes
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
	GROUP BY SalesPersonID
)
SELECT AVG(NbVentes) AS "Moyenne des ventes des vendeurs"
FROM T1

--Moyenne de ventes des produits
WITH AVGProd(NBVentes)
AS
(
	SELECT COUNT(*) NBventes
	FROM Sales.SalesOrderDetail
	WHERE ProductID IS NOT NULL
	GROUP BY ProductID
)
SELECT AVG(Nbventes) AS "Moyenne des ventes des produits"
FROM AVGProd

--CTE Recursif
WITH Semaine(n, weekday)
AS
(
	SELECT 0, DATENAME(DW, 0)
	UNION ALL
	SELECT n+1, DATENAME(DW, n+1)
	FROM Semaine
	WHERE n<6
)
SELECT weekday from Semaine

With Fibo(n1, n2)
AS
(
	SELECT 0, 1
	UNION ALL
	SELECT n2, n1+n2 FROM Fibo
	WHERE n2 <= 55
)
SELECT n1 from Fibo
-- 0 1 1 2 3 5 8 13 21 34

-- Create an Employee table.
CREATE TABLE dbo.MyEmployees
(
EmployeeID SMALLINT NOT NULL,
FirstName NVARCHAR(30) NOT NULL,
LastName NVARCHAR(40) NOT NULL,
Title NVARCHAR(50) NOT NULL,
DeptID SMALLINT NOT NULL,
ManagerID SMALLINT NULL,
CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC),
CONSTRAINT FK_MyEmployees_ManagerID_EmployeeID FOREIGN KEY (ManagerID) REFERENCES dbo.MyEmployees (EmployeeID)
);
-- Populate the table with values.
INSERT INTO dbo.MyEmployees VALUES
(1, N'Ken', N'Sánchez', N'Chief Executive Officer',16, NULL)
,(273, N'Brian', N'Welcker', N'Vice President of Sales', 3, 1)
,(274, N'Stephen', N'Jiang', N'North American Sales Manager', 3, 273)
,(275, N'Michael', N'Blythe', N'Sales Representative', 3, 274)
,(276, N'Linda', N'Mitchell', N'Sales Representative', 3, 274)
,(285, N'Syed', N'Abbas', N'Pacific Sales Manager', 3, 273)
,(286, N'Lynn', N'Tsoflias', N'Sales Representative', 3, 285)
,(16, N'David', N'Bradley', N'Marketing Manager', 4, 273)
,(23, N'Mary', N'Gibson', N'Marketing Specialist', 4, 16);

SELECT * FROM dbo.MyEmployees

--Ken Sanchez (1)
	--Brian Welcker (2)
		--David Bradley (3)
			--Mary Gibson (4)
		--Stephen Jiang (3)
			--Michael Blythe (4)
			--Linda Mitchell (4)
		--Syed Abbas (3)
			--Lynn Tsoflias (4)

WITH Niveau(ManagerID, EmployeeID, FirstName, LastName, EmployeeLevel)
AS
(
	SELECT ManagerID, EmployeeID, FirstName, LastName, 1
	From MyEmployees
	WHERE ManagerID IS NULL

	UNION ALL

	SELECT e.ManagerID, e.EmployeeID, e.FirstName, e.LastName, EmployeeLevel + 1
	FROM MyEmployees e
	INNER JOIN Niveau n ON e.ManagerID = n.EmployeeID
)
SELECT ManagerID, EmployeeID, FirstName, LastName, EmployeeLevel
FROM Niveau

CREATE TABLE dbo.Felins
(
FelinID SMALLINT NOT NULL,
Name NVARCHAR(30) NOT NULL,
ParentID SMALLINT NULL,
CONSTRAINT PK_FelinID PRIMARY KEY CLUSTERED (FelinID ASC),
CONSTRAINT FK_MyEmployees_ParentID_FelinID FOREIGN KEY (ParentID) REFERENCES Felins (FelinID)
);
-- Populate the table with values.
INSERT INTO dbo.Felins VALUES
(1, 'Felidae',NULL),
(2, 'Phanterinae',1),
(3, 'Phanthère',2),
(4, 'Leopard',3),
(5, 'Lion',3),
(6, 'Jaguar',3),
(7, 'Leopard des Neiges',3),
(8, 'Tigre',3),
(9, 'Felinae',1),
(10, 'Acinonyx',9),
(11, 'Hyène',10),
(12, 'Acinonyxa',9),
(13, 'Cougar',12)

-- Table avec les felins et leur niveau
WITH ArbreFelins(FelinID, Name, ParentID, FelinLevel)
AS
(
	SELECT FelinID, Name, ParentID, 1
	FROM Felins
	WHERE ParentID IS NULL

	UNION ALL

	SELECT f.FelinID, f.Name, f.ParentID, FelinLevel +1
	FROM Felins f
	INNER JOIN ArbreFelins a ON a.FelinID = f.ParentID
)
SELECT *
FROM ArbreFelins
ORDER BY FelinLevel

-- On veut récupérer tous les employés qui ont fait moins de 150.000 en vente (table Sales.SalesPerson)
-- Update [HumanResources].[EmployeeDepartmentHistory] et set endate à GETDATE()
WITH Employes(ID) AS
(
	SELECT BusinessEntityID
	FROM Sales.SalesPerson
	WHERE SalesLastYear < 150000
)
UPDATE HumanResources.EmployeeDepartmentHistory
SET EndDate = GETDATE()
FROM HumanResources.EmployeeDepartmentHistory edh
INNER JOIN Employes on Employes.ID = edh.BusinessEntityID
/*
Select FirstName, LastName
from Person.Person
WHERE BusinessEntityID IN (SELECT ID FROM Employes)

Stephen	Jiang
Tete	Mensa-Annan
Syed	Abbas
Amy	Alberts
*/
select * from HumanResources.EmployeeDepartmentHistory
where BusinessEntityID IN (SELECT ID FROM Employes)

--On fait une réduction de 50% sur les produits de la moins bonne sous-categorie avec un cte
WITH Reduction(ID, CA)
AS (
	SELECT TOP 1 s.ProductSubcategoryID, COUNT(sod.OrderQty * sod.UnitPrice) CA
	FROM Sales.SalesOrderDetail sod
	INNER JOIN Production.Product p on p.ProductID = sod.ProductID
	INNER JOIN Production.ProductSubcategory s on p.ProductSubcategoryID = s.ProductSubcategoryID
	INNER JOIN Production.ProductCategory c on c.ProductCategoryID = s.ProductCategoryID
	GROUP BY s.ProductSubcategoryID, s.Name
	ORDER BY CA
)
UPDATE Production.Product
SET ListPrice = ListPrice * 0.5
WHERE ProductSubcategoryID IN (SELECT ID FROM Reduction)
/*
SELECT *
FROM Production.Product p
WHERE p.ProductSubcategoryID IN (SELECT ID FROM Reduction)
*/

SELECT TOP 3 * INTO #t1 from Production.Product WHERE ProductSubcategoryID IS NOT NULL
DROP TABLE #t1
SELECT TOP 5 * INTO #t2 from Production.ProductSubcategory
SELECT * FROM #t1
SELECT * FROM #t2
SELECT * from #t1, #t2

Select * from Production.BillOfMaterials
WHERE BillOfMaterialsID IN (801,92,490,807,995,533)

Select * from Production.Product
WHERE ProductID IN (801,92,490,807,995,533)
--Récupérer tous les composants et sous-composants du produit 801
--L'id du produit -> Component ID
-- Composant parent -> Component ID
-- BOMLevel -> Le niveau auquel il appartient
WITH Composant(ProductAssembly, Component, BomLevel)
AS (
	SELECT ProductAssemblyID, ComponentID, BOMLevel
	FROM Production.BillOfMaterials bom
	WHERE ProductAssemblyID = 801 AND EndDate IS NULL

	UNION ALL

	SELECT ProductAssemblyID, ComponentID,  bom2.BOMLevel
	FROM Production.BillOfMaterials bom2
	INNER JOIN Composant ON Composant.Component = bom2.ProductAssemblyID AND EndDate IS NULL
)
SELECT ProductAssembly, Component, BomLevel
FROM Composant
ORDER BY BomLevel

-- On annule la production du produit 801 et donc de tous ses composants fils -> ENDATE = GETDATE()
-- Modifiez la requête avec le select pour ajouter la date
SELECT * FROM Production.BillOfMaterials

select * from Production.Product where ProductID = 801
select * from Production.BillOfMaterials where ComponentID = 801


WITH Composant(ID, ProductAssembly, Component, BomLevel, EndDate)
AS (
	SELECT BillOfMaterialsID, ProductAssemblyID, ComponentID, BOMLevel, EndDate
	FROM Production.BillOfMaterials bom
	WHERE ComponentID = 801

	UNION ALL

	SELECT BillOfMaterialsID, ProductAssemblyID, ComponentID,  bom2.BOMLevel, bom2.EndDate
	FROM Production.BillOfMaterials bom2
	INNER JOIN Composant ON Composant.Component = bom2.ProductAssemblyID 
)
SELECT *
FROM Production.BillOfMaterials bom
INNER JOIN Composant ON Composant.ID = bom.BillOfMaterialsID

WITH Composant(ID, ProductAssembly, Component, BomLevel, EndDate)
AS (
	SELECT BillOfMaterialsID, ProductAssemblyID, ComponentID, BOMLevel, EndDate
	FROM Production.BillOfMaterials bom
	WHERE ProductAssemblyID = 801 AND EndDate IS NULL

	UNION ALL

	SELECT BillOfMaterialsID, ProductAssemblyID, ComponentID,  bom2.BOMLevel, bom2.EndDate
	FROM Production.BillOfMaterials bom2
	INNER JOIN Composant ON Composant.Component = bom2.ProductAssemblyID AND bom2.EndDate IS NULL
)
UPDATE Production.BillOfMaterials
SET EndDate = GETDATE()
WHERE BillOfMaterialsID IN (SELECT ID FROM Composant)

--Dans un premier temps : On veut récupérer tous les produits (Production.Product) des composants et sous composants du 801

WITH Composant(ID, ProductAssembly, Component, BomLevel, EndDate)
AS (
	SELECT BillOfMaterialsID, ProductAssemblyID, ComponentID, BOMLevel, EndDate
	FROM Production.BillOfMaterials bom
	WHERE ComponentID = 801

	UNION ALL

	SELECT BillOfMaterialsID, ProductAssemblyID, ComponentID,  bom2.BOMLevel, bom2.EndDate
	FROM Production.BillOfMaterials bom2
	INNER JOIN Composant ON Composant.Component = bom2.ProductAssemblyID
)
SELECT DISTINCT s.BusinessEntityID, s.Name
FROM Sales.Store s
INNER JOIN Sales.Customer c ON s.BusinessEntityID = c.StoreID
INNER JOIN Sales.SalesOrderHeader h on h.CustomerID = c.CustomerID
INNER JOIN Sales.SalesOrderDetail d ON d.SalesOrderID = h.SalesOrderID
INNER JOIN Production.Product p ON p.ProductID = d.ProductID
INNER JOIN Composant comp ON comp.Component = p.ProductID

-- ON fait un rappel de produit
	--> On a besoin de connaitre les magasins qui vendent ces produits (Liste des magasins)



	--> On doit contacter les clients qui ont achetés ces produits (Contact des clients)