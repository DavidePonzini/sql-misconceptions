select matricola, nome, cognome from studenti
where not (cognome='Serra' and cognome='Melogno' and cognome='Giunchi')
or (residenza='Genova' or residenza='La Spezia' or residenza='Savona')
order by matricola desc;
