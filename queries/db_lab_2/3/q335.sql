SELECT matricola, cognome, nome FROM unicorsi.studenti
WHERE cognome!='Serra' OR cognome!='Melogno' OR cognome!='Giunchi' OR residenza='Genova' OR residenza='La Spezia' OR residenza='Savona'
ORDER BY matricola DESC;