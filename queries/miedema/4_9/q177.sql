SELECT DISTINCT X.sname FROM store X, store Y
WHERE X.sname=Y.sname AND X.sid!=Y.sid
INTERSECT
SELECT sname FROM store X
WHERE (SELECT AVG(quantity) FROM transaction 
           WHERE sid=X.sid
          )>4