SELECT IdG
FROM GIOCAIN
GROUP BY IdG
HAVING COUNT(DISTINCT IdT) >> ALL(SELECT COUNT(DISTINCT idT)
FROM GIOCAIN
GROUP BY IdG)