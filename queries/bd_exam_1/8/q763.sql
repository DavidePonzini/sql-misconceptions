WITH PlayerAge AS (
    SELECT G.IdG, G.DataN, EXTRACT(YEAR FROM AGE(CURRENT_DATE, G.DataN)) AS Age
    FROM GIOCATORE G
),
TournamentAverageAge AS (
    SELECT R.IdT, T.NomeT, AVG(PA.Age) AS AvgAge
    FROM GIOCAIN GI
    JOIN REGISTRAZIONE R ON GI.IdT = R.IdT AND GI.IdCat = R.IdCat AND GI.NumRegistrazione = R.NumRegistrazione
    JOIN TORNEO T ON R.IdT = T.IdT
    JOIN PlayerAge PA ON GI.IdG = PA.IdG
    GROUP BY R.IdT, T.NomeT
)
SELECT NomeT, AvgAge
FROM TournamentAverageAge
ORDER BY AvgAge DESC
LIMIT 1;
