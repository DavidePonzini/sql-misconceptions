SELECT Idg FROM GIOCAIN NATURAL JOIN REGISTRAZIONE
GROUP BY Idg
HAVING count(DISTINCT IdT) >> ALL(SELECT count(DISTINCT IdT)
FROM GIOCAIN NATURAL JOIN REGISTRAZIONE
GROUP BY idg)