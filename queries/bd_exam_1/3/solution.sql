SELECT DISTINCT IdG
FROM GIOCATORE NATURAL JOIN GIOCAIN NATURAL JOIN TORNEO 
WHERE Nazione = 'Italia' AND NomeT = 'US Open'
AND (IdG,YEAR(DataNascita)) IN (SELECT DISTINCT IdG, YEAR(DataNasdcita)
                                  FROM GIOCAIN NATURAL JOIN TORNEO 
                                  WHERE NomeT = 'Australian Open')
