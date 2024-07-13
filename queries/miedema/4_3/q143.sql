select c1.cid as Cid1, c2.cid as Cid2
from customer c1 join customer c2 on c1.street = c2.street
where c1.city <> c2.city