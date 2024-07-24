SELECT DISTINCT s.Matricola
FROM unicorsi.Studenti as s
JOIN unicorsi.CorsiDiLaurea as l ON s.CorsoDiLaurea = l.id
WHERE l.Facolta = 'Informatica' AND s.Laurea < '2009-11-01';