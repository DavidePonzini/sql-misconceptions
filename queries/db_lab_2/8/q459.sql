SELECT DISTINCT S.Matricola, S.Cognome, S.Nome
FROM Studenti S
JOIN Esami E1 ON S.Matricola = E1.Studente
JOIN Corsi C1 ON E1.Corso = C1.Id
LEFT JOIN Esami E2 ON S.Matricola = E2.Studente AND E2.Corso = 'ig' AND E2.Data BETWEEN '06/01/2010' AND '06/30/2010'
WHERE C1.Denominazione = 'Basi Di Dati 1'
AND E1.Voto >= 18
AND E1.Data BETWEEN '06/01/2010' AND '06/30/2010'
AND E2.Voto IS NULL
AND S.CorsoDiLaurea = 9;
