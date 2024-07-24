SELECT DISTINCT s.Matricola
FROM Studenti as s
JOIN CorsiDiLaurea as l ON s.CorsoDiLaurea = l.id
WHERE l.Facolta = 'Informatica' AND s.Laurea < '2009-11-01';