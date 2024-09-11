WITH PlayerAges AS (
    SELECT
        GIOCAIN.IdT,
        EXTRACT(YEAR FROM AGE(CURRENT_DATE, G.DataN)) AS Age
    FROM
        GIOCAIN
    JOIN GIOCATORE G ON GIOCAIN.IdG = G.IdG
),
AverageAges AS (
    SELECT
        IdT,
        AVG(Age) AS AvgAge
    FROM
        PlayerAges
    GROUP BY
        IdT
)
SELECT
    T.NomeT,
    T.Luogo,
    AA.AvgAge
FROM
    AverageAges AA
JOIN TORNEO T ON AA.IdT = T.IdT
ORDER BY
    AA.AvgAge DESC
LIMIT 1;
