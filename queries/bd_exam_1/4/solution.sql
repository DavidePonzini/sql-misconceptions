SELECT DISTINCT IdG
FROM GIOCATORE 
WHERE Nazione = 'Germania'
AND IdG NOT IN (SELECT DISTINCT IdG
                                  FROM GIOCAIN NATURAL JOIN TORNEO
                                  WHERE NomeT = 'Wimbledon')
