select distinct customer.cid, cus.cid
from customer join customer as cus on customer.street=cus.street
where customer.city!=cus.city;