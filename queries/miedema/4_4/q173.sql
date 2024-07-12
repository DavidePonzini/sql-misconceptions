SELECT cid, date, quantity FROM transaction 
JOIN product ON product.pid=transaction.pid 
AND pname='Apples'
Alternativamente al posto di AND si potrebbe usare WHERE come di seguito
SELECT cid, date, quantity FROM transaction 
JOIN product ON product.pid=transaction.pid 
WHERE pname='Apples'