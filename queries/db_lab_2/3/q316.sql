SELECT matricola, cognome, nome
FROM unicorsi.studenti
WHERE (residenza='Genova' OR residenza='La Spezia' OR residenza='Savona') OR (cognome<>'Serra' AND cognome<>'Melogno' AND cognome<>'Giuchi')
ORDER BY matricola DESC