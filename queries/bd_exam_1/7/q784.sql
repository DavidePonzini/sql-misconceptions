SELECT t.IdT, t.NomeT, COUNT(*) AS num_seeded_players
FROM TORNEO t
JOIN REGISTRAZIONE r ON t.IdT = r.IdT
WHERE r.TestaDiSerie = TRUE
GROUP BY t.IdT, t.NomeT
ORDER BY num_seeded_players DESC
LIMIT 1;
