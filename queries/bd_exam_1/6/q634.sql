SELECT DISTINCT IdG
FROM GIOCAIN C
GROUP BY IdG
HAVING COUNT(DISTINCT C.IdT)>=ALL(SELECT COUNT(DISTINCT IdT)
FROM GIOCAIN
GROUP BY IdG)