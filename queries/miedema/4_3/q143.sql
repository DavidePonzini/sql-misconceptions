select c1.cid as Cid1, c2.cid as Cid2
from miedema.customer c1 join miedema.customer c2 on c1.street = c2.street
where c1.city <> c2.city