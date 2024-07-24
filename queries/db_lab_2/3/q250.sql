SELECT matricola, cognome, nome
FROM unicorsi.studenti
WHERE cognome NOT IN ('Serra', 'Melogno', 'Giunchi') OR luogonascita IN ('Genova', 'La Spezia', 'Savona')
ORDER BY matricola DESC