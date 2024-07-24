SELECT matricola, cognome, nome
FROM studenti
WHERE
    residenza IN ('Genova', 'La Spezia', 'Savona')
    OR cognome NOT IN ('Serra', 'Melogno', 'Giunchi') 
ORDER BY matricola DESC;