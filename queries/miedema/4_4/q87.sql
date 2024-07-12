select customer.cID,date,quantity 
from customer,transaction,product
where pname='Apples'