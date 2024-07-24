SELECT matricola
FROM studenti JOIN CorsiDiLaurea ON Studenti.CorsoDiLaurea = CorsiDiLaurea.id
WHERE Laurea < DATE '01-11-2009';
