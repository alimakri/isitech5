select 1 col1, 'ABC' col2, getdate() col3, newid() col4
-- GUID Global unique identifier

select * into #t1 from
(
select 'A1' lettre, 1 lien
UNION ALL
select 'B1', 2 
UNION ALL
select 'C1', 3 
UNION ALL
select 'D1', 4 
) t

select * into #t2 from
(
select 1 id, 'A2' lettre
UNION ALL
select 2, 'B2'
UNION ALL
select 3, 'C2'
UNION ALL
select 4, 'D2'
) t

select * from #t1
select * from #t2


select * from #t1, #t2


select * from #t1, #t2
where #t1.lien = #t2.id

select * from #t1 
inner join #t2 on #t1.lien = #t2.id
