SELECT IdT 
FROM 
(SELECT IDT,AVG(DATAN) 
FROM GIOCAIN NATURAL JOIN GIOCATORE GROUP BY IDT)
WHERE AVG(DATAN) = (SELECT MAX(AVG(DATAN) FROM GIOCAIN
NATURAL JOIN GIOCATORE Group By IDT))
