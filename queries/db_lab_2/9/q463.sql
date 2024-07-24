SELECT s.Matricola, s.Cognome, s.Nome
FROM Studenti s
JOIN Esami e1 ON s.Matricola = e1.Studente
JOIN Esami e2 ON s.Matricola = e2.Studente
JOIN Corsi c1 ON e1.Corso = c1.Id
JOIN Corsi c2 ON e2.Corso = c2.Id
JOIN CorsiDiLaurea cl ON s.CorsoDiLaurea = cl.id
WHERE cl.Denominazione = 'Informatica'
  AND c1.Denominazione = 'Basi Di Dati 1'
  AND c2.Denominazione = 'Interfacce Grafiche'
  AND e1.Data BETWEEN '06/01/2010' AND '06/30/2010'
  AND e2.Data BETWEEN '06/01/2010' AND '06/30/2010'
  AND e1.Voto >= 18
  AND e2.Voto >= 18;
