select cid, transaction.date, transaction.quantity
from transaction natural join product
where product.pName = 'Apples'