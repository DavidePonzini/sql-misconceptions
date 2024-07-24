SELECT DISTINCT s.Cognome, s.Nome
FROM Studenti s
JOIN PianiDiStudio p ON s.Matricola = p.Studente
WHERE p.AnnoAccademico = 2011
  AND p.Anno = 5
  AND s.Relatore IS NOT NULL
  AND s.CorsoDiLaurea = 9
ORDER BY s.Cognome DESC, s.Nome DESC;
