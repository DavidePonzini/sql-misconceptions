SELECT IdG
FROM TORNEO 
NATURAL JOIN REGISTRAZIONE 
NATURAL JOIN GIOCATORE 
NATURAL JOIN GIOCAIN 
WHERE NomeT = 'US OPEN' 
AND NAZIONE = 'ITALIA'

INTERSECT

SELECT IdG
FROM TORNEO 
NATURAL JOIN REGISTRAZIONE 
NATURAL JOIN GIOCATORE 
NATURAL JOIN GIOCAIN 
WHERE NomeT = 'Australian Open' 
AND NAZIONE = 'ITALIA';