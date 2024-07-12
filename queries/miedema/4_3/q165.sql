select cID
from customer c
where exists (select * from customer where street = c.street)
AND not exists (select * from customer where city = c.city)