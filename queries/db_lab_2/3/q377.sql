SELECT matricola, nome, cognome FROM studenti WHERE NOT cognome= 'Serra' AND NOT cognome='Melogno' AND NOT cognome='Giunchi' OR residenza='Savona' OR residenza='Genova' OR residenza='La Spezia' ORDER BY matricola DESC;