SELECT IdT
FROM GIOCAIN
NATURAL JOIN GIOCATORE
GROUP BY IdT
HAVING COUNT(DISTINCT Nazione)
>> ALL(SELECT COUNT(DISTINCT Nazione)
FROM GIOCAIN
NATURAL JOIN GIOCATORE
GROUP BY IdT)