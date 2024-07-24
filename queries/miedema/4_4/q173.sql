SELECT cid, date, quantity FROM transaction 
JOIN product ON product.pid=transaction.pid 
AND pname='Apples'
