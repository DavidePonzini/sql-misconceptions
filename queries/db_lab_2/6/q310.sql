SELECT DISTINCT s.Cognome, s.Nome
FROM unicorsi.Studenti s
JOIN unicorsi.PianiDiStudio p ON s.Matricola = p.Studente
WHERE p.AnnoAccademico = 2011 AND s.Relatore IS NOT NULL
ORDER BY s.Cognome DESC, s.Nome DESC;