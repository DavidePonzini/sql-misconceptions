SELECT c.cID, t.tId
FROM transaction t
INNER JOIN customer c ON t.cId=c.cId
INNER JOIN product p ON t.pId = p.pId
WHERE p.pName = 'Apples'