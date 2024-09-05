SELECT IdT 
FROM giocatore NATURAL JOIN giocain 
NATURAL JOIN registrazione 
NATURAL JOIN torneo 
GROUP BY IdT 
HAVING MAX(AVG(DataN));
