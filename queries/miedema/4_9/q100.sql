select sName
from (
    select sName, count(*)
    from store
    group by sName
    having count(*) >= 2
)
intersection
select sName
from (
    select sName, avg(quantity)
    from store natural join transaction
    group by sName
    having average(quantity) > 4
) 