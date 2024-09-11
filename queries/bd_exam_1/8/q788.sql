WITH AvgAges AS (
    SELECT t.IdT, AVG(EXTRACT(YEAR FROM age(g.DataN))) AS avg_age
    FROM TORNEO t
    JOIN GIOCAIN gi ON t.IdT = gi.IdT
    JOIN GIOCATORE g ON gi.IdG = g.IdG
    GROUP BY t.IdT
)
SELECT t.IdT, t.NomeT, aa.avg_age
FROM TORNEO t
JOIN AvgAges aa ON t.IdT = aa.IdT
ORDER BY aa.avg_age DESC
LIMIT 1;
