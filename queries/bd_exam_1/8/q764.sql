WITH PlayerAges AS (
    SELECT 
        G.IdG,
        (DATE_PART('year', AGE(CURRENT_DATE, G.DataN))) AS Age
    FROM 
        GIOCATORE G
),
TournamentAvgAges AS (
    SELECT 
        T.IdT,
        T.NomeT,
        AVG(PA.Age) AS AvgAge
    FROM 
        TORNEO T
    JOIN 
        REGISTRAZIONE R ON T.IdT = R.IdT
    JOIN 
        GIOCAIN GI ON R.IdT = GI.IdT AND R.IdCat = GI.IdCat AND R.NumRegistrazione = GI.NumRegistrazione
    JOIN 
        PlayerAges PA ON GI.IdG = PA.IdG
    GROUP BY 
        T.IdT, T.NomeT
)
SELECT 
    NomeT,
    AvgAge
FROM 
    TournamentAvgAges
ORDER BY 
    AvgAge DESC
LIMIT 1;
