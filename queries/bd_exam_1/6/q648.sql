SELECT IDT
FROM TORNEO NATURAL JOIN REGISTRAZIONE
ORDER BY IdT
HAVING COUNT(TestaDiSerie = true) >= ALL(SELECT COUNT(TestaDiSerie = true)
FROM REGISTRAZIONE
GROUP BY IDT)