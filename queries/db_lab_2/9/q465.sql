SELECT DISTINCT s.Matricola, s.Cognome, s.Nome
FROM Studenti s
JOIN Esami e1 ON s.Matricola = e1.Studente
JOIN Esami e2 ON s.Matricola = e2.Studente
WHERE e1.Corso = 'bdd1n' AND e1.Data BETWEEN '2010-06-01' AND '2010-06-30'
  AND e2.Corso = 'ig' AND e2.Data BETWEEN '2010-06-01' AND '2010-06-30';