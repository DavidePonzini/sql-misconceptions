SELECT matricola,cognome,nome
FROM studenti
WHERE (cognome NOT LIKE 'Serra' AND cognome NOT LIKE 'Melogno' AND cognome NOT LIKE 'Giunchi') 
		OR (residenza LIKE 'Genova' OR residenza LIKE 'La Spezia' OR residenza LIKE 'Savona')
ORDER BY matricola DESC;
