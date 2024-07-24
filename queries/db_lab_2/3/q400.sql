SELECT matricola, cognome, nome
FROM studenti
WHERE cognome NOT IN('Serra', 'Melogno', 'Giunchi') OR residenza IN('Genova', 'La Spezia', 'Savona')
ORDER BY matricola DESC;