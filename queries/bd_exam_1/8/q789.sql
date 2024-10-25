SELECT DISTINCT ON (t.IdT) t.IdT, t.NomeT, AVG(EXTRACT(YEAR FROM age(g.DataN))) AS avg_age
FROM TORNEO t
JOIN GIOCAIN gi ON t.IdT = gi.IdT
JOIN GIOCATORE g ON gi.IdG = g.IdG
GROUP BY t.IdT, t.NomeT
ORDER BY avg_age DESC, t.IdT;
