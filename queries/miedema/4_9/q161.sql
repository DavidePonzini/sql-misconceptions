SELECT sName FROM Store NATURAL JOIN Transaction
WHERE sName IN (
        SELECT sName FROM Store
        GROUP BY sName
        HAVING COUNT(*) > 1
)
GROUP BY sName 
HAVING AVG(quantity) > 4