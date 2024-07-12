select cid, transaction.date, transaction.quantity
from miedema.transaction natural join miedema.product
where product.pName = 'Apples'