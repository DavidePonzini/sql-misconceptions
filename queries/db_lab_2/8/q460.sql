SELECT s.Matricola, s.Cognome, s.Nome
FROM Studenti s
JOIN Esami e1 ON s.Matricola = e1.Studente
JOIN Corsi c1 ON e1.Corso = c1.Id
LEFT JOIN Esami e2 ON s.Matricola = e2.Studente AND e2.Corso = 'ig' AND e2.Data BETWEEN '06/01/2010' AND '06/30/2010'
WHERE s.CorsoDiLaurea = 9 -- Assuming 9 is the ID for computer science
AND c1.Denominazione = 'Basi Di Dati 1'
AND e1.Voto >= 18 -- Assuming 18 is the passing grade
AND e1.Data BETWEEN '06/01/2010' AND '06/30/2010'
AND (e2.Voto IS NULL OR e2.Voto < 18); -- Check if the student didn't pass Interfacce Grafiche
