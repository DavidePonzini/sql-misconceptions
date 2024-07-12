select distinct transaction.cid, transaction.date, transaction.quantity
from transaction join product on transaction.pid=product.pid
where pname='Apples';