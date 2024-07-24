SELECT DISTINCT S.Matricola, S.Cognome, S.Nome
FROM Studenti S
JOIN Esami E1 ON S.Matricola = E1.Studente
JOIN Esami E2 ON S.Matricola = E2.Studente
JOIN Corsi C1 ON E1.Corso = C1.Id
JOIN Corsi C2 ON E2.Corso = C2.Id
WHERE S.CorsoDiLaurea = 9
  AND C1.Denominazione = 'Basi Di Dati 1'
  AND C2.Denominazione = 'Interfacce Grafiche'
  AND E1.Data BETWEEN '06/01/2010' AND '06/30/2010'
  AND E2.Data BETWEEN '06/01/2010' AND '06/30/2010'
  AND E1.Voto >= 18
  AND E2.Voto >= 18;
