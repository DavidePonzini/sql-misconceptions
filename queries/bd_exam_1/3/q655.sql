SELECT DISTINCT IDG
FROM GIOCATORI
WHERE IDG IS IN (SELECT DISTINCT IDG
FROM GIOCAIN NATURAL JOIN ONC)