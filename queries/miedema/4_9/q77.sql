SELECT Store.sName, AVG(quantity) FROM Transaction
INNER JOIN Store USING(sID)
INNER JOIN (SELECT sName, COUNT(*) AS store_count FROM Store GROUP BY sName HAVING COUNT(*) >= 2) AS StoreChain USING(sName)
GROUP BY Store.sName HAVING AVG(quantity) > 4;