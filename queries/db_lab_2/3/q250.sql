SELECT matricola, cognome, nome
FROM studenti
WHERE cognome NOT IN ('Serra', 'Melogno', 'Giunchi') OR luogonascita IN ('Genova', 'La Spezia', 'Savona')
ORDER BY matricola DESC