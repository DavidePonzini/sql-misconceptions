SELECT DISTINCT s.Cognome, s.Nome
FROM Studenti s
JOIN PianiDiStudio pds ON s.Matricola = pds.Studente
JOIN CorsiDiLaurea cdl ON s.CorsoDiLaurea = cdl.id
WHERE cdl.Denominazione = 'Informatica'
  AND s.Relatore IS NOT NULL
  AND pds.AnnoAccademico = 2011
  AND pds.Anno = 5
ORDER BY s.Cognome DESC, s.Nome DESC;
