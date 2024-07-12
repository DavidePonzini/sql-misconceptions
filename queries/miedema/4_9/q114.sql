SELECT sname,
FROM store S1 JOIN transaction T ON S1.sid = T.sid
WHERE sname = ANY(SELECT sname
                                  FROM store S2
                                  WHERE S1.sid <> S2.sid) 
GROUP BY sname
HAVING AVG(quantity)> 4