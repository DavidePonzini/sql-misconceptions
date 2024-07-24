SELECT DISTINCT s.Cognome, s.Nome
FROM Studenti s
JOIN PianiDiStudio p ON s.Matricola = p.Studente
JOIN CorsiDiLaurea cdl ON s.CorsoDiLaurea = cdl.id
WHERE p.AnnoAccademico = 2011
  AND p.Anno = 5
  AND cdl.Denominazione = 'Informatica'
  AND s.Relatore IS NOT NULL
ORDER BY s.Cognome DESC, s.Nome DESC;
