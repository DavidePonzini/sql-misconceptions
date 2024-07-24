SELECT s.Matricola, s.Cognome, s.Nome
FROM Studenti s
JOIN Esami e1 ON s.Matricola = e1.Studente
JOIN Esami e2 ON s.Matricola = e2.Studente
JOIN Corsi c1 ON e1.Corso = c1.Id
JOIN Corsi c2 ON e2.Corso = c2.Id
WHERE s.CorsoDiLaurea = 9
  AND c1.Denominazione = 'Basi Di Dati 1'
  AND c2.Denominazione = 'Interfacce Grafiche'
  AND e1.Voto >= 18
  AND e2.Voto >= 18
  AND EXTRACT(MONTH FROM e1.Data) = 6
  AND EXTRACT(YEAR FROM e1.Data) = 2010
  AND EXTRACT(MONTH FROM e2.Data) = 6
  AND EXTRACT(YEAR FROM e2.Data) = 2010;
