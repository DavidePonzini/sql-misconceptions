select customer.cid 
from customer,customer as C
where C.street=customer.street and c.city <>customer.city