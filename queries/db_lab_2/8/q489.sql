SELECT DISTINCT s.Matricola, s.Cognome, s.Nome
FROM Studenti s
JOIN Esami e1 ON s.Matricola = e1.Studente
JOIN Corsi c1 ON e1.Corso = c1.Id
WHERE c1.Denominazione = 'Basi Di Dati 1' 
  AND e1.Data BETWEEN '2010-06-01' AND '2010-06-30'
  AND e1.Voto >= 18
  AND NOT EXISTS (
      SELECT 1
      FROM Esami e2
      JOIN Corsi c2 ON e2.Corso = c2.Id
      WHERE e2.Studente = s.Matricola
        AND c2.Denominazione = 'Interfacce Grafiche'
        AND e2.Data BETWEEN '2010-06-01' AND '2010-06-30'
  );
