use AdventureWorks2017;
-- CTE

WITH t(id, nom)
AS
(
select ProductID, [Name] from Production.Product
)
select * from t where nom like 'A%'

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

select * from MyEmployees
drop table #t
select EmployeeID, FirstName, LastName, Title, 1 Niveau into #t from MyEmployees where ManagerID is null

select * from #t
select * from MyEmployees

select * from #t
UNION ALL
select e.EmployeeID, e.FirstName, e.LastName, e.Title, #t.Niveau+1 niveau  from MyEmployees e inner join #t on e.ManagerID = #t.EmployeeID


WITH DirectReports(prenom, ManagerID, EmployeeID, Title, EmployeeLevel) AS
(
    SELECT FirstName,ManagerID, EmployeeID, Title, 0 AS EmployeeLevel
    FROM dbo.MyEmployees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.FirstName, e.ManagerID, e.EmployeeID, e.Title, EmployeeLevel + 1
    FROM dbo.MyEmployees AS e
        INNER JOIN DirectReports AS d
        ON e.ManagerID = d.EmployeeID
)
SELECT prenom, ManagerID, EmployeeID, Title, EmployeeLevel
FROM DirectReports
ORDER BY EmployeeLevel;