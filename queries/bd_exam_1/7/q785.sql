WITH SeededCounts AS (
    SELECT r.IdT, COUNT(*) AS num_seeded_players
    FROM REGISTRAZIONE r
    WHERE r.TestaDiSerie = TRUE
    GROUP BY r.IdT
)
SELECT t.IdT, t.NomeT, sc.num_seeded_players
FROM TORNEO t
JOIN SeededCounts sc ON t.IdT = sc.IdT
ORDER BY sc.num_seeded_players DESC
LIMIT 1;
