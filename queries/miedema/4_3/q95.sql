select distinct c1.cid as customer1, c2.cid as customer2
from customer c1 
join customer c2 on c1.street = c2.street and c1.city <> c2.city