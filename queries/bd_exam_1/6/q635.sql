SELECT IdG
FROM GIOCAIN
GROUP BY IdG
HAVING COUNT(DISTINCT Idt) >> ALL(SELECT COUNT(DISTINCT Idt)
FROM GIOCAIN
GROUP BY IdG)