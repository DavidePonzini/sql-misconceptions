SELECT DISTINCT R.IdG
FROM REGISTRAZIONE AS R
JOIN TORNEO 
WHERE NomeT = 'US OPEN' 
AND R.IdG IN (
    SELECT DISTINCT IdG
    FROM REGISTRAZIONE
    JOIN TORNEO
    WHERE NomeT = 'Australian Open' 
    AND REGISTRAZIONE.DataRegistrazione = R.DataRegistrazione
);