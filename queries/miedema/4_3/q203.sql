select distinct c1.cid, c2.cid
from customer c1, customer c2
where c1.street=c2.street and c1.city<>c2.city;